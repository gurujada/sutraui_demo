defmodule SutrauiDemoWeb.Components.NavPillsLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Nav Pills", active_tab: "Overview")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/nav-pills">
      <.docs_header
        title="Nav Pills"
        description="A responsive navigation pills component that displays pills on desktop and converts to a dropdown on mobile."
      />

      <.component_demo title="Default" code={default_code()}>
        <.nav_pills id="demo-nav-pills" active_label={@active_tab}>
          <:item label="Overview" patch="/docs/components/nav-pills" />
          <:item label="Analytics" patch="/docs/components/nav-pills" />
          <:item label="Settings" patch="/docs/components/nav-pills" />
        </.nav_pills>
      </.component_demo>

      <.section_heading id="responsive">Responsive Behavior</.section_heading>
      <.prose>
        Nav Pills automatically adapts to screen size:
      </.prose>
      <ul class="list-disc list-inside space-y-1 text-sm" style="color: var(--fg-secondary);">
        <li>
          <span class="font-medium" style="color: var(--fg);">Desktop:</span>
          Shows all items as horizontal pill buttons
        </li>
        <li>
          <span class="font-medium" style="color: var(--fg);">Mobile:</span>
          Converts to a dropdown menu showing the active item
        </li>
      </ul>

      <.section_heading id="with-icons">With Icons</.section_heading>
      <.prose>
        Use the inner block of each item slot to add icons.
      </.prose>

      <.component_demo title="With Icons" code={icons_code()}>
        <.nav_pills id="icon-nav-pills" active_label="Dashboard">
          <:item label="Dashboard" patch="/docs/components/nav-pills">
            <svg
              class="w-4 h-4"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
            >
              <rect width="7" height="9" x="3" y="3" rx="1" />
              <rect width="7" height="5" x="14" y="3" rx="1" />
              <rect width="7" height="9" x="14" y="12" rx="1" />
              <rect width="7" height="5" x="3" y="16" rx="1" />
            </svg>
          </:item>
          <:item label="Projects" patch="/docs/components/nav-pills">
            <svg
              class="w-4 h-4"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
            >
              <path d="M20 20a2 2 0 0 0 2-2V8a2 2 0 0 0-2-2h-7.9a2 2 0 0 1-1.69-.9L9.6 3.9A2 2 0 0 0 7.93 3H4a2 2 0 0 0-2 2v13a2 2 0 0 0 2 2Z" />
            </svg>
          </:item>
          <:item label="Team" patch="/docs/components/nav-pills">
            <svg
              class="w-4 h-4"
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
          </:item>
        </.nav_pills>
      </.component_demo>

      <.section_heading id="props">Props</.section_heading>
      <.props_table>
        <.prop name="id" type="string" required>
          Unique identifier for the navigation component
        </.prop>
        <.prop name="active_label" type="string" required>
          Label of the currently active item
        </.prop>
        <.prop name="class" type="string">
          Additional CSS classes for the container
        </.prop>
        <.prop name="aria_label" type="string" default="Navigation">
          Accessible label for the navigation
        </.prop>
      </.props_table>

      <.section_heading id="item-slot">Item Slot</.section_heading>
      <.props_table>
        <.prop name="label" type="string" required>
          Text label for the item
        </.prop>
        <.prop name="patch" type="string" required>
          LiveView patch URL for navigation
        </.prop>
        <.prop name="inner_block" type="slot">
          Optional icon or content before the label
        </.prop>
      </.props_table>

      <.section_heading id="accessibility">Accessibility</.section_heading>
      <.prose>
        The nav pills component includes proper ARIA attributes:
      </.prose>
      <ul class="list-disc list-inside space-y-1 text-sm" style="color: var(--fg-secondary);">
        <li>
          Desktop pills use
          <.inline_code>role="navigation"</.inline_code>
          with
          <.inline_code>aria-label</.inline_code>
        </li>
        <li>Mobile dropdown uses proper ARIA popup attributes</li>
        <li>Active item is clearly indicated visually and semantically</li>
      </ul>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.nav_pills id="content-nav" active_label="Overview">
      <:item label="Overview" patch={~p"/content"} />
      <:item label="Analytics" patch={~p"/content/analytics"} />
      <:item label="Settings" patch={~p"/content/settings"} />
    </.nav_pills>\
    """
  end

  defp icons_code do
    """
    <.nav_pills id="nav" active_label="Dashboard">
      <:item label="Dashboard" patch={~p"/dashboard"}>
        <svg class="w-4 h-4">...</svg>
      </:item>
      <:item label="Projects" patch={~p"/projects"}>
        <svg class="w-4 h-4">...</svg>
      </:item>
      <:item label="Team" patch={~p"/team"}>
        <svg class="w-4 h-4">...</svg>
      </:item>
    </.nav_pills>\
    """
  end
end
