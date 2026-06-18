defmodule SutrauiDemoWeb.Components.ContextMenuLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Context Menu",
       auto_save: true,
       view_mode: "list",
       last_action: nil
     )}
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
        <div class="grid w-full gap-4">
          <.context_menu id="message-menu" trigger_class="w-full">
            <:trigger>
              <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
                Right click here
              </div>
            </:trigger>
            <.context_menu_label>Message</.context_menu_label>
            <.context_menu_item phx-click="reply">
              <.icon name="lucide-reply" class="size-4" /> Reply
            </.context_menu_item>
            <.context_menu_item phx-click="copy-link" phx-value-id="message-42">
              <.icon name="lucide-copy" class="size-4" /> Copy link
            </.context_menu_item>
            <.context_menu_separator />
            <.context_menu_item variant="destructive" phx-click="delete">
              <.icon name="lucide-trash-2" class="size-4" /> Delete
            </.context_menu_item>
          </.context_menu>
          <p :if={@last_action} class="text-sm text-muted-foreground">
            Action: <span class="font-medium text-foreground">{@last_action}</span>
          </p>
        </div>
      </.component_demo>

      <.prose>
        Menu items accept normal LiveView bindings. Put
        <.inline_code>phx-click</.inline_code>
        on the item, and pass context with
        <.inline_code>phx-value-*</.inline_code>
        or
        <.inline_code>phx-target</.inline_code>
        when the action belongs to a component.
      </.prose>

      <.section_heading id="shortcuts">With Shortcuts</.section_heading>
      <.prose>
        Display keyboard hints with the
        <.inline_code>shortcut</.inline_code>
        prop on <.inline_code>context_menu_item</.inline_code>.
      </.prose>

      <.component_demo
        title="With Shortcuts"
        code={shortcuts_code()}
        class="[&_.demo-preview]:min-h-[300px]"
      >
        <.context_menu id="editor-menu" trigger_class="w-full">
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

      <.section_heading id="checkbox-radio">Checkbox And Radio Items</.section_heading>
      <.prose>
        Use
        <.inline_code>context_menu_checkbox_item</.inline_code>
        for toggleable boolean states and
        <.inline_code>context_menu_radio_item</.inline_code>
        for mutually exclusive choices. Both show an indicator when checked.
      </.prose>

      <.component_demo
        title="Checkbox And Radio"
        code={checkbox_radio_code()}
        class="[&_.demo-preview]:min-h-[300px]"
      >
        <.context_menu id="settings-menu" trigger_class="w-full">
          <:trigger>
            <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
              Right click for settings
            </div>
          </:trigger>
          <.context_menu_label>Preferences</.context_menu_label>
          <.context_menu_checkbox_item checked={@auto_save} phx-click="toggle-autosave">
            Auto-save
          </.context_menu_checkbox_item>
          <.context_menu_separator />
          <.context_menu_label>View</.context_menu_label>
          <.context_menu_radio_item
            value="list"
            checked={@view_mode == "list"}
            phx-click="set-view"
            phx-value-mode="list"
          >
            List view
          </.context_menu_radio_item>
          <.context_menu_radio_item
            value="grid"
            checked={@view_mode == "grid"}
            phx-click="set-view"
            phx-value-mode="grid"
          >
            Grid view
          </.context_menu_radio_item>
          <.context_menu_radio_item
            value="compact"
            checked={@view_mode == "compact"}
            phx-click="set-view"
            phx-value-mode="compact"
          >
            Compact view
          </.context_menu_radio_item>
        </.context_menu>
      </.component_demo>

      <.section_heading id="submenu">With Submenu</.section_heading>
      <.prose>
        Nest
        <.inline_code>context_menu_sub</.inline_code>
        with a
        <.inline_code>:trigger</.inline_code>
        slot and menu items to build submenus. Submenus open on hover (mouse)
        and on Right-arrow (keyboard); Left-arrow or Escape closes them.
      </.prose>

      <.component_demo
        title="With Submenu"
        code={submenu_code()}
        class="[&_.demo-preview]:min-h-[300px]"
      >
        <.context_menu id="share-menu" trigger_class="w-full">
          <:trigger>
            <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
              Right click to share
            </div>
          </:trigger>
          <.context_menu_item>
            <.icon name="lucide-external-link" class="size-4" /> Open
          </.context_menu_item>
          <.context_menu_separator />
          <.context_menu_sub>
            <:trigger>Share</:trigger>
            <.context_menu_item phx-click="copy-link">Copy link</.context_menu_item>
            <.context_menu_item phx-click="email">Email</.context_menu_item>
            <.context_menu_item phx-click="twitter">Twitter</.context_menu_item>
          </.context_menu_sub>
        </.context_menu>
      </.component_demo>
    </Layouts.docs>
    """
  end

  def handle_event("toggle-autosave", _params, socket) do
    {:noreply, assign(socket, auto_save: !socket.assigns.auto_save)}
  end

  def handle_event("set-view", %{"mode" => mode}, socket) do
    {:noreply, assign(socket, view_mode: mode)}
  end

  def handle_event("copy-link", params, socket) do
    action =
      case params do
        %{"id" => id} -> "copy-link #{id}"
        _ -> "copy-link"
      end

    {:noreply, assign(socket, last_action: action)}
  end

  def handle_event(event, _params, socket)
      when event in ["reply", "copy-link", "delete", "email", "twitter"] do
    {:noreply, assign(socket, last_action: event)}
  end

  def handle_event(_event, _params, socket), do: {:noreply, socket}

  defp basic_code do
    """
    <.context_menu id="message-menu" trigger_class="w-full">
      <:trigger>
        <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
          Right click here
        </div>
      </:trigger>
      <.context_menu_label>Message</.context_menu_label>
      <.context_menu_item phx-click="reply">
        <.icon name="lucide-reply" class="size-4" /> Reply
      </.context_menu_item>
      <.context_menu_item phx-click="copy-link" phx-value-id="message-42">
        <.icon name="lucide-copy" class="size-4" /> Copy link
      </.context_menu_item>
      <.context_menu_separator />
      <.context_menu_item variant="destructive" phx-click="delete">
        <.icon name="lucide-trash-2" class="size-4" /> Delete
      </.context_menu_item>
    </.context_menu>
    <p :if={@last_action} class="text-sm text-muted-foreground">
      Action: <span class="font-medium text-foreground">{@last_action}</span>
    </p>\
    """
  end

  defp shortcuts_code do
    """
    <.context_menu id="editor-menu" trigger_class="w-full">
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

  defp checkbox_radio_code do
    """
    <.context_menu id="settings-menu" trigger_class="w-full">
      <:trigger>
        <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
          Right click for settings
        </div>
      </:trigger>
      <.context_menu_label>Preferences</.context_menu_label>
      <.context_menu_checkbox_item checked={@auto_save} phx-click="toggle-autosave">
        Auto-save
      </.context_menu_checkbox_item>
      <.context_menu_separator />
      <.context_menu_label>View</.context_menu_label>
      <.context_menu_radio_item value="list" checked={@view_mode == "list"} phx-click="set-view" phx-value-mode="list">
        List view
      </.context_menu_radio_item>
      <.context_menu_radio_item value="grid" checked={@view_mode == "grid"} phx-click="set-view" phx-value-mode="grid">
        Grid view
      </.context_menu_radio_item>
      <.context_menu_radio_item value="compact" checked={@view_mode == "compact"} phx-click="set-view" phx-value-mode="compact">
        Compact view
      </.context_menu_radio_item>
    </.context_menu>\
    """
  end

  defp submenu_code do
    """
    <.context_menu id="share-menu" trigger_class="w-full">
      <:trigger>
        <div class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed border-border text-sm text-muted-foreground">
          Right click to share
        </div>
      </:trigger>
      <.context_menu_item>
        <.icon name="lucide-external-link" class="size-4" /> Open
      </.context_menu_item>
      <.context_menu_separator />
      <.context_menu_sub>
        <:trigger>Share</:trigger>
        <.context_menu_item phx-click="copy-link">Copy link</.context_menu_item>
        <.context_menu_item phx-click="email">Email</.context_menu_item>
        <.context_menu_item phx-click="twitter">Twitter</.context_menu_item>
      </.context_menu_sub>
    </.context_menu>\
    """
  end
end
