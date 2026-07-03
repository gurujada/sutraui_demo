defmodule SutrauiDemoWeb.Components.ActivityLive do
  use SutrauiDemoWeb, :live_view

  @activity_max_frame 8
  @custom_max_frame 8
  @compact_max_frame 5

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Activity",
       activity_frame: 0,
       activity_playing: false,
       activity_run_id: nil,
       activity_events: activity_events(0),
       custom_frame: 0,
       custom_playing: false,
       custom_run_id: nil,
       custom_events: custom_events(0),
       compact_frame: 0,
       compact_playing: false,
       compact_run_id: nil,
       compact_events: compact_events(0)
     )}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/activity">
      <.docs_header
        title="Activity"
        description="Show safe user-facing progress for agent work, jobs, and background tasks."
      />

      <.prose>
        Keep activity rows in your LiveView assigns or streams, then render the
        visible rows. The component owns the progress chrome; your app owns the
        agent, job, or workflow events.
      </.prose>

      <.component_demo title="Agent Activity" code={activity_code()}>
        <div
          id="agent-activity-demo"
          class="grid w-full max-w-lg gap-4 rounded-lg border bg-card p-5 shadow-xs"
          phx-hook=".ActivityDemo"
          data-start-event="start_activity_demo"
          data-pause-event="pause_activity_demo"
          data-playing={to_string(@activity_playing)}
          data-complete={to_string(@activity_frame >= activity_max_frame())}
        >
          <.activity>
            <:item
              :for={event <- @activity_events}
              id={event.id}
              status={event.status}
            >
              <div class="flex min-w-0 items-center justify-between gap-3">
                <span class="min-w-0 truncate text-sm font-medium text-foreground">
                  {event.title}
                </span>
                <span :if={event.meta} class="shrink-0 text-xs text-muted-foreground">
                  {event.meta}
                </span>
              </div>
              <p class="mt-1 text-sm leading-6 text-muted-foreground">{event.detail}</p>
            </:item>
          </.activity>

          <.button type="button" size="sm" variant="outline" phx-click="replay_activity">
            Replay
          </.button>
        </div>

        <script :type={Phoenix.LiveView.ColocatedHook} name=".ActivityDemo">
          export default {
            mounted() {
              this.startEvent = this.el.dataset.startEvent;
              this.pauseEvent = this.el.dataset.pauseEvent;
              this.visible = false;
              this.observer = new IntersectionObserver((entries) => {
                const visible = entries.some((entry) => entry.isIntersecting);

                if (visible && !this.visible && !this.isComplete() && !this.isPlaying()) {
                  this.visible = true;
                  this.pushEvent(this.startEvent, {});
                } else if (!visible && this.visible && this.isPlaying()) {
                  this.visible = false;
                  this.pushEvent(this.pauseEvent, {});
                } else if (!visible) {
                  this.visible = false;
                }
              }, { threshold: 0.2 });

              this.observer.observe(this.el);
            },

            destroyed() {
              if (this.observer) this.observer.disconnect();
            },

            isPlaying() {
              return this.el.dataset.playing === "true";
            },

            isComplete() {
              return this.el.dataset.complete === "true";
            }
          }
        </script>
      </.component_demo>

      <.section_heading id="customization">Customization</.section_heading>
      <.prose>
        Use the
        <.inline_code>:item</.inline_code>
        slot for most rows. Add a root
        <.inline_code>:marker</.inline_code>
        slot when every streamed row should use custom marker chrome.
      </.prose>

      <.component_demo title="Custom Markers" code={custom_code()}>
        <div
          id="custom-activity-demo"
          class="grid w-full max-w-lg gap-4 rounded-lg border bg-card p-5 shadow-xs"
          phx-hook=".ActivityDemo"
          data-start-event="start_custom_activity_demo"
          data-pause-event="pause_custom_activity_demo"
          data-playing={to_string(@custom_playing)}
          data-complete={to_string(@custom_frame >= custom_max_frame())}
        >
          <.activity>
            <:marker :let={item}>
              <span class={custom_marker_class(item[:status])}>
                <.icon
                  name={custom_marker_icon(item[:status])}
                  class={custom_marker_icon_class(item[:status])}
                />
              </span>
            </:marker>

            <:item :for={event <- @custom_events} id={event.id} status={event.status}>
              <div class="flex min-w-0 items-center justify-between gap-3">
                <span class="min-w-0 truncate text-sm font-medium text-foreground">
                  {event.title}
                </span>
                <span :if={event.meta} class="shrink-0 text-xs text-muted-foreground">
                  {event.meta}
                </span>
              </div>
              <p class="mt-1 text-sm leading-6 text-muted-foreground">{event.detail}</p>
            </:item>
          </.activity>

          <.button type="button" size="sm" variant="outline" phx-click="replay_custom_activity">
            Replay
          </.button>
        </div>
      </.component_demo>

      <.section_heading id="compact">Compact</.section_heading>
      <.prose>
        Set
        <.inline_code>compact</.inline_code>
        for side panels, popovers, and dense job surfaces where the same status
        list needs less vertical space.
      </.prose>

      <.component_demo title="Compact" code={compact_code()}>
        <div
          id="compact-activity-demo"
          class="grid w-full max-w-md gap-4 rounded-lg border bg-card p-5 shadow-xs"
          phx-hook=".ActivityDemo"
          data-start-event="start_compact_activity_demo"
          data-pause-event="pause_compact_activity_demo"
          data-playing={to_string(@compact_playing)}
          data-complete={to_string(@compact_frame >= compact_max_frame())}
        >
          <.activity compact>
            <:item
              :for={event <- @compact_events}
              id={event.id}
              status={event.status}
            >
              <div class="flex min-w-0 items-center justify-between gap-3">
                <span class="min-w-0 truncate font-medium">{event.title}</span>
                <span :if={event.meta} class="shrink-0 text-xs text-muted-foreground">
                  {event.meta}
                </span>
              </div>
            </:item>
          </.activity>

          <.button type="button" size="sm" variant="outline" phx-click="replay_compact_activity">
            Replay
          </.button>
        </div>
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          Activity is a status list, not a transcript. Keep private reasoning
          out of the rows and show safe progress such as searches, jobs, and
          verification steps.
        </.list_item>
        <.list_item>
          Keep the visible rows in assigns or LiveView streams. Inserted rows
          fade in with CSS, and the animation is disabled when reduced motion is
          requested.
        </.list_item>
        <.list_item>
          The root list gets a default <.inline_code>aria-label="Activity"</.inline_code>. Pass your own
          label only when the surrounding page needs a more specific name.
        </.list_item>
        <.list_item>
          Reach for
          <.inline_code>activity_item/1</.inline_code>
          only when one row needs markup that cannot fit the shared
          <.inline_code>:item</.inline_code>
          and
          <.inline_code>:marker</.inline_code>
          slots.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  def handle_event("start_activity_demo", _params, socket) do
    if socket.assigns.activity_playing or socket.assigns.activity_frame >= activity_max_frame() do
      {:noreply, socket}
    else
      {:noreply,
       socket |> pause_custom_activity() |> pause_compact_activity() |> resume_activity()}
    end
  end

  def handle_event("pause_activity_demo", _params, socket) do
    {:noreply, pause_activity(socket)}
  end

  def handle_event("replay_activity", _params, socket) do
    {:noreply, socket |> pause_custom_activity() |> pause_compact_activity() |> start_activity()}
  end

  def handle_event("start_custom_activity_demo", _params, socket) do
    if socket.assigns.custom_playing or socket.assigns.custom_frame >= custom_max_frame() do
      {:noreply, socket}
    else
      {:noreply,
       socket |> pause_activity() |> pause_compact_activity() |> resume_custom_activity()}
    end
  end

  def handle_event("pause_custom_activity_demo", _params, socket) do
    {:noreply, pause_custom_activity(socket)}
  end

  def handle_event("replay_custom_activity", _params, socket) do
    {:noreply, socket |> pause_activity() |> pause_compact_activity() |> start_custom_activity()}
  end

  def handle_event("start_compact_activity_demo", _params, socket) do
    if socket.assigns.compact_playing or socket.assigns.compact_frame >= compact_max_frame() do
      {:noreply, socket}
    else
      {:noreply,
       socket |> pause_activity() |> pause_custom_activity() |> resume_compact_activity()}
    end
  end

  def handle_event("pause_compact_activity_demo", _params, socket) do
    {:noreply, pause_compact_activity(socket)}
  end

  def handle_event("replay_compact_activity", _params, socket) do
    {:noreply, socket |> pause_activity() |> pause_custom_activity() |> start_compact_activity()}
  end

  def handle_info({:activity_tick, run_id}, %{assigns: %{activity_run_id: run_id}} = socket) do
    next_frame = min(socket.assigns.activity_frame + 1, activity_max_frame())

    socket =
      socket
      |> assign_activity(next_frame, next_frame < activity_max_frame(), run_id)

    if next_frame < activity_max_frame(), do: schedule_tick(run_id)

    {:noreply, socket}
  end

  def handle_info({:custom_activity_tick, run_id}, %{assigns: %{custom_run_id: run_id}} = socket) do
    next_frame = min(socket.assigns.custom_frame + 1, custom_max_frame())

    socket =
      socket
      |> assign_custom_activity(next_frame, next_frame < custom_max_frame(), run_id)

    if next_frame < custom_max_frame(), do: schedule_custom_tick(run_id)

    {:noreply, socket}
  end

  def handle_info(
        {:compact_activity_tick, run_id},
        %{assigns: %{compact_run_id: run_id}} = socket
      ) do
    next_frame = min(socket.assigns.compact_frame + 1, compact_max_frame())

    socket =
      socket
      |> assign_compact_activity(next_frame, next_frame < compact_max_frame(), run_id)

    if next_frame < compact_max_frame(), do: schedule_compact_tick(run_id)

    {:noreply, socket}
  end

  def handle_info({:activity_tick, _stale_run_id}, socket), do: {:noreply, socket}
  def handle_info({:custom_activity_tick, _stale_run_id}, socket), do: {:noreply, socket}
  def handle_info({:compact_activity_tick, _stale_run_id}, socket), do: {:noreply, socket}

  defp activity_max_frame, do: @activity_max_frame
  defp custom_max_frame, do: @custom_max_frame
  defp compact_max_frame, do: @compact_max_frame

  defp start_activity(socket) do
    run_id = System.unique_integer([:positive])
    schedule_tick(run_id)

    assign_activity(socket, 0, true, run_id)
  end

  defp resume_activity(socket) do
    run_id = System.unique_integer([:positive])
    schedule_tick(run_id)

    assign_activity(socket, socket.assigns.activity_frame, true, run_id)
  end

  defp pause_activity(socket) do
    assign_activity(socket, socket.assigns.activity_frame, false, nil)
  end

  defp assign_activity(socket, frame, playing, run_id) do
    assign(socket,
      activity_frame: frame,
      activity_playing: playing,
      activity_run_id: run_id,
      activity_events: activity_events(frame)
    )
  end

  defp schedule_tick(run_id), do: Process.send_after(self(), {:activity_tick, run_id}, 650)

  defp start_custom_activity(socket) do
    run_id = System.unique_integer([:positive])
    schedule_custom_tick(run_id)

    assign_custom_activity(socket, 0, true, run_id)
  end

  defp resume_custom_activity(socket) do
    run_id = System.unique_integer([:positive])
    schedule_custom_tick(run_id)

    assign_custom_activity(socket, socket.assigns.custom_frame, true, run_id)
  end

  defp pause_custom_activity(socket) do
    assign_custom_activity(socket, socket.assigns.custom_frame, false, nil)
  end

  defp assign_custom_activity(socket, frame, playing, run_id) do
    assign(socket,
      custom_frame: frame,
      custom_playing: playing,
      custom_run_id: run_id,
      custom_events: custom_events(frame)
    )
  end

  defp schedule_custom_tick(run_id) do
    Process.send_after(self(), {:custom_activity_tick, run_id}, 700)
  end

  defp start_compact_activity(socket) do
    run_id = System.unique_integer([:positive])
    schedule_compact_tick(run_id)

    assign_compact_activity(socket, 0, true, run_id)
  end

  defp resume_compact_activity(socket) do
    run_id = System.unique_integer([:positive])
    schedule_compact_tick(run_id)

    assign_compact_activity(socket, socket.assigns.compact_frame, true, run_id)
  end

  defp pause_compact_activity(socket) do
    assign_compact_activity(socket, socket.assigns.compact_frame, false, nil)
  end

  defp assign_compact_activity(socket, frame, playing, run_id) do
    assign(socket,
      compact_frame: frame,
      compact_playing: playing,
      compact_run_id: run_id,
      compact_events: compact_events(frame)
    )
  end

  defp schedule_compact_tick(run_id) do
    Process.send_after(self(), {:compact_activity_tick, run_id}, 550)
  end

  defp activity_events(frame) do
    for index <- 0..4, visible_step?(frame, index) do
      %{
        id: "agent-activity-#{index}",
        title: activity_title(index),
        status: activity_status(frame, index),
        meta: activity_meta(frame, index),
        detail: activity_detail(frame, index)
      }
    end
  end

  defp visible_step?(frame, 0), do: frame >= 0
  defp visible_step?(frame, 1), do: frame >= 1
  defp visible_step?(frame, 2), do: frame >= 3
  defp visible_step?(frame, 3), do: frame >= 5
  defp visible_step?(frame, 4), do: frame >= 6

  defp activity_title(0), do: "Read request"
  defp activity_title(1), do: "Check component API"
  defp activity_title(2), do: "Fetch reference"
  defp activity_title(3), do: "Update demo"
  defp activity_title(4), do: "Verify docs"

  defp activity_status(frame, 0) when frame < 2, do: "running"
  defp activity_status(_frame, 0), do: "complete"

  defp activity_status(frame, 1) when frame < 2, do: "pending"
  defp activity_status(frame, 1) when frame < 4, do: "running"
  defp activity_status(_frame, 1), do: "complete"

  defp activity_status(frame, 2) when frame < 4, do: "pending"
  defp activity_status(frame, 2) when frame < 5, do: "running"
  defp activity_status(_frame, 2), do: "error"

  defp activity_status(frame, 3) when frame < 6, do: "pending"
  defp activity_status(frame, 3) when frame < 7, do: "running"
  defp activity_status(_frame, 3), do: "complete"

  defp activity_status(frame, 4) when frame < 7, do: "pending"
  defp activity_status(frame, 4) when frame < 8, do: "running"
  defp activity_status(_frame, 4), do: "complete"

  defp activity_meta(frame, index) do
    case activity_status(frame, index) do
      "pending" -> nil
      "running" -> "now"
      "error" -> "blocked"
      "complete" -> "#{(index + 1) * 120} ms"
    end
  end

  defp activity_detail(frame, 0) when frame < 1, do: "Reading the request."
  defp activity_detail(frame, 0) when frame < 2, do: "Reading the request and constraints."
  defp activity_detail(_frame, 0), do: "Captured the component constraints."

  defp activity_detail(frame, 1) when frame < 2, do: "Queued."
  defp activity_detail(frame, 1) when frame < 3, do: "Comparing props."
  defp activity_detail(frame, 1) when frame < 4, do: "Comparing props with LiveView patterns."
  defp activity_detail(_frame, 1), do: "Kept reveal as the visual control."

  defp activity_detail(frame, 2) when frame < 4, do: "Queued."
  defp activity_detail(frame, 2) when frame < 5, do: "Opening reference."
  defp activity_detail(_frame, 2), do: "Reference unavailable, continued with local evidence."

  defp activity_detail(frame, 3) when frame < 6, do: "Queued."
  defp activity_detail(frame, 3) when frame < 7, do: "Streaming step updates from the LiveView."
  defp activity_detail(_frame, 3), do: "Demo starts when it enters view."

  defp activity_detail(frame, 4) when frame < 7, do: "Queued."
  defp activity_detail(frame, 4) when frame < 8, do: "Checking docs and tests."
  defp activity_detail(_frame, 4), do: "Ready for verification."

  defp custom_events(frame) do
    for index <- 0..3, custom_visible_step?(frame, index) do
      %{
        id: "custom-activity-#{index}",
        title: custom_title(index),
        status: custom_status(frame, index),
        meta: custom_meta(frame, index),
        detail: custom_detail(frame, index)
      }
    end
  end

  defp custom_visible_step?(frame, 0), do: frame >= 0
  defp custom_visible_step?(frame, 1), do: frame >= 2
  defp custom_visible_step?(frame, 2), do: frame >= 4
  defp custom_visible_step?(frame, 3), do: frame >= 6

  defp custom_title(0), do: "Search docs"
  defp custom_title(1), do: "Read source"
  defp custom_title(2), do: "Patch component"
  defp custom_title(3), do: "Run checks"

  defp custom_status(frame, 0) when frame < 2, do: "running"
  defp custom_status(_frame, 0), do: "complete"

  defp custom_status(frame, 1) when frame < 4, do: "running"
  defp custom_status(_frame, 1), do: "complete"

  defp custom_status(frame, 2) when frame < 6, do: "running"
  defp custom_status(_frame, 2), do: "complete"

  defp custom_status(frame, 3) when frame < 8, do: "running"
  defp custom_status(_frame, 3), do: "complete"

  defp custom_meta(frame, index) do
    case custom_status(frame, index) do
      "running" -> "now"
      "complete" -> "#{(index + 2) * 90} ms"
      _status -> nil
    end
  end

  defp custom_detail(frame, 0) when frame < 1, do: "Finding the right examples."
  defp custom_detail(frame, 0) when frame < 2, do: "Finding the right examples and constraints."
  defp custom_detail(_frame, 0), do: "Found the component patterns."

  defp custom_detail(frame, 1) when frame < 3, do: "Opening the implementation."
  defp custom_detail(frame, 1) when frame < 4, do: "Checking slots, attrs, and CSS hooks."
  defp custom_detail(_frame, 1), do: "Kept the API slot-driven."

  defp custom_detail(frame, 2) when frame < 5, do: "Updating the row markup."
  defp custom_detail(frame, 2) when frame < 6, do: "Updating the row markup and marker slot."
  defp custom_detail(_frame, 2), do: "Custom marker chrome is in place."

  defp custom_detail(frame, 3) when frame < 7, do: "Running focused checks."
  defp custom_detail(frame, 3) when frame < 8, do: "Running docs and component checks."
  defp custom_detail(_frame, 3), do: "Ready."

  defp custom_marker_class("complete") do
    "grid size-7 place-items-center rounded-full bg-emerald-500/15 text-emerald-600 ring-4 ring-background"
  end

  defp custom_marker_class("running") do
    "grid size-7 place-items-center rounded-full bg-primary/15 text-primary ring-4 ring-background"
  end

  defp custom_marker_class("error") do
    "grid size-7 place-items-center rounded-full bg-destructive/15 text-destructive ring-4 ring-background"
  end

  defp custom_marker_class(_status) do
    "grid size-7 place-items-center rounded-full bg-muted text-muted-foreground ring-4 ring-background"
  end

  defp custom_marker_icon("complete"), do: "lucide-check"
  defp custom_marker_icon("running"), do: "lucide-loader-circle"
  defp custom_marker_icon("error"), do: "lucide-triangle-alert"
  defp custom_marker_icon(_status), do: "lucide-circle"

  defp custom_marker_icon_class("running"), do: "size-4 animate-spin"
  defp custom_marker_icon_class(_status), do: "size-4"

  defp compact_events(frame) do
    for index <- 0..2, compact_visible_step?(frame, index) do
      %{
        id: "compact-activity-#{index}",
        title: compact_title(index),
        status: compact_status(frame, index),
        meta: compact_meta(frame, index)
      }
    end
  end

  defp compact_visible_step?(frame, 0), do: frame >= 0
  defp compact_visible_step?(frame, 1), do: frame >= 2
  defp compact_visible_step?(frame, 2), do: frame >= 4

  defp compact_title(0), do: "Queued export"
  defp compact_title(1), do: "Generating CSV"
  defp compact_title(2), do: "Send email"

  defp compact_status(frame, 0) when frame < 2, do: "running"
  defp compact_status(_frame, 0), do: "complete"

  defp compact_status(frame, 1) when frame < 4, do: "running"
  defp compact_status(_frame, 1), do: "complete"

  defp compact_status(frame, 2) when frame < 5, do: "running"
  defp compact_status(_frame, 2), do: "complete"

  defp compact_meta(frame, index) do
    case compact_status(frame, index) do
      "running" -> "now"
      "complete" -> "#{(index + 1) * 80} ms"
      _status -> nil
    end
  end

  defp activity_code do
    """
    <.activity>
      <:item :for={event <- @activity_events} id={event.id} status={event.status}>
        <div class="flex min-w-0 items-center justify-between gap-3">
          <span class="min-w-0 truncate text-sm font-medium text-foreground">
            {event.title}
          </span>
          <span :if={event.meta} class="shrink-0 text-xs text-muted-foreground">
            {event.meta}
          </span>
        </div>
        <p class="mt-1 text-sm leading-6 text-muted-foreground">{event.detail}</p>
      </:item>
    </.activity>\
    """
  end

  defp custom_code do
    """
    <.activity>
      <:marker :let={item}>
        <span class={custom_marker_class(item[:status])}>
          <.icon
            name={custom_marker_icon(item[:status])}
            class={custom_marker_icon_class(item[:status])}
          />
        </span>
      </:marker>

      <:item :for={event <- @custom_events} id={event.id} status={event.status}>
        <div class="flex min-w-0 items-center justify-between gap-3">
          <span class="min-w-0 truncate text-sm font-medium text-foreground">
            {event.title}
          </span>
          <span :if={event.meta} class="shrink-0 text-xs text-muted-foreground">
            {event.meta}
          </span>
        </div>
        <p class="mt-1 text-sm leading-6 text-muted-foreground">{event.detail}</p>
      </:item>
    </.activity>\
    """
  end

  defp compact_code do
    """
    <.activity compact>
      <:item :for={event <- @compact_events} id={event.id} status={event.status}>
        <div class="flex min-w-0 items-center justify-between gap-3">
          <span class="min-w-0 truncate font-medium">{event.title}</span>
          <span :if={event.meta} class="shrink-0 text-xs text-muted-foreground">
            {event.meta}
          </span>
        </div>
      </:item>
    </.activity>\
    """
  end
end
