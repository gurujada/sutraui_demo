defmodule SutrauiDemoWeb.Components.HoverCardLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Hover Card")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/hover-card">
      <.docs_header
        title="Hover Card"
        description="Reveals rich preview content on hover or keyboard focus."
      />

      <.component_demo
        title="Default"
        code={default_code()}
        class="[&_.demo-preview]:min-h-[220px]"
      >
        <.hover_card id="user-hover-card">
          <:trigger>
            <button class="btn-ghost">@sutra_ui</button>
          </:trigger>
          <div class="space-y-3">
            <div class="flex items-center gap-3">
              <div
                class="flex size-10 items-center justify-center rounded-full text-sm font-semibold"
                style="background: var(--primary); color: var(--primary-foreground);"
              >
                SU
              </div>
              <div>
                <p class="text-sm font-medium" style="color: var(--fg);">Sutra UI</p>
                <p class="text-xs" style="color: var(--fg-muted);">@sutra_ui</p>
              </div>
            </div>
            <p class="text-sm leading-relaxed" style="color: var(--fg-muted);">
              Phoenix LiveView components with CSS-first styling and colocated hooks.
            </p>
          </div>
        </.hover_card>
      </.component_demo>

      <.section_heading id="positioning">Positioning</.section_heading>
      <.component_demo
        title="Top Aligned"
        code={positioning_code()}
        class="[&_.demo-preview]:min-h-[220px] [&_.demo-preview]:items-end"
      >
        <.hover_card id="release-hover-card" side="top" align="start">
          <:trigger>
            <button class="btn-outline">Release notes</button>
          </:trigger>
          <div class="space-y-2">
            <p class="text-sm font-medium" style="color: var(--fg);">v0.3.0</p>
            <p class="text-sm" style="color: var(--fg-muted);">
              Includes new display primitives, runtime hooks, and docs updates.
            </p>
          </div>
        </.hover_card>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.hover_card id="user-hover-card">
      <:trigger><button>@sutra_ui</button></:trigger>
      <p>Sutra UI builds Phoenix LiveView components.</p>
    </.hover_card>\
    """
  end

  defp positioning_code do
    """
    <.hover_card id="release-hover-card" side="top" align="start">
      <:trigger><button>Release notes</button></:trigger>
      <p>v0.3.0 includes new components.</p>
    </.hover_card>\
    """
  end
end
