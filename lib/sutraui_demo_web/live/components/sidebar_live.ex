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
        and active page highlighting.
      </.prose>

      <.component_demo title="Basic Sidebar" code={basic_code()}>
        <div
          class="relative border rounded-lg overflow-hidden"
          style="height: 300px; border-color: var(--border);"
        >
          <.sidebar id="demo-sidebar" class="absolute" open={true}>
            <:header>
              <div class="flex items-center gap-2 p-4 border-b" style="border-color: var(--border);">
                <span class="font-semibold" style="color: var(--fg);">My App</span>
              </div>
            </:header>

            <.sidebar_group label="Navigation">
              <.sidebar_item href="#" current>Home</.sidebar_item>
              <.sidebar_item href="#">Dashboard</.sidebar_item>
              <.sidebar_item href="#">Settings</.sidebar_item>
            </.sidebar_group>
          </.sidebar>

          <div class="ml-64 p-4" style="color: var(--fg-muted);">
            Main content area
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
          class="relative border rounded-lg overflow-hidden"
          style="height: 350px; border-color: var(--border);"
        >
          <.sidebar id="demo-sidebar-submenu" class="absolute" open={true}>
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

          <div class="ml-64 p-4" style="color: var(--fg-muted);">
            Main content area
          </div>
        </div>
      </.component_demo>

      <.section_heading id="with-footer">With Header and Footer</.section_heading>
      <.prose>
        Add header and footer slots for branding and secondary actions.
      </.prose>

      <.component_demo title="Header and Footer" code={footer_code()}>
        <div
          class="relative border rounded-lg overflow-hidden"
          style="height: 400px; border-color: var(--border);"
        >
          <.sidebar id="demo-sidebar-footer" class="absolute" open={true}>
            <:header>
              <div class="flex items-center gap-2 p-4 border-b" style="border-color: var(--border);">
                <div
                  class="w-8 h-8 rounded-lg flex items-center justify-center text-sm font-medium"
                  style="background: var(--primary); color: var(--primary-fg);"
                >
                  S
                </div>
                <span class="font-semibold" style="color: var(--fg);">Sutra UI</span>
              </div>
            </:header>

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

            <:footer>
              <div class="p-4 border-t" style="border-color: var(--border);">
                <.sidebar_item href="#">
                  <span class="flex items-center gap-2">
                    <svg
                      class="w-4 h-4"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                    >
                      <path d="M12.22 2h-.44a2 2 0 0 0-2 2v.18a2 2 0 0 1-1 1.73l-.43.25a2 2 0 0 1-2 0l-.15-.08a2 2 0 0 0-2.73.73l-.22.38a2 2 0 0 0 .73 2.73l.15.1a2 2 0 0 1 1 1.72v.51a2 2 0 0 1-1 1.74l-.15.09a2 2 0 0 0-.73 2.73l.22.38a2 2 0 0 0 2.73.73l.15-.08a2 2 0 0 1 2 0l.43.25a2 2 0 0 1 1 1.73V20a2 2 0 0 0 2 2h.44a2 2 0 0 0 2-2v-.18a2 2 0 0 1 1-1.73l.43-.25a2 2 0 0 1 2 0l.15.08a2 2 0 0 0 2.73-.73l.22-.39a2 2 0 0 0-.73-2.73l-.15-.08a2 2 0 0 1-1-1.74v-.5a2 2 0 0 1 1-1.74l.15-.09a2 2 0 0 0 .73-2.73l-.22-.38a2 2 0 0 0-2.73-.73l-.15.08a2 2 0 0 1-2 0l-.43-.25a2 2 0 0 1-1-1.73V4a2 2 0 0 0-2-2z" />
                      <circle cx="12" cy="12" r="3" />
                    </svg>
                    Settings
                  </span>
                </.sidebar_item>
              </div>
            </:footer>
          </.sidebar>

          <div class="ml-64 p-4" style="color: var(--fg-muted);">
            Main content area
          </div>
        </div>
      </.component_demo>

      <.section_heading id="props">Props</.section_heading>
      <.props_table>
        <.prop name="id" type="string" required>
          Unique identifier for the sidebar (required for JS hook)
        </.prop>
        <.prop name="side" type="string" default="left">
          Which side to position the sidebar ("left" or "right")
        </.prop>
        <.prop name="open" type="boolean" default="true">
          Initial open state for desktop
        </.prop>
        <.prop name="mobile_open" type="boolean" default="false">
          Initial open state for mobile
        </.prop>
        <.prop name="breakpoint" type="integer" default="768">
          Pixel width for mobile breakpoint
        </.prop>
        <.prop name="label" type="string" default="Sidebar navigation">
          ARIA label for navigation
        </.prop>
        <.prop name="class" type="string">
          Additional CSS classes
        </.prop>
      </.props_table>

      <.section_heading id="subcomponents">Subcomponents</.section_heading>

      <h4 class="font-medium mt-6 mb-2" style="color: var(--fg);">sidebar_group</h4>
      <.props_table>
        <.prop name="label" type="string">
          Optional heading for the group
        </.prop>
        <.prop name="class" type="string">
          Additional CSS classes
        </.prop>
      </.props_table>

      <h4 class="font-medium mt-6 mb-2" style="color: var(--fg);">sidebar_item</h4>
      <.props_table>
        <.prop name="href" type="string" required>
          URL for the link
        </.prop>
        <.prop name="variant" type="string" default="default">
          Visual variant ("default" or "outline")
        </.prop>
        <.prop name="size" type="string" default="default">
          Size variant ("default", "sm", or "lg")
        </.prop>
        <.prop name="current" type="boolean" default="false">
          Whether this is the current page
        </.prop>
      </.props_table>

      <h4 class="font-medium mt-6 mb-2" style="color: var(--fg);">sidebar_submenu</h4>
      <.props_table>
        <.prop name="label" type="string" required>
          Label for the submenu
        </.prop>
        <.prop name="open" type="boolean" default="false">
          Whether the submenu is initially open
        </.prop>
      </.props_table>

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
      </ul>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
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
    </.sidebar>\
    """
  end

  defp submenu_code do
    """
    <.sidebar id="nav-sidebar">
      <.sidebar_group label="Navigation">
        <.sidebar_item href="/">Overview</.sidebar_item>

        <.sidebar_submenu label="Projects" open>
          <.sidebar_item href="/projects/active">Active</.sidebar_item>
          <.sidebar_item href="/projects/archived">Archived</.sidebar_item>
        </.sidebar_submenu>

        <.sidebar_item href="/team">Team</.sidebar_item>
      </.sidebar_group>
    </.sidebar>\
    """
  end

  defp footer_code do
    """
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
    </.sidebar>\
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
    }));\
    """
  end
end
