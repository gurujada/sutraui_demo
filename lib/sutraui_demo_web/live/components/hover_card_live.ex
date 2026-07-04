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
        title="Profile Preview"
        code={profile_code()}
        class="[&_.demo-preview]:min-h-[260px]"
      >
        <.hover_card id="user-hover-card">
          <:trigger>
            <span class="text-primary underline-offset-4 hover:underline">@sutra_ui</span>
          </:trigger>
          <div class="space-y-3">
            <div class="flex items-center gap-3">
              <div class="flex size-10 items-center justify-center rounded-full bg-primary text-sm font-semibold text-primary-foreground">
                SU
              </div>
              <div>
                <p class="text-sm font-medium text-foreground">Sutra UI</p>
                <p class="text-xs text-muted-foreground">@sutra_ui</p>
              </div>
            </div>
            <p class="text-sm leading-relaxed text-muted-foreground">
              Phoenix LiveView components with CSS-first styling and colocated hooks.
            </p>
            <div class="flex gap-4 text-xs text-muted-foreground">
              <span><strong class="text-foreground">56</strong> Components</span>
              <span><strong class="text-foreground">Full</strong> test suite</span>
              <span><strong class="text-foreground">0</strong> JS deps</span>
            </div>
          </div>
        </.hover_card>
      </.component_demo>

      <.section_heading id="positioning">Positioning</.section_heading>
      <.prose>
        Use
        <.inline_code>side</.inline_code>
        and
        <.inline_code>align</.inline_code>
        to control where the card appears relative to the trigger. Set
        <.inline_code>side="auto"</.inline_code>
        for viewport-aware placement that flips when space is tight.
      </.prose>

      <.component_demo
        title="Top Start"
        code={top_code()}
        class="[&_.demo-preview]:min-h-[260px] [&_.demo-preview]:items-end"
      >
        <.hover_card id="release-hover-card" side="top" align="start">
          <:trigger>
            <span class="text-primary underline-offset-4 hover:underline">Release notes</span>
          </:trigger>
          <div class="space-y-2">
            <p class="text-sm font-medium text-foreground">v0.4.0</p>
            <p class="text-sm text-muted-foreground">
              Includes new display primitives, runtime hooks, and docs updates.
            </p>
          </div>
        </.hover_card>
      </.component_demo>

      <.section_heading id="link-preview">Link Preview</.section_heading>
      <.prose>
        Hover cards work well for previewing where a link goes — show the page
        title and a snippet without requiring a click.
      </.prose>

      <.component_demo
        title="Link Preview"
        code={link_code()}
        class="[&_.demo-preview]:min-h-[260px]"
      >
        <.hover_card id="link-hover-card" side="right" align="start">
          <:trigger>
            <a
              href="/docs/components/hover-card"
              class="text-primary underline-offset-4 hover:underline"
            >
              the hover card docs
            </a>
          </:trigger>
          <div class="space-y-2">
            <p class="text-sm font-medium text-foreground">Hover Card</p>
            <p class="text-sm text-muted-foreground">
              Reveals rich preview content on hover or keyboard focus. Reuses
              the shared popover positioning system.
            </p>
          </div>
        </.hover_card>
      </.component_demo>

      <.section_heading id="delays">Open And Close Delays</.section_heading>
      <.prose>
        Tune
        <.inline_code>open_delay</.inline_code>
        and
        <.inline_code>close_delay</.inline_code>
        (milliseconds) to control how quickly the card appears and disappears.
        A longer open delay prevents flicker when scanning a list of triggers.
      </.prose>

      <.component_demo
        title="Slower Open Delay"
        code={delays_code()}
        class="[&_.demo-preview]:min-h-[260px]"
      >
        <.hover_card id="delayed-hover-card" open_delay={500} close_delay={200}>
          <:trigger>
            <span class="text-primary underline-offset-4 hover:underline">Hover slowly (500ms)</span>
          </:trigger>
          <div class="space-y-2">
            <p class="text-sm font-medium text-foreground">Delayed open</p>
            <p class="text-sm text-muted-foreground">
              This card waits 500ms before appearing — useful for dense lists
              where instant opens would be distracting.
            </p>
          </div>
        </.hover_card>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp profile_code do
    """
    <.hover_card id="user-hover-card">
      <:trigger><span>@sutra_ui</span></:trigger>
      <div class="space-y-3">
        <div class="flex items-center gap-3">
          <div class="size-10 rounded-full bg-primary text-primary-foreground">SU</div>
          <div>
            <p>Sutra UI</p>
            <p>@sutra_ui</p>
          </div>
        </div>
        <p>Phoenix LiveView components with CSS-first styling.</p>
      </div>
    </.hover_card>\
    """
  end

  defp top_code do
    """
    <.hover_card id="release-hover-card" side="top" align="start">
      <:trigger>Release notes</:trigger>
      <div>
        <p>v0.4.0</p>
        <p>Includes new display primitives, runtime hooks, and docs updates.</p>
      </div>
    </.hover_card>\
    """
  end

  defp link_code do
    """
    <.hover_card id="link-hover-card" side="right" align="start">
      <:trigger><a href="/docs/components/hover-card">the hover card docs</a></:trigger>
      <div>
        <p>Hover Card</p>
        <p>Reveals rich preview content on hover or keyboard focus.</p>
      </div>
    </.hover_card>\
    """
  end

  defp delays_code do
    """
    <.hover_card id="delayed-hover-card" open_delay={500} close_delay={200}>
      <:trigger>Hover slowly (500ms)</:trigger>
      <div>
        <p>Delayed open</p>
        <p>Useful for dense lists where instant opens would be distracting.</p>
      </div>
    </.hover_card>\
    """
  end
end
