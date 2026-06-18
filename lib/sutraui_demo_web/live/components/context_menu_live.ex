defmodule SutrauiDemoWeb.Components.ContextMenuLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Context Menu")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/context-menu">
      <.docs_header
        title="Context Menu"
        description="Displays actions from a right click, long press, or keyboard context-menu command."
      />

      <.component_demo
        title="Basic"
        code={basic_code()}
        class="[&_.demo-preview]:min-h-[300px]"
      >
        <.context_menu id="message-context-menu">
          <:trigger>
            <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
              Right click here
            </div>
          </:trigger>
          <.context_menu_label>Message</.context_menu_label>
          <.context_menu_item>
            <span class="flex items-center gap-2">
              <.icon name="lucide-reply" class="size-4" /> Reply
            </span>
          </.context_menu_item>
          <.context_menu_item>
            <span class="flex items-center gap-2">
              <.icon name="lucide-copy" class="size-4" /> Copy link
            </span>
          </.context_menu_item>
          <.context_menu_separator />
          <.context_menu_item variant="destructive">
            <span class="flex items-center gap-2">
              <.icon name="lucide-trash-2" class="size-4" /> Delete
            </span>
          </.context_menu_item>
        </.context_menu>
      </.component_demo>

      <.section_heading id="with-shortcuts">With Shortcuts</.section_heading>
      <.prose>
        Display keyboard hints with the
        <.inline_code>shortcut</.inline_code>
        prop on
        <.inline_code>context_menu_item</.inline_code>
        .
      </.prose>

      <.component_demo
        title="With Shortcuts"
        code={shortcuts_code()}
        class="[&_.demo-preview]:min-h-[300px]"
      >
        <.context_menu id="editor-context-menu">
          <:trigger>
            <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
              Right click the editor
            </div>
          </:trigger>
          <.context_menu_item shortcut="⌘Z">Undo</.context_menu_item>
          <.context_menu_item shortcut="⇧⌘Z">Redo</.context_menu_item>
          <.context_menu_separator />
          <.context_menu_item shortcut="⌘C">Copy</.context_menu_item>
          <.context_menu_item shortcut="⌘V">Paste</.context_menu_item>
        </.context_menu>
      </.component_demo>

      <.section_heading id="with-submenu">With Submenu</.section_heading>
      <.prose>
        Nest
        <.inline_code>context_menu_sub</.inline_code>
        with a
        <.inline_code>:trigger</.inline_code>
        slot and menu items to build submenus.
      </.prose>

      <.component_demo
        title="With Submenu"
        code={submenu_code()}
        class="[&_.demo-preview]:min-h-[300px]"
      >
        <.context_menu id="share-context-menu">
          <:trigger>
            <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
              Right click to share
            </div>
          </:trigger>
          <.context_menu_item>
            <span class="flex items-center gap-2">
              <.icon name="lucide-external-link" class="size-4" /> Open
            </span>
          </.context_menu_item>
          <.context_menu_separator />
          <.context_menu_sub>
            <:trigger>Share</:trigger>
            <.context_menu_item>Copy link</.context_menu_item>
            <.context_menu_item>Email</.context_menu_item>
            <.context_menu_item>Twitter</.context_menu_item>
          </.context_menu_sub>
        </.context_menu>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.context_menu id="message-context-menu">
      <:trigger>
        <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
          Right click here
        </div>
      </:trigger>
      <.context_menu_label>Message</.context_menu_label>
      <.context_menu_item>
        <span class="flex items-center gap-2">
          <.icon name="lucide-reply" class="size-4" /> Reply
        </span>
      </.context_menu_item>
      <.context_menu_item>
        <span class="flex items-center gap-2">
          <.icon name="lucide-copy" class="size-4" /> Copy link
        </span>
      </.context_menu_item>
      <.context_menu_separator />
      <.context_menu_item variant="destructive">
        <span class="flex items-center gap-2">
          <.icon name="lucide-trash-2" class="size-4" /> Delete
        </span>
      </.context_menu_item>
    </.context_menu>\
    """
  end

  defp shortcuts_code do
    """
    <.context_menu id="editor-context-menu">
      <:trigger>
        <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
          Right click the editor
        </div>
      </:trigger>
      <.context_menu_item shortcut="⌘Z">Undo</.context_menu_item>
      <.context_menu_item shortcut="⇧⌘Z">Redo</.context_menu_item>
      <.context_menu_separator />
      <.context_menu_item shortcut="⌘C">Copy</.context_menu_item>
      <.context_menu_item shortcut="⌘V">Paste</.context_menu_item>
    </.context_menu>\
    """
  end

  defp submenu_code do
    """
    <.context_menu id="share-context-menu">
      <:trigger>
        <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
          Right click to share
        </div>
      </:trigger>
      <.context_menu_item>
        <span class="flex items-center gap-2">
          <.icon name="lucide-external-link" class="size-4" /> Open
        </span>
      </.context_menu_item>
      <.context_menu_separator />
      <.context_menu_sub>
        <:trigger>Share</:trigger>
        <.context_menu_item>Copy link</.context_menu_item>
        <.context_menu_item>Email</.context_menu_item>
        <.context_menu_item>Twitter</.context_menu_item>
      </.context_menu_sub>
    </.context_menu>\
    """
  end
end
