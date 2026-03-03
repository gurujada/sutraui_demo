defmodule SutrauiDemoWeb.Components.SidebarLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Sidebar")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/sidebar">
      <.docs_header
        title="Sidebar"
        description="A collapsible sidebar navigation component with mobile toggle support."
      />

      <.prose>
        The sidebar provides a responsive navigation panel that can be toggled open/closed.
        It supports mobile overlay mode, desktop persistent mode, collapsible submenus,
        and active page highlighting. By default, sidebars are closed on desktop and
        require a
        <.inline_code>sidebar_trigger</.inline_code>
        or programmatic control to open.
      </.prose>

      <.section_heading id="basic">Basic Sidebar</.section_heading>
      <.prose>
        Click the menu button to toggle the sidebar. The sidebar slides in from the left.
        Click anywhere outside the sidebar to close it.
      </.prose>

      <.component_demo title="Basic Sidebar" code={basic_code()}>
        <div
          class="demo-sidebar-wrapper border rounded-lg"
          style="height: 400px; border-color: var(--border);"
        >
          <div
            class="demo-sidebar-header p-3 flex items-center justify-between border-b"
            style="border-color: var(--border); background: var(--bg);"
          >
            <span class="text-sm font-medium" style="color: var(--fg);">My App</span>
            <.sidebar_trigger for="demo-basic" class="demo-trigger-btn" variant="outline" size="sm">
              <.icon name="lucide-menu" class="size-4" />
              <span class="ml-1">Menu</span>
            </.sidebar_trigger>
          </div>

          <.sidebar id="demo-basic">
            <:header>
              <div
                class="flex items-center gap-2 p-4 border-b"
                style="border-color: var(--border);"
              >
                <span class="font-semibold" style="color: var(--fg);">My App</span>
              </div>
            </:header>

            <.sidebar_group label="Navigation">
              <.sidebar_item href="#" current>Home</.sidebar_item>
              <.sidebar_item href="#">Dashboard</.sidebar_item>
              <.sidebar_item href="#">Settings</.sidebar_item>
            </.sidebar_group>
          </.sidebar>

          <div class="p-4" style="color: var(--fg-muted);">
            <p>Main content area</p>
            <p class="text-sm mt-2">Click the Menu button to toggle the sidebar.</p>
            <p class="text-sm mt-1">Click outside the sidebar to close it.</p>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="with-submenu">With Collapsible Submenu</.section_heading>
      <.prose>
        Use
        <.inline_code>sidebar_submenu</.inline_code>
        for collapsible sections within the sidebar.
      </.prose>

      <.component_demo title="Collapsible Submenu" code={submenu_code()}>
        <div
          class="demo-sidebar-wrapper border rounded-lg"
          style="height: 450px; border-color: var(--border);"
        >
          <div
            class="demo-sidebar-header p-3 flex items-center justify-between border-b"
            style="border-color: var(--border); background: var(--bg);"
          >
            <span class="text-sm font-medium" style="color: var(--fg);">Navigation</span>
            <.sidebar_trigger for="demo-submenu" class="demo-trigger-btn" variant="outline" size="sm">
              <.icon name="lucide-menu" class="size-4" />
              <span class="ml-1">Menu</span>
            </.sidebar_trigger>
          </div>

          <.sidebar id="demo-submenu">
            <.sidebar_group label="Navigation">
              <.sidebar_item href="#">Overview</.sidebar_item>

              <.sidebar_submenu label="Projects" open={true}>
                <.sidebar_item href="#">Active</.sidebar_item>
                <.sidebar_item href="#">Archived</.sidebar_item>
                <.sidebar_item href="#">Drafts</.sidebar_item>
              </.sidebar_submenu>

              <.sidebar_item href="#">Team</.sidebar_item>
            </.sidebar_group>
          </.sidebar>

          <div class="p-4" style="color: var(--fg-muted);">
            <p>Main content area</p>
            <p class="text-sm mt-2">Click the Menu button to toggle the sidebar.</p>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="with-footer">With Header and Footer</.section_heading>
      <.prose>
        Add header and footer slots for branding and secondary actions.
      </.prose>

      <.component_demo title="Header and Footer" code={footer_code()}>
        <div
          class="demo-sidebar-wrapper border rounded-lg"
          style="height: 500px; border-color: var(--border);"
        >
          <div
            class="demo-sidebar-header p-3 flex items-center justify-between border-b"
            style="border-color: var(--border); background: var(--bg);"
          >
            <div class="flex items-center gap-2">
              <div
                class="w-6 h-6 rounded flex items-center justify-center text-xs font-medium"
                style="background: var(--site-accent); color: #fff;"
              >
                S
              </div>
              <span class="text-sm font-medium" style="color: var(--fg);">Sutra UI</span>
            </div>
            <.sidebar_trigger for="demo-footer" class="demo-trigger-btn" variant="outline" size="sm">
              <.icon name="lucide-menu" class="size-4" />
              <span class="ml-1">Menu</span>
            </.sidebar_trigger>
          </div>

          <.sidebar id="demo-footer">
            <:header>
              <div
                class="flex items-center gap-2 p-4 border-b"
                style="border-color: var(--border);"
              >
                <div
                  class="w-8 h-8 rounded-lg flex items-center justify-center text-sm font-medium"
                  style="background: var(--site-accent); color: #fff;"
                >
                  S
                </div>
                <span class="font-semibold" style="color: var(--fg);">Sutra UI</span>
              </div>
            </:header>

            <div class="p-2">
              <.sidebar_group label="Main">
                <.sidebar_item href="#">Home</.sidebar_item>
                <.sidebar_item href="#">Projects</.sidebar_item>
                <.sidebar_item href="#">Analytics</.sidebar_item>
              </.sidebar_group>

              <.sidebar_separator />

              <.sidebar_group>
                <.sidebar_item href="#">Documentation</.sidebar_item>
                <.sidebar_item href="#">Support</.sidebar_item>
              </.sidebar_group>
            </div>

            <:footer>
              <div class="p-2 border-t" style="border-color: var(--border);">
                <.sidebar_item href="#">
                  <span class="flex items-center gap-2">
                    <.icon name="lucide-settings" class="size-4" /> Settings
                  </span>
                </.sidebar_item>
              </div>
            </:footer>
          </.sidebar>

          <div class="p-4" style="color: var(--fg-muted);">
            <p>Main content area</p>
            <p class="text-sm mt-2">
              Sidebar has header branding, content sections, and a footer with settings.
            </p>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="sidebar-trigger">Sidebar Trigger</.section_heading>
      <.prose>
        Use
        <.inline_code>sidebar_trigger</.inline_code>
        to create a toggle button for the sidebar.
      </.prose>

      <.component_demo title="Trigger Variants" code={trigger_code()}>
        <div
          class="demo-sidebar-wrapper border rounded-lg"
          style="height: 300px; border-color: var(--border);"
        >
          <div
            class="demo-sidebar-header p-3 flex items-center justify-between border-b"
            style="border-color: var(--border); background: var(--bg);"
          >
            <span class="text-sm font-medium" style="color: var(--fg);">Trigger Demo</span>
            <div class="flex items-center gap-2">
              <.sidebar_trigger for="demo-trigger-showcase" variant="ghost" size="sm">
                <.icon name="lucide-menu" class="size-4" />
              </.sidebar_trigger>
              <.sidebar_trigger for="demo-trigger-showcase-2" variant="outline" size="sm">
                <.icon name="lucide-menu" class="size-4 -scale-x-100" />
              </.sidebar_trigger>
            </div>
          </div>

          <div class="flex flex-wrap items-center gap-4 p-4" style="color: var(--fg-muted);">
            <p class="text-sm w-full">Each trigger controls a different sidebar:</p>
            <div class="flex items-center gap-2 text-xs">
              <span class="px-2 py-1 rounded" style="background: var(--bg-muted);">Ghost</span>
              <span style="color: var(--fg-secondary);">→ Left sidebar</span>
            </div>
            <div class="flex items-center gap-2 text-xs">
              <span
                class="px-2 py-1 rounded border"
                style="border-color: var(--border); background: var(--bg);"
              >
                Outline
              </span>
              <span style="color: var(--fg-secondary);">→ Right sidebar</span>
            </div>
          </div>

          <.sidebar id="demo-trigger-showcase">
            <.sidebar_group label="Left Menu">
              <.sidebar_item href="#">Option 1</.sidebar_item>
              <.sidebar_item href="#">Option 2</.sidebar_item>
              <.sidebar_item href="#">Option 3</.sidebar_item>
            </.sidebar_group>
          </.sidebar>

          <.sidebar id="demo-trigger-showcase-2" side="right">
            <.sidebar_group label="Right Menu">
              <.sidebar_item href="#">Option A</.sidebar_item>
              <.sidebar_item href="#">Option B</.sidebar_item>
              <.sidebar_item href="#">Option C</.sidebar_item>
            </.sidebar_group>
          </.sidebar>
        </div>
      </.component_demo>

      <.section_heading id="programmatic-control">Programmatic Control</.section_heading>
      <.prose>
        Control the sidebar state from JavaScript using custom events:
      </.prose>

      <.code_block
        code={js_control_code()}
        language="javascript"
        filename="Programmatic Control"
      />

      <.section_heading id="accessibility">Accessibility</.section_heading>
      <.prose>
        The sidebar component includes comprehensive accessibility features:
      </.prose>
      <ul class="list-disc list-inside space-y-1 text-sm" style="color: var(--fg-secondary);">
        <li>
          Uses semantic
          <.inline_code>&lt;aside&gt;</.inline_code>
          and
          <.inline_code>&lt;nav&gt;</.inline_code>
          elements
        </li>
        <li>Proper ARIA labels and aria-hidden state</li>
        <li>
          Sets
          <.inline_code>inert</.inline_code>
          attribute when closed to prevent keyboard navigation
        </li>
        <li>
          Active page links marked with
          <.inline_code>aria-current="page"</.inline_code>
        </li>
        <li>Click outside to close functionality</li>
      </ul>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.sidebar_trigger for="main-sidebar" />
    <.sidebar id="main-sidebar">
      <:header>
        <div class="flex items-center gap-2 p-4">
          <span class="font-semibold">My App</span>
        </div>
      </:header>

      <.sidebar_group label="Navigation">
        <.sidebar_item href="/" current>Home</.sidebar_item>
        <.sidebar_item href="/dashboard">Dashboard</.sidebar_item>
        <.sidebar_item href="/settings">Settings</.sidebar_item>
      </.sidebar_group>
    </.sidebar>

    # Or initially open on desktop
    <.sidebar_trigger for="main-sidebar" />
    <.sidebar id="main-sidebar" open>
      ...
    </.sidebar>
    """
  end

  defp submenu_code do
    """
    <.sidebar_trigger for="nav-sidebar" />
    <.sidebar id="nav-sidebar">
      <.sidebar_group label="Navigation">
        <.sidebar_item href="/">Overview</.sidebar_item>

        <.sidebar_submenu label="Projects" open>
          <.sidebar_item href="/projects/active">Active</.sidebar_item>
          <.sidebar_item href="/projects/archived">Archived</.sidebar_item>
        </.sidebar_submenu>

        <.sidebar_item href="/team">Team</.sidebar_item>
      </.sidebar_group>
    </.sidebar>
    """
  end

  defp footer_code do
    """
    <.sidebar_trigger for="app-sidebar" />
    <.sidebar id="app-sidebar">
      <:header>
        <div class="flex items-center gap-2 p-4">
          <img src="/logo.svg" class="w-8 h-8" />
          <span class="font-semibold">My App</span>
        </div>
      </:header>

      <.sidebar_group label="Main">
        <.sidebar_item href="/">Home</.sidebar_item>
        <.sidebar_item href="/projects">Projects</.sidebar_item>
      </.sidebar_group>

      <:footer>
        <.sidebar_item href="/settings">Settings</.sidebar_item>
      </:footer>
    </.sidebar>
    """
  end

  defp trigger_code do
    """
    # Default icon trigger (hamburger menu)
    <.sidebar_trigger for="main-sidebar" />

    # With outline variant
    <.sidebar_trigger for="main-sidebar" variant="outline">
      <.icon name="lucide-menu" class="size-4" />
    </.sidebar_trigger>

    # Different sizes
    <.sidebar_trigger for="main-sidebar" size="sm" />
    <.sidebar_trigger for="main-sidebar" size="lg" />

    # Available variants: primary, secondary, destructive, outline, ghost, link
    """
  end

  defp js_control_code do
    """
    // Toggle sidebar
    document.dispatchEvent(new CustomEvent('sutra-ui:sidebar', {
      detail: { id: 'main-sidebar' }
    }));

    // Open sidebar
    document.dispatchEvent(new CustomEvent('sutra-ui:sidebar', {
      detail: { id: 'main-sidebar', action: 'open' }
    }));

    // Close sidebar
    document.dispatchEvent(new CustomEvent('sutra-ui:sidebar', {
      detail: { id: 'main-sidebar', action: 'close' }
    }));
    """
  end
end
