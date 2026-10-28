defmodule SutrauiDemoWeb.Components.ToastLive do
  use SutrauiDemoWeb, :live_view

  alias SutraUI.Toast
  alias SutrauiDemoWeb.Components.ToastPanel

  @upload_id "demo-upload"

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Toast")}
  end

  def handle_event("send", %{"kind" => kind}, socket) do
    kind = String.to_existing_atom(kind)
    Toast.send(kind, message(kind))
    {:noreply, socket}
  end

  def handle_event("titled", _params, socket) do
    Toast.send(:error, "The connection to the server timed out.", title: "Save failed")
    {:noreply, socket}
  end

  def handle_event("upload", _params, socket) do
    Toast.send(:info, "Uploading lesson.mp4...", id: @upload_id, duration: 0)
    Process.send_after(self(), :upload_done, 2000)
    {:noreply, socket}
  end

  def handle_event("delete", _params, socket) do
    Toast.send(:info, "Lesson deleted",
      action: %{label: "Undo", event: "undo"},
      duration: 8000
    )

    {:noreply, socket}
  end

  def handle_event("undo", _params, socket) do
    Toast.send(:success, "Lesson restored")
    {:noreply, socket}
  end

  def handle_event("save_and_redirect", _params, socket) do
    {:noreply,
     socket
     |> Toast.put_toast(:success, "Course published")
     |> push_navigate(to: "/docs/components/toast")}
  end

  def handle_info(:upload_done, socket) do
    Toast.update(@upload_id, kind: :success, body: "Uploaded lesson.mp4", duration: 4000)
    {:noreply, socket}
  end

  defp message(:info), do: "Your draft was saved to this device."
  defp message(:success), do: "Changes saved."
  defp message(:warning), do: "Two learners have no email address."
  defp message(:error), do: "Could not reach the server."

  def render(assigns) do
    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/toast"
    >
      <.docs_header
        title="Toast"
        description="One stack for flashes and server toasts: update in place, undo, and survive a redirect."
      />

      <.callout>
        Put one
        <.inline_code>toast_group</.inline_code>
        in the layout. It shows Phoenix flashes and toasts sent from the server. At most three are visible; older ones fold into "+n more".
      </.callout>

      <.section_heading id="kinds">Kinds</.section_heading>
      <.prose>
        <.inline_code>info</.inline_code>
        and
        <.inline_code>success</.inline_code>
        leave after 5 seconds,
        <.inline_code>warning</.inline_code>
        after 8, and
        <.inline_code>error</.inline_code>
        stays until dismissed. Every toast shows its kind as a word (for screen readers) and an icon. The timer pauses on hover and focus.
      </.prose>

      <.component_demo title="Kinds" code={kinds_code()}>
        <div id="toast-kinds" class="flex flex-wrap gap-3">
          <.button variant="outline" phx-click="send" phx-value-kind="info">Info</.button>
          <.button variant="outline" phx-click="send" phx-value-kind="success">Success</.button>
          <.button variant="outline" phx-click="send" phx-value-kind="warning">Warning</.button>
          <.button variant="outline" phx-click="send" phx-value-kind="error">Error</.button>
          <.button variant="outline" phx-click="titled">With a title</.button>
        </div>
      </.component_demo>

      <.section_heading id="update">Update in place</.section_heading>
      <.prose>
        Give a toast an
        <.inline_code>id</.inline_code>
        and update or dismiss it later. "Uploading..." becomes "Uploaded" in the same place.
      </.prose>

      <.component_demo title="Update in place" code={update_code()}>
        <.button id="start-upload" variant="outline" phx-click="upload">Start upload</.button>
      </.component_demo>

      <.section_heading id="undo">Undo</.section_heading>
      <.prose>
        Reversible actions happen at once and offer Undo. Only the irreversible ones ask first (see <.link
          navigate="/docs/components/confirm"
          class="underline"
        >Confirm</.link>).
        A toast with an action stays until you act; an explicit
        <.inline_code>duration</.inline_code>
        adds a countdown line.
      </.prose>

      <.component_demo title="Undo" code={undo_code()}>
        <.button id="delete-lesson" variant="outline" phx-click="delete">
          <.icon name="lucide-trash-2" class="size-4 mr-2" /> Delete lesson
        </.button>
      </.component_demo>

      <.section_heading id="component">From a LiveComponent</.section_heading>
      <.prose>
        <.inline_code>Toast.send/3</.inline_code>
        works from a LiveView, a LiveComponent or any process (pass <.inline_code>to: pid</.inline_code>).
      </.prose>

      <.component_demo title="From a LiveComponent" code={component_code()}>
        <.live_component module={ToastPanel} id="toast-panel" />
      </.component_demo>

      <.section_heading id="redirect">After a redirect</.section_heading>
      <.prose>
        <.inline_code>put_toast/4</.inline_code>
        queues a toast on a conn or a socket and it survives the redirect, as a flash does.
      </.prose>

      <.component_demo title="put_toast, then navigate" code={redirect_code()}>
        <.button id="save-redirect" variant="outline" phx-click="save_and_redirect">
          Publish and reload the page
        </.button>
      </.component_demo>

      <.section_heading id="flash">Flash messages</.section_heading>
      <.prose>
        <.inline_code>put_flash/3</.inline_code>
        still works and shows in the same stack.
      </.prose>
      <.code_block language="elixir" code={flash_code()} />

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          <.inline_code>corner</.inline_code>
          is one of six positions (bottom right by default); on phones the group is full width at the bottom.
        </.list_item>
        <.list_item>
          Keep toasts clear of your own bars with
          <.inline_code>--toast-offset-bottom</.inline_code>
          and <.inline_code>--toast-offset-top</.inline_code>.
        </.list_item>
        <.list_item>
          A "Can't reach the server" notice appears 3 seconds after a disconnect and goes away on reconnect.
        </.list_item>
        <.list_item>
          <.inline_code>toast_container/1</.inline_code>
          and the old
          <.inline_code>push_event(socket, "toast", ...)</.inline_code>
          are deprecated; use <.inline_code>Toast.send/3</.inline_code>.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp kinds_code do
    """
    alias SutraUI.Toast

    Toast.send(:success, "Changes saved.")
    Toast.send(:error, "Could not reach the server.", title: "Save failed")\
    """
  end

  defp update_code do
    """
    Toast.send(:info, "Uploading lesson.mp4...", id: "upload", duration: 0)

    # later, from the same process or another one
    Toast.update("upload", kind: :success, body: "Uploaded lesson.mp4", duration: 4000)
    Toast.dismiss("upload")\
    """
  end

  defp undo_code do
    """
    Toast.send(:info, "Lesson deleted",
      action: %{label: "Undo", event: "undo"},
      duration: 8000
    )

    def handle_event("undo", _params, socket) do
      Toast.send(:success, "Lesson restored")
      {:noreply, socket}
    end\
    """
  end

  defp component_code do
    """
    # inside a LiveComponent
    def handle_event("notify", _params, socket) do
      SutraUI.Toast.send(:info, "Sent from a LiveComponent")
      {:noreply, socket}
    end

    # from any other process
    SutraUI.Toast.send(:info, "Export ready", to: liveview_pid)\
    """
  end

  defp redirect_code do
    """
    {:noreply,
     socket
     |> SutraUI.Toast.put_toast(:success, "Course published")
     |> push_navigate(to: ~p"/courses")}

    # or on a conn
    conn |> SutraUI.Toast.put_toast(:success, "Saved") |> redirect(to: ~p"/courses")\
    """
  end

  defp flash_code do
    """
    # layout
    <.toast_group flash={@flash} live />

    # LiveView
    {:noreply, put_flash(socket, :info, "Operation completed!")}\
    """
  end
end
