defmodule SutrauiDemoWeb.Components.ConfirmLive do
  use SutrauiDemoWeb, :live_view

  alias SutraUI.Toast

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Confirm", show_host: false, log: [])}
  end

  def handle_event("archive", _params, socket) do
    Toast.send(:success, "Archived 12 lessons")
    {:noreply, socket}
  end

  def handle_event("send", params, socket) do
    Toast.send(:success, "Sent to 80 learners: #{params["subject"]}")
    {:noreply, socket}
  end

  def handle_event("retire", params, socket) do
    Toast.send(:success, "Retired course #{params["course_id"]}")
    {:noreply, socket}
  end

  def handle_event("remove_member", params, socket) do
    reason = if params["reason"] in [nil, ""], do: "no reason given", else: params["reason"]
    Toast.send(:info, "Asha removed (#{reason})")
    {:noreply, socket}
  end

  def handle_event("open_host", _params, socket), do: {:noreply, assign(socket, :show_host, true)}

  def handle_event("cancel_host", _params, socket),
    do: {:noreply, assign(socket, :show_host, false)}

  def handle_event("delete_host", _params, socket) do
    Toast.send(:success, "Workbook deleted")
    {:noreply, assign(socket, :show_host, false)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/confirm"
    >
      <.docs_header
        title="Confirm"
        description="One question, a distinct verb, and nothing drawn by the browser."
      />

      <.callout>
        Confirm only what cannot be undone. Anything reversible acts at once and offers Undo in a <.link
          navigate="/docs/components/toast"
          class="underline"
        >toast</.link>.
        These dialogs are div-based, so they stay visible in a screen share, and the page behind is inert.
      </.callout>

      <.section_heading id="data-confirm">data-confirm</.section_heading>
      <.prose>
        Put
        <.inline_code>&lt;.confirm_host /&gt;</.inline_code>
        in the layout once. Every element with
        <.inline_code>data-confirm</.inline_code>
        then opens the styled dialog instead of <.inline_code>window.confirm()</.inline_code>.
        The click is caught before LiveView sees it and replayed on the verb.
      </.prose>

      <.component_demo title="Button, link and form" code={data_confirm_code()}>
        <div class="w-full space-y-5">
          <div class="flex flex-wrap items-center gap-3">
            <.button
              id="archive-button"
              variant="outline"
              phx-click="archive"
              data-confirm="Archive 12 lessons? Learners can still open them."
              data-confirm-title="Archive these lessons?"
              data-confirm-verb="Archive"
              data-confirm-tone="primary"
            >
              Button (primary tone)
            </.button>

            <.link
              id="delete-link"
              href="/docs/components/confirm"
              class="text-sm underline"
              data-confirm="This deletes the course and its 40 learner records."
              data-confirm-title="Delete this course?"
              data-confirm-verb="Delete"
            >
              Link (danger tone)
            </.link>
          </div>

          <form
            id="send-form"
            phx-submit="send"
            class="flex flex-wrap items-end gap-3"
            data-confirm="This emails every learner in the cohort."
            data-confirm-title="Send to all 80 learners?"
            data-confirm-verb="Send"
            data-confirm-tone="primary"
          >
            <.input id="send-subject" name="subject" label="Subject" value="Class moved to 6 pm" />
            <.button type="submit" id="send-button" class="mb-5">Send to everyone</.button>
          </form>
        </div>
      </.component_demo>

      <.section_heading id="confirm-dialog">confirm_dialog</.section_heading>
      <.prose>
        Write the question in HEEx and open it with <.inline_code>SutraUI.open_confirm/1</.inline_code>.
        Focus starts on Keep for a danger action; Escape means Keep; focus returns to the trigger.
        <.inline_code>values</.inline_code>
        arrive as event params and the inner block holds extra fields.
      </.prose>

      <.component_demo title="A dialog you write" code={dialog_code()}>
        <div class="flex flex-wrap gap-3">
          <.button
            id="retire-trigger"
            variant="outline"
            phx-click={SutraUI.open_confirm("retire-confirm")}
          >
            Retire course
          </.button>
          <.button
            id="remove-trigger"
            variant="outline"
            phx-click={SutraUI.open_confirm("remove-confirm")}
          >
            Remove member
          </.button>
        </div>

        <.confirm_dialog
          id="retire-confirm"
          title="Retire this course?"
          consequence="Learners keep their certificates; nobody can start it again."
          confirm="Retire"
          event="retire"
          values={%{"course_id" => "physics-101"}}
        />

        <.confirm_dialog
          id="remove-confirm"
          title="Remove Asha?"
          consequence="She loses access today."
          confirm="Remove"
          event="remove_member"
        >
          <.input id="remove-reason" name="reason" label="Reason (optional)" value="" />
        </.confirm_dialog>
      </.component_demo>

      <.section_heading id="host-controlled">Host-controlled</.section_heading>
      <.prose>
        Pass
        <.inline_code>show</.inline_code>
        and
        <.inline_code>on_cancel</.inline_code>
        to let the LiveView hold the open state. Keep, Escape and the backdrop push <.inline_code>on_cancel</.inline_code>.
      </.prose>

      <.component_demo title="Host-controlled" code={host_code()}>
        <.button id="host-trigger" variant="destructive" phx-click="open_host">Delete workbook</.button>
        <.confirm_dialog
          id="host-confirm"
          title="Delete this workbook?"
          consequence="Its 3 sections and 40 submissions are removed for everyone."
          confirm="Delete"
          event="delete_host"
          show={@show_host}
          on_cancel="cancel_host"
        />
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          The dialog is an <.inline_code>alertdialog</.inline_code>: it names the action, says what happens in one line and offers "Keep it" next to a verb ("Delete", "Retire"), never "OK".
        </.list_item>
        <.list_item>
          Without a host on the page,
          <.inline_code>data-confirm</.inline_code>
          keeps phoenix_html's own browser prompt.
        </.list_item>
        <.list_item>
          In LiveView tests
          <.inline_code>data-confirm</.inline_code>
          is ignored, so clicks go straight through; use
          <.inline_code>SutraUI.Confirm.Test.confirm/2</.inline_code>
          to run the verb of a <.inline_code>confirm_dialog</.inline_code>.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp data_confirm_code do
    """
    <%!-- once in the layout --%>
    <.confirm_host />

    <button phx-click="archive" data-confirm="Archive 12 lessons?"
            data-confirm-title="Archive these lessons?" data-confirm-verb="Archive"
            data-confirm-tone="primary">Archive</button>

    <.link href={~p"/courses/\#{@course}"} method="delete"
           data-confirm="This deletes the course." data-confirm-title="Delete this course?"
           data-confirm-verb="Delete">Delete</.link>

    <.form for={@form} phx-submit="send" data-confirm="This emails every learner."
           data-confirm-title="Send to all 80 learners?" data-confirm-verb="Send">...</.form>\
    """
  end

  defp dialog_code do
    """
    <.button phx-click={SutraUI.open_confirm("retire-confirm")}>Retire</.button>

    <.confirm_dialog
      id="retire-confirm"
      title="Retire this course?"
      consequence="Learners keep their certificates; nobody can start it again."
      confirm="Retire"
      event="retire"
      values={%{"course_id" => @course.id}}
    />

    <.confirm_dialog id="remove-confirm" title="Remove Asha?" consequence="She loses access today."
                     confirm="Remove" event="remove_member">
      <.input name="reason" label="Reason (optional)" value="" />
    </.confirm_dialog>\
    """
  end

  defp host_code do
    """
    <.confirm_dialog
      id="host-confirm"
      title="Delete this workbook?"
      consequence="Its sections and submissions are removed for everyone."
      confirm="Delete"
      event="delete_workbook"
      show={@show_confirm}
      on_cancel="cancel_confirm"
    />\
    """
  end
end
