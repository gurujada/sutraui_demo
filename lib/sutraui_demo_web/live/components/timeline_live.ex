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
              <h4 class="text-sm font-medium">Deployed v2.4</h4>
              <p class="text-sm text-muted-foreground">Pushed to production, all checks green.</p>
            </:item>
            <:item time="4 hours ago">
              <h4 class="text-sm font-medium">Merged PR #342</h4>
              <p class="text-sm text-muted-foreground">
                Refactored auth module for better testability.
              </p>
            </:item>
            <:item time="Yesterday" icon="📝">
              <h4 class="text-sm font-medium">Draft saved</h4>
            </:item>
          </.timeline>
        </div>
      </.component_demo>

      <.section_heading id="custom-markers">Custom Markers</.section_heading>
      <.prose>
        Use
        <.inline_code>icon</.inline_code>
        to replace the dot with text or an emoji. Style it with
        <.inline_code>marker_class</.inline_code>
        .
      </.prose>

      <.component_demo title="Avatar Markers" code={markers_code()}>
        <div class="w-full max-w-md">
          <.timeline>
            <:item
              time="12 min ago"
              icon="A"
              marker_class="bg-primary text-primary-foreground text-xs font-bold"
            >
              <p class="text-sm"><strong>Alex</strong> created a new project</p>
            </:item>
            <:item
              time="1 hour ago"
              icon="S"
              marker_class="bg-secondary text-secondary-foreground text-xs font-bold"
            >
              <p class="text-sm"><strong>Sarah</strong> left a comment</p>
              <div class="mt-2 rounded-md border bg-muted/40 px-3 py-2 text-sm text-muted-foreground">
                Looks good. The empty state copy feels much clearer now.
              </div>
            </:item>
            <:item
              time="3 hours ago"
              icon="M"
              marker_class="bg-destructive text-destructive-foreground text-xs font-bold"
            >
              <p class="text-sm"><strong>Mike</strong> merged PR #342</p>
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
      <:item time="Yesterday" icon="📝">
        <h4>Draft saved</h4>
      </:item>
    </.timeline>\
    """
  end

  defp markers_code do
    """
    <.timeline>
      <:item time="12 min ago" icon="A" marker_class="bg-primary text-primary-foreground text-xs font-bold">
        <p><strong>Alex</strong> created a new project</p>
      </:item>
      <:item time="3 hours ago" icon="M" marker_class="bg-destructive text-destructive-foreground text-xs font-bold">
        <p><strong>Mike</strong> merged PR #342</p>
      </:item>
    </.timeline>\
    """
  end

  defp feed_code do
    """
    <.timeline>
      <:item time="12 min ago">
        <div class="flex items-start gap-3">
          <img src="/avatar.jpg" alt="" class="size-8 rounded-full" />
          <p><strong>Alex Morgan</strong> created <a href="#">Design System</a></p>
        </div>
      </:item>
      <:item time="1 hour ago">
        <div class="flex items-start gap-3">
          <img src="/avatar.jpg" alt="" class="size-8 rounded-full" />
          <p><strong>Sarah Lee</strong> commented on <a href="#">PR #342</a></p>
        </div>
      </:item>
    </.timeline>\
    """
  end
end
