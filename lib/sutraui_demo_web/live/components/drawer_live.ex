defmodule SutrauiDemoWeb.Components.DrawerLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Drawer")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/drawer">
      <.docs_header
        title="Drawer"
        description="A collapsible drawer navigation component with mobile toggle support."
      />

      <.prose>
        The drawer provides a responsive navigation panel that can be toggled open/closed.
        It supports mobile overlay mode, desktop persistent mode, collapsible submenus,
        and active page highlighting. By default, drawers are closed on desktop and
        require a
        <.inline_code>drawer_trigger</.inline_code>
        or programmatic control to open.
      </.prose>

      <.section_heading id="basic">Basic Drawer</.section_heading>
      <.prose>
        Click the menu button to toggle the drawer. The drawer slides in from the left.
        Click anywhere outside the drawer to close it.
      </.prose>

      <.component_demo title="Basic Drawer" code={basic_code()}>
        <div
          class="demo-drawer-wrapper border rounded-lg"
          style="height: 400px; border-color: var(--border);"
        >
          <div
            class="demo-drawer-header p-3 flex items-center justify-between border-b"
            style="border-color: var(--border); background: var(--bg);"
          >
            <span class="text-sm font-medium" style="color: var(--fg);">My App</span>
            <.drawer_trigger for="demo-basic" class="demo-trigger-btn" variant="outline" size="sm">
              <.icon name="lucide-menu" class="size-4" />
              <span class="ml-1">Menu</span>
            </.drawer_trigger>
          </div>

          <.drawer id="demo-basic">
            <:header>
              <div
                class="flex items-center gap-2 p-4 border-b"
                style="border-color: var(--border);"
              >
                <span class="font-semibold" style="color: var(--fg);">My App</span>
              </div>
            </:header>

            <.drawer_group label="Navigation">
              <.drawer_item href="#" current>Home</.drawer_item>
              <.drawer_item href="#">Dashboard</.drawer_item>
              <.drawer_item href="#">Settings</.drawer_item>
            </.drawer_group>
          </.drawer>

          <div class="p-4" style="color: var(--fg-muted);">
            <p>Main content area</p>
            <p class="text-sm mt-2">Click the Menu button to toggle the drawer.</p>
            <p class="text-sm mt-1">Click outside the drawer to close it.</p>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="with-submenu">With Collapsible Submenu</.section_heading>
      <.prose>
        Use
        <.inline_code>drawer_submenu</.inline_code>
        for collapsible sections within the drawer.
      </.prose>

      <.component_demo title="Collapsible Submenu" code={submenu_code()}>
        <div
          class="demo-drawer-wrapper border rounded-lg"
          style="height: 450px; border-color: var(--border);"
        >
          <div
            class="demo-drawer-header p-3 flex items-center justify-between border-b"
            style="border-color: var(--border); background: var(--bg);"
          >
            <span class="text-sm font-medium" style="color: var(--fg);">Navigation</span>
            <.drawer_trigger for="demo-submenu" class="demo-trigger-btn" variant="outline" size="sm">
              <.icon name="lucide-menu" class="size-4" />
              <span class="ml-1">Menu</span>
            </.drawer_trigger>
          </div>

          <.drawer id="demo-submenu">
            <.drawer_group label="Navigation">
              <.drawer_item href="#">Overview</.drawer_item>

              <.drawer_submenu label="Projects" open={true}>
                <.drawer_item href="#">Active</.drawer_item>
                <.drawer_item href="#">Archived</.drawer_item>
                <.drawer_item href="#">Drafts</.drawer_item>
              </.drawer_submenu>

              <.drawer_item href="#">Team</.drawer_item>
            </.drawer_group>
          </.drawer>

          <div class="p-4" style="color: var(--fg-muted);">
            <p>Main content area</p>
            <p class="text-sm mt-2">Click the Menu button to toggle the drawer.</p>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="with-footer">With Header and Footer</.section_heading>
      <.prose>
        Add header and footer slots for branding and secondary actions.
      </.prose>

      <.component_demo title="Header and Footer" code={footer_code()}>
        <div
          class="demo-drawer-wrapper border rounded-lg"
          style="height: 500px; border-color: var(--border);"
        >
          <div
            class="demo-drawer-header p-3 flex items-center justify-between border-b"
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
            <.drawer_trigger for="demo-footer" class="demo-trigger-btn" variant="outline" size="sm">
              <.icon name="lucide-menu" class="size-4" />
              <span class="ml-1">Menu</span>
            </.drawer_trigger>
          </div>

          <.drawer id="demo-footer">
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
              <.drawer_group label="Main">
                <.drawer_item href="#">Home</.drawer_item>
                <.drawer_item href="#">Projects</.drawer_item>
                <.drawer_item href="#">Analytics</.drawer_item>
              </.drawer_group>

              <.drawer_separator />

              <.drawer_group>
                <.drawer_item href="#">Documentation</.drawer_item>
                <.drawer_item href="#">Support</.drawer_item>
              </.drawer_group>
            </div>

            <:footer>
              <div class="p-2 border-t" style="border-color: var(--border);">
                <.drawer_item href="#">
                  <span class="flex items-center gap-2">
                    <.icon name="lucide-settings" class="size-4" /> Settings
                  </span>
                </.drawer_item>
              </div>
            </:footer>
          </.drawer>

          <div class="p-4" style="color: var(--fg-muted);">
            <p>Main content area</p>
            <p class="text-sm mt-2">
              Drawer has header branding, content sections, and a footer with settings.
            </p>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="drawer-trigger">Drawer Trigger</.section_heading>
      <.prose>
        Use
        <.inline_code>drawer_trigger</.inline_code>
        to create a toggle button for the drawer.
      </.prose>

      <.component_demo title="Trigger Variants" code={trigger_code()}>
        <div
          class="demo-drawer-wrapper border rounded-lg"
          style="height: 300px; border-color: var(--border);"
        >
          <div
            class="demo-drawer-header p-3 flex items-center justify-between border-b"
            style="border-color: var(--border); background: var(--bg);"
          >
            <span class="text-sm font-medium" style="color: var(--fg);">Trigger Demo</span>
            <div class="flex items-center gap-2">
              <.drawer_trigger for="demo-trigger-showcase" variant="ghost" size="sm">
                <.icon name="lucide-menu" class="size-4" />
              </.drawer_trigger>
              <.drawer_trigger for="demo-trigger-showcase-2" variant="outline" size="sm">
                <.icon name="lucide-menu" class="size-4 -scale-x-100" />
              </.drawer_trigger>
            </div>
          </div>

          <div class="flex flex-wrap items-center gap-4 p-4" style="color: var(--fg-muted);">
            <p class="text-sm w-full">Each trigger controls a different drawer:</p>
            <div class="flex items-center gap-2 text-xs">
              <span class="px-2 py-1 rounded" style="background: var(--bg-muted);">Ghost</span>
              <span style="color: var(--fg-secondary);">→ Left drawer</span>
            </div>
            <div class="flex items-center gap-2 text-xs">
              <span
                class="px-2 py-1 rounded border"
                style="border-color: var(--border); background: var(--bg);"
              >
                Outline
              </span>
              <span style="color: var(--fg-secondary);">→ Right drawer</span>
            </div>
          </div>

          <.drawer id="demo-trigger-showcase">
            <.drawer_group label="Left Menu">
              <.drawer_item href="#">Option 1</.drawer_item>
              <.drawer_item href="#">Option 2</.drawer_item>
              <.drawer_item href="#">Option 3</.drawer_item>
            </.drawer_group>
          </.drawer>

          <.drawer id="demo-trigger-showcase-2" side="right">
            <.drawer_group label="Right Menu">
              <.drawer_item href="#">Option A</.drawer_item>
              <.drawer_item href="#">Option B</.drawer_item>
              <.drawer_item href="#">Option C</.drawer_item>
            </.drawer_group>
          </.drawer>
        </div>
      </.component_demo>

      <.section_heading id="programmatic-control">Programmatic Control</.section_heading>
      <.prose>
        Control the drawer state from JavaScript using custom events:
      </.prose>

      <.code_block
        code={js_control_code()}
        language="javascript"
        filename="Programmatic Control"
      />

      <.section_heading id="accessibility">Accessibility</.section_heading>
      <.prose>
        The drawer component includes comprehensive accessibility features:
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
    <.drawer_trigger for="main-drawer" />
    <.drawer id="main-drawer">
      <:header>
        <div class="flex items-center gap-2 p-4">
          <span class="font-semibold">My App</span>
        </div>
      </:header>

      <.drawer_group label="Navigation">
        <.drawer_item href="/" current>Home</.drawer_item>
        <.drawer_item href="/dashboard">Dashboard</.drawer_item>
        <.drawer_item href="/settings">Settings</.drawer_item>
      </.drawer_group>
    </.drawer>

    # Or initially open on desktop
    <.drawer_trigger for="main-drawer" />
    <.drawer id="main-drawer" open>
      ...
    </.drawer>
    """
  end

  defp submenu_code do
    """
    <.drawer_trigger for="nav-drawer" />
    <.drawer id="nav-drawer">
      <.drawer_group label="Navigation">
        <.drawer_item href="/">Overview</.drawer_item>

        <.drawer_submenu label="Projects" open>
          <.drawer_item href="/projects/active">Active</.drawer_item>
          <.drawer_item href="/projects/archived">Archived</.drawer_item>
        </.drawer_submenu>

        <.drawer_item href="/team">Team</.drawer_item>
      </.drawer_group>
    </.drawer>
    """
  end

  defp footer_code do
    """
    <.drawer_trigger for="app-drawer" />
    <.drawer id="app-drawer">
      <:header>
        <div class="flex items-center gap-2 p-4">
          <img src="/logo.svg" class="w-8 h-8" />
          <span class="font-semibold">My App</span>
        </div>
      </:header>

      <.drawer_group label="Main">
        <.drawer_item href="/">Home</.drawer_item>
        <.drawer_item href="/projects">Projects</.drawer_item>
      </.drawer_group>

      <:footer>
        <.drawer_item href="/settings">Settings</.drawer_item>
      </:footer>
    </.drawer>
    """
  end

  defp trigger_code do
    """
    # Default icon trigger (hamburger menu)
    <.drawer_trigger for="main-drawer" />

    # With outline variant
    <.drawer_trigger for="main-drawer" variant="outline">
      <.icon name="lucide-menu" class="size-4" />
    </.drawer_trigger>

    # Different sizes
    <.drawer_trigger for="main-drawer" size="sm" />
    <.drawer_trigger for="main-drawer" size="lg" />

    # Available variants: primary, secondary, destructive, outline, ghost, link
    """
  end

  defp js_control_code do
    """
    // Toggle drawer
    document.dispatchEvent(new CustomEvent('sutra-ui:drawer', {
      detail: { id: 'main-drawer' }
    }));

    // Open drawer
    document.dispatchEvent(new CustomEvent('sutra-ui:drawer', {
      detail: { id: 'main-drawer', action: 'open' }
    }));

    // Close drawer
    document.dispatchEvent(new CustomEvent('sutra-ui:drawer', {
      detail: { id: 'main-drawer', action: 'close' }
    }));
    """
  end
end
