defmodule SutrauiDemoWeb.Components.TabsLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Tabs",
       view: "list",
       unit: "metric",
       filter: "all",
       plan: "team"
     )}
  end

  def handle_event("set_view", %{"value" => view}, socket) do
    {:noreply, assign(socket, :view, view)}
  end

  def handle_event("set_filter", %{"filter" => filter}, socket) do
    {:noreply, assign(socket, :filter, filter)}
  end

  def handle_event("change_unit", %{"unit" => unit}, socket) do
    {:noreply, assign(socket, :unit, unit)}
  end

  def handle_event("change_plan", %{"plan" => plan}, socket) do
    {:noreply, assign(socket, :plan, plan)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} sutra_commands={@sutra_commands} current_path="/docs/components/tabs">
      <.docs_header
        title="Tabs"
        description="Tabbed interface with client-side switching and full keyboard navigation."
      />

      <.component_demo title="Basic Tabs" code={basic_code()}>
        <.tabs nonce={@csp_nonce} id="demo-tabs-1" default_value="account" class="w-full max-w-md">
          <:tab value="account">Account</:tab>
          <:tab value="password">Password</:tab>
          <:tab value="settings">Settings</:tab>
          <:panel value="account">
            <div class="p-4 space-y-2">
              <h3 class="font-medium">Account Settings</h3>
              <p class="text-sm text-muted-foreground">
                Manage your account preferences and information.
              </p>
            </div>
          </:panel>
          <:panel value="password">
            <div class="p-4 space-y-2">
              <h3 class="font-medium">Password Settings</h3>
              <p class="text-sm text-muted-foreground">
                Change your password and security settings.
              </p>
            </div>
          </:panel>
          <:panel value="settings">
            <div class="p-4 space-y-2">
              <h3 class="font-medium">App Settings</h3>
              <p class="text-sm text-muted-foreground">
                Configure application preferences.
              </p>
            </div>
          </:panel>
        </.tabs>
      </.component_demo>

      <.section_heading id="disabled">With Disabled Tab</.section_heading>
      <.prose>
        Individual tabs can be disabled.
      </.prose>

      <.component_demo title="Disabled Tab" code={disabled_code()}>
        <.tabs nonce={@csp_nonce} id="demo-tabs-2" default_value="tab1" class="w-full max-w-md">
          <:tab value="tab1">Active</:tab>
          <:tab value="tab2" disabled>Disabled</:tab>
          <:tab value="tab3">Also Active</:tab>
          <:panel value="tab1">
            <div class="p-4">
              <p class="text-sm text-muted-foreground">First tab content.</p>
            </div>
          </:panel>
          <:panel value="tab2">
            <div class="p-4">
              <p class="text-sm text-muted-foreground">This tab is disabled.</p>
            </div>
          </:panel>
          <:panel value="tab3">
            <div class="p-4">
              <p class="text-sm text-muted-foreground">Third tab content.</p>
            </div>
          </:panel>
        </.tabs>
      </.component_demo>

      <.section_heading id="segmented">Segmented control</.section_heading>
      <.prose>
        <.inline_code>segmented</.inline_code>
        is a single choice out of two to six (a view mode, a unit, a plan). It is a real radio group:
        arrow keys move the choice and it works in a form. Standalone, give it a
        <.inline_code>click</.inline_code>
        event; it sends the chosen value as the
        <.inline_code>value</.inline_code>
        param.
      </.prose>

      <.component_demo title="Segmented" code={segmented_code()}>
        <div class="space-y-5">
          <div class="flex flex-wrap items-center gap-4">
            <.segmented id="view-mode" label="View" name="view" value={@view} click="set_view">
              <:option value="list" label="List" />
              <:option value="grid" label="Grid" />
              <:option value="board" label="Board" />
            </.segmented>
            <span id="view-mode-state" class="text-sm text-muted-foreground">Showing: {@view}</span>
          </div>

          <.segmented id="view-icons" label="Layout" name="layout" value={@view} click="set_view">
            <:option value="list" title="List"><.icon name="lucide-list" class="size-4" /></:option>
            <:option value="grid" title="Grid">
              <.icon name="lucide-layout-grid" class="size-4" />
            </:option>
          </.segmented>

          <form id="unit-form" phx-change="change_unit" class="flex items-center gap-4">
            <.segmented id="unit" label="Unit" name="unit" value={@unit}>
              <:option value="metric" label="Metric" />
              <:option value="imperial" label="Imperial" />
            </.segmented>
            <span class="text-sm text-muted-foreground">In a form: {@unit}</span>
          </form>
        </div>
      </.component_demo>

      <.section_heading id="filter-tabs">Filter tabs</.section_heading>
      <.prose>
        <.inline_code>filter_tabs</.inline_code>
        is the "All · Mine · Waiting" row with counts. Each choice is a link
        (<.inline_code>patch</.inline_code>
        or <.inline_code>navigate</.inline_code>, marked <.inline_code>aria-current</.inline_code>)
        or a button (<.inline_code>click</.inline_code>, marked <.inline_code>aria-pressed</.inline_code>).
      </.prose>

      <.component_demo title="Filter tabs" code={filter_code()}>
        <div class="space-y-4 w-full">
          <.filter_tabs id="inbox-filter" label="Filter inbox">
            <:item label="All" count={42} active={@filter == "all"} click="set_filter" value="all" />
            <:item label="Mine" count={3} active={@filter == "mine"} click="set_filter" value="mine" />
            <:item
              label="Waiting"
              count={9}
              active={@filter == "waiting"}
              click="set_filter"
              value="waiting"
            />
            <:item label="Done" active={@filter == "done"} click="set_filter" value="done" />
          </.filter_tabs>
          <p id="inbox-filter-state" class="text-sm text-muted-foreground">Showing: {@filter}</p>
        </div>
      </.component_demo>

      <.prose>
        Looking for tabs that change the URL? See <.link
          navigate="/docs/components/url-tabs"
          class="underline"
        >URL tabs</.link>.
      </.prose>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          Tab switching is client-side only - no server round-trip required.
        </.list_item>
        <.list_item>
          Full keyboard navigation: Arrow Left/Right to switch tabs, Home/End for first/last.
        </.list_item>
        <.list_item>
          Implements the WAI-ARIA tabs pattern with proper tablist/tab/tabpanel roles.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.tabs id="my-tabs" default_value="account">
      <:tab value="account">Account</:tab>
      <:tab value="password">Password</:tab>
      <:tab value="settings">Settings</:tab>
      <:panel value="account">
        <p>Account content here.</p>
      </:panel>
      <:panel value="password">
        <p>Password content here.</p>
      </:panel>
      <:panel value="settings">
        <p>Settings content here.</p>
      </:panel>
    </.tabs>\
    """
  end

  defp disabled_code do
    """
    <.tabs id="my-tabs" default_value="tab1">
      <:tab value="tab1">Active</:tab>
      <:tab value="tab2" disabled>Disabled</:tab>
      <:tab value="tab3">Also Active</:tab>
      <:panel value="tab1">First tab content.</:panel>
      <:panel value="tab2">Disabled tab content.</:panel>
      <:panel value="tab3">Third tab content.</:panel>
    </.tabs>\
    """
  end

  defp segmented_code do
    """
    <.segmented id="view" label="View" name="view" value={@view} click="set_view">
      <:option value="list" label="List" />
      <:option value="grid" label="Grid" />
    </.segmented>

    <%!-- In a form: the form's phx-change receives the value --%>
    <.form for={@form} phx-change="validate">
      <.segmented id="unit" label="Unit" field={@form[:unit]}>
        <:option value="metric" label="Metric" />
        <:option value="imperial" label="Imperial" />
      </.segmented>
    </.form>\
    """
  end

  defp filter_code do
    """
    <.filter_tabs id="inbox-filter" label="Filter inbox">
      <:item label="All" count={42} active={@filter == "all"} click="set_filter" value="all" />
      <:item label="Mine" count={3} active={@filter == "mine"} patch={~p"/inbox?filter=mine"} />
    </.filter_tabs>\
    """
  end
end
