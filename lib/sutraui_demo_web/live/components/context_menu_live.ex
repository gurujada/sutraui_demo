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
        title="Default"
        code={default_code()}
        class="[&_.demo-preview]:min-h-[300px]"
      >
        <.context_menu id="message-context-menu">
          <:trigger>
            <div
              class="flex h-40 w-full items-center justify-center rounded-lg border-2 border-dashed text-sm"
              style="border-color: var(--border); color: var(--fg-muted);"
            >
              Right click here
            </div>
          </:trigger>
          <.context_menu_label>Message</.context_menu_label>
          <.context_menu_item>
            <.icon name="lucide-reply" class="size-4" /> Reply
          </.context_menu_item>
          <.context_menu_item shortcut="⌘C">
            <.icon name="lucide-copy" class="size-4" /> Copy link
          </.context_menu_item>
          <.context_menu_separator />
          <.context_menu_item variant="destructive">
            <.icon name="lucide-trash-2" class="size-4" /> Delete
          </.context_menu_item>
        </.context_menu>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.context_menu id="message-context-menu">
      <:trigger>
        <div>Right click here</div>
      </:trigger>
      <.context_menu_item>Reply</.context_menu_item>
      <.context_menu_item shortcut="⌘C">Copy link</.context_menu_item>
      <.context_menu_separator />
      <.context_menu_item variant="destructive">Delete</.context_menu_item>
    </.context_menu>\
    """
  end
end
