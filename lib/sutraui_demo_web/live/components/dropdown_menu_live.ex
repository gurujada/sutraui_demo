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

      <.component_demo
        title="Basic"
        code={basic_code()}
        class="[&_.demo-preview]:min-h-[220px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <.dropdown_menu id="demo-dropdown-1">
          <:trigger>Open Menu</:trigger>
          <.dropdown_item>Profile</.dropdown_item>
          <.dropdown_item>Settings</.dropdown_item>
          <.dropdown_separator />
          <.dropdown_item variant="destructive">Log out</.dropdown_item>
        </.dropdown_menu>
      </.component_demo>

      <.section_heading id="with-icons">With Icons</.section_heading>
      <.prose>
        Add icons to menu items for better visual communication.
      </.prose>

      <.component_demo
        title="With Icons"
        code={icons_code()}
        class="[&_.demo-preview]:min-h-[280px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <.dropdown_menu id="demo-dropdown-icons">
          <:trigger>Actions</:trigger>
          <.dropdown_item>
            <span class="flex items-center gap-2">
              <.icon name="lucide-user" class="size-4" /> Profile
            </span>
          </.dropdown_item>
          <.dropdown_item>
            <span class="flex items-center gap-2">
              <.icon name="lucide-settings" class="size-4" /> Settings
            </span>
          </.dropdown_item>
          <.dropdown_item>
            <span class="flex items-center gap-2">
              <.icon name="lucide-credit-card" class="size-4" /> Billing
            </span>
          </.dropdown_item>
          <.dropdown_separator />
          <.dropdown_item variant="destructive">
            <span class="flex items-center gap-2">
              <.icon name="lucide-log-out" class="size-4" /> Log out
            </span>
          </.dropdown_item>
        </.dropdown_menu>
      </.component_demo>

      <.section_heading id="with-shortcuts">With Shortcuts</.section_heading>
      <.prose>
        Display keyboard shortcuts alongside menu items using the
        <.inline_code>shortcut</.inline_code>
        prop.
      </.prose>

      <.component_demo
        title="With Shortcuts"
        code={shortcuts_code()}
        class="[&_.demo-preview]:min-h-[220px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <.dropdown_menu id="demo-dropdown-2">
          <:trigger>File</:trigger>
          <.dropdown_item shortcut="⌘N">New File</.dropdown_item>
          <.dropdown_item shortcut="⌘O">Open</.dropdown_item>
          <.dropdown_item shortcut="⌘S">Save</.dropdown_item>
          <.dropdown_separator />
          <.dropdown_item shortcut="⌘Q" variant="destructive">Quit</.dropdown_item>
        </.dropdown_menu>
      </.component_demo>

      <.section_heading id="icons-and-shortcuts">Icons with Shortcuts</.section_heading>
      <.prose>
        Combine icons and keyboard shortcuts for a complete menu experience.
      </.prose>

      <.component_demo
        title="Icons and Shortcuts"
        code={icons_shortcuts_code()}
        class="[&_.demo-preview]:min-h-[280px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <.dropdown_menu id="demo-dropdown-full">
          <:trigger>Edit</:trigger>
          <.dropdown_item shortcut="⌘Z">
            <span class="flex items-center gap-2">
              <.icon name="lucide-undo" class="size-4" /> Undo
            </span>
          </.dropdown_item>
          <.dropdown_item shortcut="⇧⌘Z">
            <span class="flex items-center gap-2">
              <.icon name="lucide-redo" class="size-4" /> Redo
            </span>
          </.dropdown_item>
          <.dropdown_separator />
          <.dropdown_item shortcut="⌘X">
            <span class="flex items-center gap-2">
              <.icon name="lucide-scissors" class="size-4" /> Cut
            </span>
          </.dropdown_item>
          <.dropdown_item shortcut="⌘C">
            <span class="flex items-center gap-2">
              <.icon name="lucide-copy" class="size-4" /> Copy
            </span>
          </.dropdown_item>
          <.dropdown_item shortcut="⌘V">
            <span class="flex items-center gap-2">
              <.icon name="lucide-clipboard" class="size-4" /> Paste
            </span>
          </.dropdown_item>
        </.dropdown_menu>
      </.component_demo>

      <.section_heading id="with-labels">With Labels and Groups</.section_heading>
      <.prose>
        Organize items with labels and separators.
      </.prose>

      <.component_demo
        title="With Labels"
        code={labels_code()}
        class="[&_.demo-preview]:min-h-[280px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <.dropdown_menu id="demo-dropdown-3">
          <:trigger>My Account</:trigger>
          <.dropdown_label>My Account</.dropdown_label>
          <.dropdown_item>Profile</.dropdown_item>
          <.dropdown_item>Billing</.dropdown_item>
          <.dropdown_separator />
          <.dropdown_label>Team</.dropdown_label>
          <.dropdown_item>Invite Members</.dropdown_item>
          <.dropdown_item>Settings</.dropdown_item>
        </.dropdown_menu>
      </.component_demo>

      <.section_heading id="notes">Usage Notes</.section_heading>
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
      <:trigger>Open Menu</:trigger>
      <.dropdown_item>Profile</.dropdown_item>
      <.dropdown_item>Settings</.dropdown_item>
      <.dropdown_separator />
      <.dropdown_item variant="destructive">Log out</.dropdown_item>
    </.dropdown_menu>\
    """
  end

  defp icons_code do
    """
    <.dropdown_menu id="actions-menu">
      <:trigger>Actions</:trigger>
      <.dropdown_item>
        <span class="flex items-center gap-2">
          <.icon name="lucide-user" class="size-4" /> Profile
        </span>
      </.dropdown_item>
      <.dropdown_item>
        <span class="flex items-center gap-2">
          <.icon name="lucide-settings" class="size-4" /> Settings
        </span>
      </.dropdown_item>
      <.dropdown_separator />
      <.dropdown_item variant="destructive">
        <span class="flex items-center gap-2">
          <.icon name="lucide-log-out" class="size-4" /> Log out
        </span>
      </.dropdown_item>
    </.dropdown_menu>\
    """
  end

  defp shortcuts_code do
    """
    <.dropdown_menu id="file-menu">
      <:trigger>File</:trigger>
      <.dropdown_item shortcut="⌘N">New File</.dropdown_item>
      <.dropdown_item shortcut="⌘O">Open</.dropdown_item>
      <.dropdown_item shortcut="⌘S">Save</.dropdown_item>
      <.dropdown_separator />
      <.dropdown_item shortcut="⌘Q" variant="destructive">Quit</.dropdown_item>
    </.dropdown_menu>\
    """
  end

  defp icons_shortcuts_code do
    """
    <.dropdown_menu id="edit-menu">
      <:trigger>Edit</:trigger>
      <.dropdown_item shortcut="⌘Z">
        <span class="flex items-center gap-2">
          <.icon name="lucide-undo" class="size-4" /> Undo
        </span>
      </.dropdown_item>
      <.dropdown_item shortcut="⌘C">
        <span class="flex items-center gap-2">
          <.icon name="lucide-copy" class="size-4" /> Copy
        </span>
      </.dropdown_item>
      <.dropdown_item shortcut="⌘V">
        <span class="flex items-center gap-2">
          <.icon name="lucide-clipboard" class="size-4" /> Paste
        </span>
      </.dropdown_item>
    </.dropdown_menu>\
    """
  end

  defp labels_code do
    """
    <.dropdown_menu id="account-menu">
      <:trigger>My Account</:trigger>
      <.dropdown_label>My Account</.dropdown_label>
      <.dropdown_item>Profile</.dropdown_item>
      <.dropdown_item>Billing</.dropdown_item>
      <.dropdown_separator />
      <.dropdown_label>Team</.dropdown_label>
      <.dropdown_item>Invite Members</.dropdown_item>
      <.dropdown_item>Settings</.dropdown_item>
    </.dropdown_menu>\
    """
  end
end
