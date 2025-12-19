defmodule SutrauiDemoWeb.Components.ToastLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Toast")}
  end

  def handle_event("show-toast", %{"variant" => variant}, socket) do
    title =
      case variant do
        "default" -> "Notification"
        "success" -> "Success!"
        "destructive" -> "Error"
      end

    {:noreply,
     push_event(socket, "toast", %{
       variant: variant,
       title: title,
       description: "This is a #{variant} toast message.",
       duration: 5000
     })}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/toast">
      <.docs_header
        title="Toast"
        description="Temporary notification messages. Can be flash-based or programmatic."
      />

      <.component_demo title="Programmatic Toast" code={programmatic_code()}>
        <div class="flex flex-wrap gap-4">
          <.button phx-click="show-toast" phx-value-variant="default">
            Show Toast
          </.button>
          <.button phx-click="show-toast" phx-value-variant="success" variant="outline">
            Success Toast
          </.button>
          <.button phx-click="show-toast" phx-value-variant="destructive" variant="destructive">
            Error Toast
          </.button>
        </div>
      </.component_demo>

      <.section_heading id="flash-based">Flash-based Toasts</.section_heading>
      <.prose>
        Toasts can also be triggered via Phoenix flash messages. The toast container
        automatically displays
        <.inline_code>:info</.inline_code>
        and
        <.inline_code>:error</.inline_code>
        flash messages.
      </.prose>

      <.code_block language="elixir" code={flash_code()} />

      <.section_heading id="programmatic">Programmatic Toasts</.section_heading>
      <.prose>
        For more control, use
        <.inline_code>push_event/3</.inline_code>
        to show toasts
        programmatically:
      </.prose>

      <.code_block language="elixir" code={push_event_code()} />

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          Flash-based toasts are cleared on navigation or when dismissed.
        </.list_item>
        <.list_item>
          Programmatic toasts auto-dismiss after the specified duration.
          Set
          <.inline_code>duration: 0</.inline_code>
          to disable auto-dismiss.
        </.list_item>
        <.list_item>
          Toasts use
          <.inline_code>role="status"</.inline_code>
          and
          <.inline_code>aria-live="polite"</.inline_code>
          for accessibility.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp programmatic_code do
    """
    <.button phx-click="show-toast">Show Toast</.button>

    # In your LiveView:
    def handle_event("show-toast", _, socket) do
      {:noreply,
       push_event(socket, "toast", %{
         variant: "success",
         title: "Success!",
         description: "Your changes have been saved.",
         duration: 5000
       })}
    end\
    """
  end

  defp flash_code do
    """
    # In your LiveView:
    {:noreply, put_flash(socket, :info, "Operation completed!")}\
    """
  end

  defp push_event_code do
    """
    push_event(socket, "toast", %{
      variant: "success",    # "default", "success", or "destructive"
      title: "Success!",
      description: "Your changes have been saved.",
      duration: 5000         # milliseconds, 0 = no auto-dismiss
    })\
    """
  end
end
