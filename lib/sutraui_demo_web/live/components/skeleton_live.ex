defmodule SutrauiDemoWeb.Components.SkeletonLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Skeleton")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/skeleton">
      <.docs_header
        title="Skeleton"
        description="A placeholder component to show while content is loading."
      />

      <.component_demo title="Default" code={~s|<.skeleton class="h-5 w-[200px]" />|}>
        <.skeleton class="h-5 w-[200px]" />
      </.component_demo>

      <.section_heading id="text-lines">Text Lines</.section_heading>
      <.prose>
        Use multiple skeletons to simulate text content.
      </.prose>

      <.component_demo title="Text Lines" code={text_lines_code()}>
        <div class="space-y-2">
          <.skeleton class="h-4 w-full" />
          <.skeleton class="h-4 w-[90%]" />
          <.skeleton class="h-4 w-[75%]" />
        </div>
      </.component_demo>

      <.section_heading id="avatar">Avatar</.section_heading>
      <.prose>
        Use
        <.inline_code>radius="full"</.inline_code>
        to create circular skeleton placeholders.
      </.prose>

      <.component_demo title="Avatar" code={avatar_code()}>
        <div class="flex items-center gap-4">
          <.skeleton class="size-10" radius="full" />
          <div class="space-y-2">
            <.skeleton class="h-3.5 w-[120px]" />
            <.skeleton class="h-3 w-[80px]" />
          </div>
        </div>
      </.component_demo>

      <.section_heading id="card">Card Layout</.section_heading>
      <.prose>
        Combine skeletons to create placeholder layouts for complex components.
      </.prose>

      <.component_demo title="Card Layout" code={card_code()}>
        <div
          class="p-4 rounded-lg border space-y-4"
          style="background: var(--bg-elevated); border-color: var(--border);"
        >
          <.skeleton class="h-[150px] w-full" />
          <div class="space-y-2">
            <.skeleton class="h-5 w-[60%]" />
            <.skeleton class="h-3.5 w-full" />
            <.skeleton class="h-3.5 w-[80%]" />
          </div>
          <div class="flex gap-2">
            <.skeleton class="h-8 w-20" />
            <.skeleton class="h-8 w-20" />
          </div>
        </div>
      </.component_demo>

      <.section_heading id="radius">Radius Options</.section_heading>
      <.prose>
        The
        <.inline_code>radius</.inline_code>
        prop controls the border radius of the skeleton.
      </.prose>

      <.component_demo title="Radius" code={radius_code()}>
        <div class="flex flex-wrap gap-4">
          <div class="text-center space-y-2">
            <.skeleton class="size-20" radius="none" />
            <span class="text-xs" style="color: var(--fg-muted);">none</span>
          </div>
          <div class="text-center space-y-2">
            <.skeleton class="size-20" radius="sm" />
            <span class="text-xs" style="color: var(--fg-muted);">sm</span>
          </div>
          <div class="text-center space-y-2">
            <.skeleton class="size-20" radius="md" />
            <span class="text-xs" style="color: var(--fg-muted);">md</span>
          </div>
          <div class="text-center space-y-2">
            <.skeleton class="size-20" radius="lg" />
            <span class="text-xs" style="color: var(--fg-muted);">lg</span>
          </div>
          <div class="text-center space-y-2">
            <.skeleton class="size-20" radius="full" />
            <span class="text-xs" style="color: var(--fg-muted);">full</span>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="list">List Example</.section_heading>
      <.prose>
        A common pattern for loading list items.
      </.prose>

      <.component_demo title="List" code={list_code()}>
        <div class="space-y-4">
          <div :for={_ <- 1..3} class="flex items-center gap-4">
            <.skeleton class="size-12" />
            <div class="flex-1 space-y-2">
              <.skeleton class="h-4 w-[40%]" />
              <.skeleton class="h-3 w-[70%]" />
            </div>
            <.skeleton class="h-7 w-[60px]" />
          </div>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp text_lines_code do
    """
    <div class="space-y-2">
      <.skeleton class="h-4 w-full" />
      <.skeleton class="h-4 w-[90%]" />
      <.skeleton class="h-4 w-[75%]" />
    </div>\
    """
  end

  defp avatar_code do
    """
    <div class="flex items-center gap-4">
      <.skeleton class="size-10" radius="full" />
      <div class="space-y-2">
        <.skeleton class="h-3.5 w-[120px]" />
        <.skeleton class="h-3 w-[80px]" />
      </div>
    </div>\
    """
  end

  defp card_code do
    """
    <div class="p-4 rounded-lg border space-y-4">
      <.skeleton class="h-[150px] w-full" />
      <div class="space-y-2">
        <.skeleton class="h-5 w-[60%]" />
        <.skeleton class="h-3.5 w-full" />
        <.skeleton class="h-3.5 w-[80%]" />
      </div>
      <div class="flex gap-2">
        <.skeleton class="h-8 w-20" />
        <.skeleton class="h-8 w-20" />
      </div>
    </div>\
    """
  end

  defp radius_code do
    """
    <.skeleton class="size-20" radius="none" />
    <.skeleton class="size-20" radius="sm" />
    <.skeleton class="size-20" radius="md" />
    <.skeleton class="size-20" radius="lg" />
    <.skeleton class="size-20" radius="full" />\
    """
  end

  defp list_code do
    """
    <div :for={_ <- 1..3} class="flex items-center gap-4">
      <.skeleton class="size-12" />
      <div class="flex-1 space-y-2">
        <.skeleton class="h-4 w-[40%]" />
        <.skeleton class="h-3 w-[70%]" />
      </div>
      <.skeleton class="h-7 w-[60px]" />
    </div>\
    """
  end
end
