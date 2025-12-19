defmodule SutrauiDemoWeb.Components.DropdownMenuLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Dropdown Menu")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/dropdown-menu">
      <.docs_header
        title="Dropdown Menu"
        description="Dropdown menu with full keyboard navigation and accessibility support."
      />

      <.component_demo title="Basic" code={basic_code()}>
        <.dropdown_menu id="demo-dropdown-1">
          <:trigger>
            <.button variant="outline">
              Open Menu <.icon name="hero-chevron-down" class="ml-2 h-4 w-4" />
            </.button>
          </:trigger>
          <.dropdown_item>Profile</.dropdown_item>
          <.dropdown_item>Settings</.dropdown_item>
          <.dropdown_separator />
          <.dropdown_item variant="destructive">Log out</.dropdown_item>
        </.dropdown_menu>
      </.component_demo>

      <.section_heading id="with-shortcuts">With Shortcuts</.section_heading>
      <.prose>
        Display keyboard shortcuts alongside menu items.
      </.prose>

      <.component_demo title="With Shortcuts" code={shortcuts_code()}>
        <.dropdown_menu id="demo-dropdown-2">
          <:trigger>
            <.button variant="outline">Actions</.button>
          </:trigger>
          <.dropdown_item shortcut="Ctrl+N">New File</.dropdown_item>
          <.dropdown_item shortcut="Ctrl+O">Open</.dropdown_item>
          <.dropdown_item shortcut="Ctrl+S">Save</.dropdown_item>
          <.dropdown_separator />
          <.dropdown_item shortcut="Ctrl+Q" variant="destructive">Quit</.dropdown_item>
        </.dropdown_menu>
      </.component_demo>

      <.section_heading id="with-labels">With Labels and Groups</.section_heading>
      <.prose>
        Organize items with labels and separators.
      </.prose>

      <.component_demo title="With Labels" code={labels_code()}>
        <.dropdown_menu id="demo-dropdown-3">
          <:trigger>
            <.button variant="outline">My Account</.button>
          </:trigger>
          <.dropdown_label>My Account</.dropdown_label>
          <.dropdown_item>Profile</.dropdown_item>
          <.dropdown_item>Billing</.dropdown_item>
          <.dropdown_separator />
          <.dropdown_label>Team</.dropdown_label>
          <.dropdown_item>Invite Members</.dropdown_item>
          <.dropdown_item>Settings</.dropdown_item>
        </.dropdown_menu>
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          Full keyboard navigation: Arrow Up/Down to navigate, Enter/Space to activate, Escape to close.
        </.list_item>
        <.list_item>
          Auto-closes when clicking outside or selecting an item.
        </.list_item>
        <.list_item>
          Use
          <.inline_code>side</.inline_code>
          and
          <.inline_code>align</.inline_code>
          props to control positioning.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.dropdown_menu id="my-menu">
      <:trigger>
        <.button variant="outline">Open Menu</.button>
      </:trigger>
      <.dropdown_item>Profile</.dropdown_item>
      <.dropdown_item>Settings</.dropdown_item>
      <.dropdown_separator />
      <.dropdown_item variant="destructive">Log out</.dropdown_item>
    </.dropdown_menu>\
    """
  end

  defp shortcuts_code do
    """
    <.dropdown_menu id="actions-menu">
      <:trigger>
        <.button variant="outline">Actions</.button>
      </:trigger>
      <.dropdown_item shortcut="Ctrl+N">New File</.dropdown_item>
      <.dropdown_item shortcut="Ctrl+O">Open</.dropdown_item>
      <.dropdown_item shortcut="Ctrl+S">Save</.dropdown_item>
    </.dropdown_menu>\
    """
  end

  defp labels_code do
    """
    <.dropdown_menu id="account-menu">
      <:trigger>
        <.button variant="outline">My Account</.button>
      </:trigger>
      <.dropdown_label>My Account</.dropdown_label>
      <.dropdown_item>Profile</.dropdown_item>
      <.dropdown_item>Billing</.dropdown_item>
      <.dropdown_separator />
      <.dropdown_label>Team</.dropdown_label>
      <.dropdown_item>Invite Members</.dropdown_item>
    </.dropdown_menu>\
    """
  end
end
