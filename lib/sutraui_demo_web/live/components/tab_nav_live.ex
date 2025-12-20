defmodule SutrauiDemoWeb.Components.TabNavLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Tab Nav", active_tab: "about")}
  end

  def handle_params(params, _uri, socket) do
    tab = params["tab"] || "about"
    {:noreply, assign(socket, active_tab: tab)}
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
          <:tab patch="/docs/components/tab-nav?tab=about" active={@active_tab == "about"}>
            About
          </:tab>
          <:tab patch="/docs/components/tab-nav?tab=members" active={@active_tab == "members"}>
            Members
          </:tab>
          <:tab patch="/docs/components/tab-nav?tab=settings" active={@active_tab == "settings"}>
            Settings
          </:tab>
        </.tab_nav>
      </.component_demo>

      <.section_heading id="usage">Usage</.section_heading>
      <.prose>
        Tab Nav uses
        <.inline_code>patch</.inline_code>
        for LiveView navigation, keeping the socket connection alive.
      </.prose>

      <.code_block code={usage_code()} language="elixir" filename="Usage" />

      <.section_heading id="with-icons">With Icons</.section_heading>
      <.prose>
        Include icons alongside text in the tab inner block.
      </.prose>

      <.code_block code={icons_code()} language="elixir" filename="With Icons" />

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

      <.section_heading id="accessibility">Accessibility</.section_heading>
      <.prose>
        Tab Nav provides visual tab styling. For full keyboard navigation and ARIA support,
        use the <.link navigate="/docs/components/tabs" class="text-link">Tabs</.link> component.
      </.prose>
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

  defp usage_code do
    """
    # In your LiveView
    def mount(%{"id" => id}, _session, socket) do
      {:ok, assign(socket, org: get_org(id), active_tab: :about)}
    end

    # In the template
    <.tab_nav>
      <:tab patch={~p"/orgs/\#{@org.id}"} active={@active_tab == :about}>
        About
      </:tab>
      <:tab patch={~p"/orgs/\#{@org.id}/members"} active={@active_tab == :members}>
        Members
      </:tab>
    </.tab_nav>\
    """
  end

  defp icons_code do
    """
    <.tab_nav>
      <:tab patch={~p"/about"} active={true}>
        <.icon name="hero-information-circle" class="w-4 h-4" />
        About
      </:tab>
      <:tab patch={~p"/members"} active={false}>
        <.icon name="hero-users" class="w-4 h-4" />
        Members
      </:tab>
    </.tab_nav>\
    """
  end
end
