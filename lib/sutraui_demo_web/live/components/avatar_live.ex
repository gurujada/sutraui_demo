defmodule SutrauiDemoWeb.Components.AvatarLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Avatar")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/avatar">
      <.docs_header
        title="Avatar"
        description="An image element with a fallback for representing the user."
      />

      <.component_demo
        title="Default"
        code={~s|<.avatar src="https://github.com/shadcn.png" alt="User" />|}
      >
        <.avatar src="https://github.com/shadcn.png" alt="User" />
      </.component_demo>

      <.section_heading id="with-initials">With Initials Fallback</.section_heading>
      <.prose>
        Use the
        <.inline_code>initials</.inline_code>
        prop to display fallback text when no image is provided or if the image fails to load.
      </.prose>

      <.component_demo title="Initials" code={initials_code()}>
        <div class="flex items-center gap-4">
          <.avatar initials="JD" />
          <.avatar initials="AB" />
          <.avatar initials="ZK" />
        </div>
      </.component_demo>

      <.section_heading id="sizes">Sizes</.section_heading>
      <.prose>
        Use the
        <.inline_code>size</.inline_code>
        prop to change the avatar size.
      </.prose>

      <.component_demo title="Sizes" code={sizes_code()}>
        <div class="flex items-end gap-4">
          <div class="text-center space-y-2">
            <.avatar src="https://github.com/shadcn.png" alt="User" size="sm" />
            <span class="block text-xs" style="color: var(--fg-muted);">sm</span>
          </div>
          <div class="text-center space-y-2">
            <.avatar src="https://github.com/shadcn.png" alt="User" size="md" />
            <span class="block text-xs" style="color: var(--fg-muted);">md</span>
          </div>
          <div class="text-center space-y-2">
            <.avatar src="https://github.com/shadcn.png" alt="User" size="lg" />
            <span class="block text-xs" style="color: var(--fg-muted);">lg</span>
          </div>
          <div class="text-center space-y-2">
            <.avatar src="https://github.com/shadcn.png" alt="User" size="xl" />
            <span class="block text-xs" style="color: var(--fg-muted);">xl</span>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="shapes">Shapes</.section_heading>
      <.prose>
        Use the
        <.inline_code>shape</.inline_code>
        prop to switch between circle and square avatars.
      </.prose>

      <.component_demo title="Shapes" code={shapes_code()}>
        <div class="flex items-center gap-4">
          <div class="text-center space-y-2">
            <.avatar src="https://github.com/shadcn.png" alt="User" shape="circle" />
            <span class="block text-xs" style="color: var(--fg-muted);">circle</span>
          </div>
          <div class="text-center space-y-2">
            <.avatar src="https://github.com/shadcn.png" alt="User" shape="square" />
            <span class="block text-xs" style="color: var(--fg-muted);">square</span>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="fallback-icon">Custom Fallback Icon</.section_heading>
      <.prose>
        Use the
        <.inline_code>:fallback</.inline_code>
        slot for custom fallback content like icons.
      </.prose>

      <.component_demo title="Custom Fallback" code={fallback_code()}>
        <div class="flex items-center gap-4">
          <.avatar>
            <:fallback>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="20"
                height="20"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" /><circle cx="12" cy="7" r="4" />
              </svg>
            </:fallback>
          </.avatar>
          <.avatar>
            <:fallback>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="20"
                height="20"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                <circle cx="9" cy="7" r="4" />
                <path d="M22 21v-2a4 4 0 0 0-3-3.87" />
                <path d="M16 3.13a4 4 0 0 1 0 7.75" />
              </svg>
            </:fallback>
          </.avatar>
        </div>
      </.component_demo>

      <.section_heading id="avatar-group">Avatar Group</.section_heading>
      <.prose>
        Wrap avatars in a container with the
        <.inline_code>avatar-group</.inline_code>
        class for stacked display.
      </.prose>

      <.component_demo title="Avatar Group" code={group_code()}>
        <div class="avatar-group">
          <.avatar src="https://github.com/shadcn.png" alt="User 1" />
          <.avatar initials="JD" />
          <.avatar initials="AB" />
          <.avatar initials="+3" />
        </div>
      </.component_demo>

      <.section_heading id="with-status">With Status Indicator</.section_heading>
      <.prose>
        Combine with a status indicator for online/offline states.
      </.prose>

      <.component_demo title="With Status" code={status_code()}>
        <div class="flex items-center gap-6">
          <div class="relative">
            <.avatar src="https://github.com/shadcn.png" alt="Online user" />
            <span
              class="absolute bottom-0 right-0 w-3 h-3 rounded-full border-2"
              style="background: #22c55e; border-color: var(--bg);"
            >
            </span>
          </div>
          <div class="relative">
            <.avatar initials="JD" />
            <span
              class="absolute bottom-0 right-0 w-3 h-3 rounded-full border-2"
              style="background: #ef4444; border-color: var(--bg);"
            >
            </span>
          </div>
          <div class="relative">
            <.avatar initials="AB" />
            <span
              class="absolute bottom-0 right-0 w-3 h-3 rounded-full border-2"
              style="background: #eab308; border-color: var(--bg);"
            >
            </span>
          </div>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp initials_code do
    """
    <.avatar initials="JD" />
    <.avatar initials="AB" />
    <.avatar initials="ZK" />\
    """
  end

  defp sizes_code do
    """
    <.avatar src="/avatar.png" size="sm" />
    <.avatar src="/avatar.png" size="md" />
    <.avatar src="/avatar.png" size="lg" />
    <.avatar src="/avatar.png" size="xl" />\
    """
  end

  defp shapes_code do
    """
    <.avatar src="/avatar.png" shape="circle" />
    <.avatar src="/avatar.png" shape="square" />\
    """
  end

  defp fallback_code do
    """
    <.avatar>
      <:fallback>
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" />
          <circle cx="12" cy="7" r="4" />
        </svg>
      </:fallback>
    </.avatar>\
    """
  end

  defp group_code do
    """
    <div class="avatar-group">
      <.avatar src="/user1.png" alt="User 1" />
      <.avatar initials="JD" />
      <.avatar initials="AB" />
      <.avatar initials="+3" />
    </div>\
    """
  end

  defp status_code do
    """
    <div class="relative">
      <.avatar src="/avatar.png" />
      <span class="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border-2 border-white"></span>
    </div>\
    """
  end
end
