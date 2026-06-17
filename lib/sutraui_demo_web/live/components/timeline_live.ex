defmodule SutrauiDemoWeb.Components.TimelineLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Timeline")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/timeline">
      <.docs_header
        title="Timeline"
        description="A vertical list of chronological events with connecting lines."
      />

      <.component_demo title="Default" code={default_code()}>
        <div class="w-full max-w-md">
          <.timeline>
            <:item time="12 min ago" state="current">
              <h3 class="text-sm font-medium" style="color: var(--fg);">Deployed v2.4</h3>
              <p class="text-sm" style="color: var(--fg-muted);">
                Pushed to production, all checks green.
              </p>
            </:item>
            <:item time="1 hour ago" state="complete">
              <h3 class="text-sm font-medium" style="color: var(--fg);">Merged PR #342</h3>
              <p class="text-sm" style="color: var(--fg-muted);">
                Refactored auth module for better testability.
              </p>
            </:item>
            <:item time="2 hours ago">
              <div class="flex items-center gap-2">
                <div
                  class="size-5 rounded-full flex items-center justify-center text-[10px] font-bold"
                  style="background: var(--primary); color: var(--primary-foreground);"
                >
                  J
                </div>
                <span class="text-sm font-medium" style="color: var(--fg);">
                  Jess opened a new issue
                </span>
              </div>
              <p class="text-sm ml-7" style="color: var(--fg-muted);">
                Button color contrast on mobile
              </p>
            </:item>
          </.timeline>
        </div>
      </.component_demo>

      <.section_heading id="with-icons">Custom Markers</.section_heading>
      <.prose>
        Use the
        <.inline_code>icon</.inline_code>
        slot attr for custom marker content.
      </.prose>

      <.component_demo title="Custom Markers" code={icons_code()}>
        <div class="w-full max-w-md">
          <.timeline>
            <:item icon="📝" time="Today" state="current">
              <h3 class="text-sm font-medium" style="color: var(--fg);">Draft saved</h3>
            </:item>
            <:item icon="✓" time="Yesterday" state="complete">
              <h3 class="text-sm font-medium" style="color: var(--fg);">Review completed</h3>
            </:item>
            <:item icon="🚀" time="Monday" state="complete">
              <h3 class="text-sm font-medium" style="color: var(--fg);">Launched v2.0</h3>
            </:item>
          </.timeline>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.timeline>
      <:item time="12 min ago" state="current">
        <h3>Deployed v2.4</h3>
      </:item>
      <:item time="1 hour ago" state="complete">
        <h3>Merged PR #342</h3>
      </:item>
      <:item time="2 hours ago">
        <div class="flex items-center gap-2">
          <div>J</div>
          <span>Jess opened an issue</span>
        </div>
      </:item>
    </.timeline>\
    """
  end

  defp icons_code do
    """
    <.timeline>
      <:item icon="📝" time="Today" state="current"><h3>Draft saved</h3></:item>
      <:item icon="✓" time="Yesterday" state="complete"><h3>Review completed</h3></:item>
      <:item icon="🚀" time="Monday" state="complete"><h3>Launched v2.0</h3></:item>
    </.timeline>\
    """
  end
end
