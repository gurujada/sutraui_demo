defmodule SutrauiDemoWeb.Components.TabNavLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Tab Nav", active_tab: :about)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/tab-nav">
      <.docs_header
        title="Tab Nav"
        description="Visual tab navigation component for server-side routed tabs."
      />

      <.prose>
        Unlike the full
        <.inline_code>tabs</.inline_code>
        component which manages content panels client-side, Tab Nav only provides the visual tab navigation.
        Each tab links to a different LiveView route, allowing heavy content to load only when active.
      </.prose>

      <.component_demo title="Default" code={default_code()}>
        <.tab_nav>
          <:tab patch="/docs/components/tab-nav" active={@active_tab == :about}>
            About
          </:tab>
          <:tab patch="/docs/components/tab-nav" active={@active_tab == :members}>
            Members
          </:tab>
          <:tab patch="/docs/components/tab-nav" active={@active_tab == :settings}>
            Settings
          </:tab>
        </.tab_nav>
      </.component_demo>

      <.section_heading id="with-icons">With Icons</.section_heading>
      <.prose>
        Include icons alongside text in the tab inner block.
      </.prose>

      <.component_demo title="With Icons" code={icons_code()}>
        <.tab_nav>
          <:tab patch="/docs/components/tab-nav" active={true}>
            <svg
              class="w-4 h-4"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
            >
              <circle cx="12" cy="12" r="10" /><path d="M12 16v-4" /><path d="M12 8h.01" />
            </svg>
            About
          </:tab>
          <:tab patch="/docs/components/tab-nav" active={false}>
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
            Members
          </:tab>
          <:tab patch="/docs/components/tab-nav" active={false}>
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
          </:tab>
        </.tab_nav>
      </.component_demo>

      <.section_heading id="use-case">When to Use</.section_heading>
      <.prose>
        Tab Nav is ideal for scenarios where:
      </.prose>
      <ul class="list-disc list-inside space-y-1 text-sm" style="color: var(--fg-secondary);">
        <li>Each tab loads different data from the server</li>
        <li>Tab content is heavy (analytics, tables, charts)</li>
        <li>You want separate URLs for each tab for bookmarking</li>
        <li>Content should only load when the tab is active</li>
      </ul>

      <div class="mt-4">
        <.prose>
          For client-side tab switching with all content loaded upfront, use the
          <.link navigate="/docs/components/tabs" class="text-link">Tabs</.link>
          component instead.
        </.prose>
      </div>

      <.section_heading id="props">Props</.section_heading>
      <.props_table>
        <.prop name="class" type="string">
          Additional CSS classes for the container
        </.prop>
      </.props_table>

      <.section_heading id="tab-slot">Tab Slot</.section_heading>
      <.props_table>
        <.prop name="patch" type="string" required>
          LiveView patch URL to navigate to
        </.prop>
        <.prop name="active" type="boolean" required>
          Whether this tab is currently active
        </.prop>
        <.prop name="inner_block" type="slot">
          Tab content (icons and text)
        </.prop>
      </.props_table>

      <.section_heading id="permission-aware">Permission-Aware Rendering</.section_heading>
      <.prose>
        Conditionally render tabs based on user permissions using standard Elixir conditionals.
      </.prose>

      <.code_block code={permission_code()} language="elixir" filename="Permission-Aware Tabs" />
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.tab_nav>
      <:tab patch={~p"/orgs/\#{@org.id}"} active={@active_tab == :about}>
        About
      </:tab>
      <:tab patch={~p"/orgs/\#{@org.id}/members"} active={@active_tab == :members}>
        Members
      </:tab>
      <:tab patch={~p"/orgs/\#{@org.id}/settings"} active={@active_tab == :settings}>
        Settings
      </:tab>
    </.tab_nav>\
    """
  end

  defp icons_code do
    """
    <.tab_nav>
      <:tab patch={~p"/about"} active={true}>
        <svg class="w-4 h-4">...</svg>
        About
      </:tab>
      <:tab patch={~p"/members"} active={false}>
        <svg class="w-4 h-4">...</svg>
        Members
      </:tab>
    </.tab_nav>\
    """
  end

  defp permission_code do
    """
    <.tab_nav>
      <:tab patch={~p"/overview"} active={@active_tab == :overview}>
        Overview
      </:tab>
      <%= if @can_manage do %>
        <:tab patch={~p"/settings"} active={@active_tab == :settings}>
          Settings
        </:tab>
      <% end %>
    </.tab_nav>\
    """
  end
end
