defmodule SutrauiDemoWeb.Components.TabsLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Tabs")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/tabs">
      <.docs_header
        title="Tabs"
        description="Tabbed interface with client-side switching and full keyboard navigation."
      />

      <.component_demo title="Basic Tabs" code={basic_code()}>
        <.tabs id="demo-tabs-1" default_value="account" class="w-full max-w-md">
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
        <.tabs id="demo-tabs-2" default_value="tab1" class="w-full max-w-md">
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
end
