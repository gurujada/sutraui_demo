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
        description="A vertical list of chronological events with dot markers and connector lines."
      />

      <.component_demo title="Basic" code={basic_code()}>
        <div class="w-full max-w-md">
          <.timeline>
            <:item time="2 hours ago">
              <h4>Deployed v2.4</h4>
              <p>Pushed to production, all checks green.</p>
            </:item>
            <:item time="4 hours ago">
              <h4>Merged PR #342</h4>
              <p>Refactored auth module for better testability.</p>
            </:item>
            <:item time="Yesterday">
              <h4>Draft saved</h4>
              <p>Auto-save captured the latest edits.</p>
            </:item>
          </.timeline>
        </div>
      </.component_demo>

      <.section_heading id="icons">Icon Markers</.section_heading>
      <.prose>
        Pass an
        <.inline_code>icon</.inline_code>
        slot attr to replace the default dot with text or an emoji.
      </.prose>

      <.component_demo title="Icon Markers" code={icons_code()}>
        <div class="w-full max-w-md">
          <.timeline>
            <:item time="2 hours ago" icon="🚀">
              <h4>Deployed v2.4</h4>
              <p>Pushed to production, all checks green.</p>
            </:item>
            <:item time="Yesterday" icon="📝">
              <h4>Draft saved</h4>
            </:item>
            <:item time="3 days ago" icon="✅">
              <h4>Tests passing</h4>
              <p>All component checks are green on CI.</p>
            </:item>
          </.timeline>
        </div>
      </.component_demo>

      <.section_heading id="custom-markers">Custom Markers</.section_heading>
      <.prose>
        Use the
        <.inline_code>:marker</.inline_code>
        slot when the marker itself needs custom markup, animation, or status
        styling.
      </.prose>

      <.component_demo title="Custom Markers" code={markers_code()}>
        <div class="w-full max-w-md">
          <.timeline>
            <:marker>
              <span class="timeline-marker-icon">
                <span class="size-2 rounded-full bg-primary animate-pulse"></span>
              </span>
            </:marker>
            <:item time="Now">
              <h4>Deploy running</h4>
              <p>Release job is currently publishing assets.</p>
            </:item>
            <:item time="5 min ago">
              <h4>Build started</h4>
              <p>CI picked up the latest commit.</p>
            </:item>
          </.timeline>
        </div>
      </.component_demo>

      <.section_heading id="activity">Activity Items</.section_heading>
      <.prose>
        Put avatars, badges, links, or any other markup inside the
        <.inline_code>:item</.inline_code>
        slot. The timeline keeps the marker and connector consistent while your
        content owns the event layout.
      </.prose>

      <.component_demo title="Activity Items" code={activity_code()}>
        <div class="w-full max-w-md">
          <.timeline>
            <:item time="12 min ago">
              <div class="flex items-start gap-3">
                <span class="flex size-8 shrink-0 items-center justify-center rounded-full bg-primary text-xs font-bold text-primary-foreground">
                  A
                </span>
                <p><strong>Alex</strong> created a new project</p>
              </div>
            </:item>
            <:item time="1 hour ago">
              <div class="flex items-start gap-3">
                <span class="flex size-8 shrink-0 items-center justify-center rounded-full bg-secondary text-xs font-bold text-secondary-foreground">
                  S
                </span>
                <div>
                  <p><strong>Sarah</strong> left a comment</p>
                  <div class="mt-2 rounded-md border bg-muted/40 px-3 py-2 text-sm text-muted-foreground">
                    Looks good. The empty state copy feels much clearer now.
                  </div>
                </div>
              </div>
            </:item>
            <:item time="3 hours ago">
              <div class="flex items-start gap-3">
                <span class="flex size-8 shrink-0 items-center justify-center rounded-full bg-destructive text-xs font-bold text-destructive-foreground">
                  M
                </span>
                <p><strong>Mike</strong> merged PR #342</p>
              </div>
            </:item>
          </.timeline>
        </div>
      </.component_demo>

      <.section_heading id="rich-content">Rich Content</.section_heading>
      <.prose>
        Drop avatars, links, cards, or any markup into each
        <.inline_code>:item</.inline_code>
        slot. The timeline provides the chrome — you own the content.
      </.prose>

      <.component_demo title="Activity Feed" code={feed_code()}>
        <div class="w-full max-w-lg">
          <.timeline>
            <:item time="12 min ago">
              <div class="flex items-start gap-3">
                <img
                  src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=64&h=64&fit=crop&crop=face"
                  alt=""
                  class="size-8 rounded-full"
                />
                <div>
                  <p class="text-sm">
                    <strong>Alex Morgan</strong>
                    created
                    <a href="#" class="font-medium text-primary hover:underline">Design System</a>
                  </p>
                  <p class="text-sm text-muted-foreground">Added the initial component checklist.</p>
                </div>
              </div>
            </:item>
            <:item time="1 hour ago">
              <div class="flex items-start gap-3">
                <img
                  src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=64&h=64&fit=crop&crop=face"
                  alt=""
                  class="size-8 rounded-full"
                />
                <div>
                  <p class="text-sm">
                    <strong>Sarah Lee</strong>
                    commented on
                    <a href="#" class="font-medium text-primary hover:underline">PR #342</a>
                  </p>
                  <div class="mt-2 rounded-md border bg-muted/40 px-3 py-2 text-sm text-muted-foreground">
                    Looks good. The empty state copy feels much clearer now.
                  </div>
                </div>
              </div>
            </:item>
            <:item time="3 hours ago">
              <div class="flex items-start gap-3">
                <img
                  src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=64&h=64&fit=crop&crop=face"
                  alt=""
                  class="size-8 rounded-full"
                />
                <div>
                  <p class="text-sm">
                    <strong>Mike Ross</strong>
                    merged <a href="#" class="font-medium text-primary hover:underline">PR #342</a>
                  </p>
                  <p class="text-sm text-muted-foreground">
                    Refactored the auth module and updated tests.
                  </p>
                </div>
              </div>
            </:item>
          </.timeline>
        </div>
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          The timeline is a pure CSS component — no JavaScript hook. The
          connector line is a flex element that stretches to fill the marker
          column.
        </.list_item>
        <.list_item>
          The marker and connector line are
          <.inline_code>aria-hidden</.inline_code>
          — they're decorative. The timestamp uses a semantic
          <.inline_code>&lt;time&gt;</.inline_code>
          element.
        </.list_item>
        <.list_item>
          The
          <.inline_code>icon</.inline_code>
          slot attr replaces the default dot with text or an emoji. Without it,
          a subtle bordered dot is shown.
        </.list_item>
        <.list_item>
          The
          <.inline_code>:marker</.inline_code>
          slot replaces the full marker for every item and receives the current
          item attrs.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.timeline>
      <:item time="2 hours ago">
        <h4>Deployed v2.4</h4>
        <p>Pushed to production, all checks green.</p>
      </:item>
      <:item time="4 hours ago">
        <h4>Merged PR #342</h4>
        <p>Refactored auth module for better testability.</p>
      </:item>
      <:item time="Yesterday">
        <h4>Draft saved</h4>
        <p>Auto-save captured the latest edits.</p>
      </:item>
    </.timeline>\
    """
  end

  defp icons_code do
    """
    <.timeline>
      <:item time="2 hours ago" icon="🚀">
        <h4>Deployed v2.4</h4>
        <p>Pushed to production, all checks green.</p>
      </:item>
      <:item time="Yesterday" icon="📝">
        <h4>Draft saved</h4>
      </:item>
      <:item time="3 days ago" icon="✅">
        <h4>Tests passing</h4>
        <p>All component checks are green on CI.</p>
      </:item>
    </.timeline>\
    """
  end

  defp markers_code do
    """
    <.timeline>
      <:marker>
        <span class="timeline-marker-icon">
          <span class="size-2 rounded-full bg-primary animate-pulse"></span>
        </span>
      </:marker>
      <:item time="Now">
        <h4>Deploy running</h4>
        <p>Release job is currently publishing assets.</p>
      </:item>
      <:item time="5 min ago">
        <h4>Build started</h4>
        <p>CI picked up the latest commit.</p>
      </:item>
    </.timeline>\
    """
  end

  defp activity_code do
    """
    <.timeline>
      <:item time="12 min ago">
        <div class="flex items-start gap-3">
          <span class="flex size-8 shrink-0 items-center justify-center rounded-full bg-primary text-xs font-bold text-primary-foreground">A</span>
          <p><strong>Alex</strong> created a new project</p>
        </div>
      </:item>
      <:item time="1 hour ago">
        <div class="flex items-start gap-3">
          <span class="flex size-8 shrink-0 items-center justify-center rounded-full bg-secondary text-xs font-bold text-secondary-foreground">S</span>
          <div>
            <p><strong>Sarah</strong> left a comment</p>
            <div class="mt-2 rounded-md border bg-muted/40 px-3 py-2 text-sm text-muted-foreground">
              Looks good. The empty state copy feels much clearer now.
            </div>
          </div>
        </div>
      </:item>
      <:item time="3 hours ago">
        <div class="flex items-start gap-3">
          <span class="flex size-8 shrink-0 items-center justify-center rounded-full bg-destructive text-xs font-bold text-destructive-foreground">M</span>
          <p><strong>Mike</strong> merged PR #342</p>
        </div>
      </:item>
    </.timeline>\
    """
  end

  defp feed_code do
    """
    <.timeline>
      <:item time="12 min ago">
        <div class="flex items-start gap-3">
          <img
            src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=64&h=64&fit=crop&crop=face"
            alt=""
            class="size-8 rounded-full"
          />
          <div>
            <p class="text-sm">
              <strong>Alex Morgan</strong>
              created
              <a href="#" class="font-medium text-primary hover:underline">Design System</a>
            </p>
            <p class="text-sm text-muted-foreground">Added the initial component checklist.</p>
          </div>
        </div>
      </:item>
      <:item time="1 hour ago">
        <div class="flex items-start gap-3">
          <img
            src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=64&h=64&fit=crop&crop=face"
            alt=""
            class="size-8 rounded-full"
          />
          <div>
            <p class="text-sm">
              <strong>Sarah Lee</strong>
              commented on
              <a href="#" class="font-medium text-primary hover:underline">PR #342</a>
            </p>
            <div class="mt-2 rounded-md border bg-muted/40 px-3 py-2 text-sm text-muted-foreground">
              Looks good. The empty state copy feels much clearer now.
            </div>
          </div>
        </div>
      </:item>
      <:item time="3 hours ago">
        <div class="flex items-start gap-3">
          <img
            src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=64&h=64&fit=crop&crop=face"
            alt=""
            class="size-8 rounded-full"
          />
          <div>
            <p class="text-sm">
              <strong>Mike Ross</strong>
              merged <a href="#" class="font-medium text-primary hover:underline">PR #342</a>
            </p>
            <p class="text-sm text-muted-foreground">
              Refactored the auth module and updated tests.
            </p>
          </div>
        </div>
      </:item>
    </.timeline>\
    """
  end
end
