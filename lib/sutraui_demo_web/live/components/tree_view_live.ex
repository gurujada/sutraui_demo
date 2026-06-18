defmodule SutrauiDemoWeb.Components.TreeViewLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Tree View", selected_node: "general")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/tree-view">
      <.docs_header
        title="Tree View"
        description="A hierarchical disclosure tree for nested navigation and file structures."
      />

      <.component_demo title="File Browser" code={files_code()}>
        <div class="w-full max-w-sm">
          <.tree_view id="project-files-tree" label="Project files">
            <.tree_item label="lib" expanded>
              <.tree_item label="sutra_ui" expanded>
                <.tree_item label="button.ex" href="/docs/components/button" />
                <.tree_item label="calendar.ex" href="/docs/components/calendar" selected />
                <.tree_item label="dialog.ex" href="/docs/components/dialog" />
              </.tree_item>
            </.tree_item>
            <.tree_item label="priv" expanded>
              <.tree_item label="static">
                <.tree_item label="sutra_ui.css" href="/docs/theming" />
              </.tree_item>
            </.tree_item>
            <.tree_item label="README.md" href="/docs" />
          </.tree_view>
        </div>
      </.component_demo>

      <.section_heading id="interactive">Interactive Selection</.section_heading>
      <.prose>
        Pass a
        <.inline_code>select_event</.inline_code>
        to
        <.inline_code>tree_view</.inline_code>
        and a
        <.inline_code>value</.inline_code>
        on each
        <.inline_code>tree_item</.inline_code>
        to make leaf nodes selectable. The event includes a
        <.inline_code>node</.inline_code>
        param — no
        <.inline_code>phx-click</.inline_code>
        needed on each item.
      </.prose>

      <.component_demo title="Settings Tree" code={interactive_code()}>
        <div class="w-full max-w-sm">
          <.tree_view id="settings-tree" label="Settings" select_event="select_node">
            <.tree_item label="Workspace" expanded value="ws">
              <.tree_item label="General" value="general" selected={@selected_node == "general"} />
              <.tree_item label="Members" value="members" selected={@selected_node == "members"} />
              <.tree_item label="Billing" value="billing" selected={@selected_node == "billing"} />
            </.tree_item>
            <.tree_item
              label="Security"
              value="security"
              selected={@selected_node == "security"}
              disabled
            />
          </.tree_view>
          <p class="mt-4 text-sm text-muted-foreground">
            Selected: <strong class="text-foreground">{@selected_node}</strong>
          </p>
        </div>
      </.component_demo>

      <.section_heading id="custom-triggers">Custom Triggers</.section_heading>
      <.prose>
        Use the
        <.inline_code>:trigger</.inline_code>
        slot to replace the default label/icon with any content — icons,
        badges, or rich markup. The chevron and expand/collapse behavior stay
        intact.
      </.prose>

      <.component_demo title="Custom Triggers" code={custom_code()}>
        <div class="w-full max-w-sm">
          <.tree_view id="file-system-tree" label="File system">
            <.tree_item expanded>
              <:trigger>
                <.icon name="lucide-folder-open" class="size-4 text-muted-foreground" />
                <span class="font-medium">src</span>
              </:trigger>
              <.tree_item>
                <:trigger>
                  <.icon name="lucide-file-code" class="size-4 text-muted-foreground" />
                  <span>app.ex</span>
                </:trigger>
              </.tree_item>
              <.tree_item>
                <:trigger>
                  <.icon name="lucide-file-code" class="size-4 text-muted-foreground" />
                  <span>router.ex</span>
                </:trigger>
              </.tree_item>
            </.tree_item>
            <.tree_item>
              <:trigger>
                <.icon name="lucide-folder" class="size-4 text-muted-foreground" />
                <span>test</span>
              </:trigger>
              <.tree_item>
                <:trigger>
                  <.icon name="lucide-file-code" class="size-4 text-muted-foreground" />
                  <span>router_test.exs</span>
                </:trigger>
              </.tree_item>
            </.tree_item>
          </.tree_view>
        </div>
      </.component_demo>

      <.section_heading id="keyboard">Keyboard Navigation</.section_heading>
      <.prose>
        The tree implements the WAI-ARIA tree pattern with roving tabindex:
      </.prose>

      <.list>
        <.list_item>
          <strong>Up/Down</strong> — move between visible items
        </.list_item>
        <.list_item>
          <strong>Right</strong> — expand a collapsed folder, or move to its first child
        </.list_item>
        <.list_item>
          <strong>Left</strong> — collapse an expanded folder, or move to the parent
        </.list_item>
        <.list_item>
          <strong>Home/End</strong> — jump to the first/last visible item
        </.list_item>
        <.list_item>
          <strong>Enter/Space</strong> — activate the item (follow link or emit select event)
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  def handle_event("select_node", %{"node" => node}, socket) do
    {:noreply, assign(socket, selected_node: node)}
  end

  defp files_code do
    """
    <.tree_view id="project-files-tree" label="Project files">
      <.tree_item label="lib" expanded>
        <.tree_item label="sutra_ui" expanded>
          <.tree_item label="button.ex" href="/docs/components/button" />
          <.tree_item label="calendar.ex" href="/docs/components/calendar" selected />
          <.tree_item label="dialog.ex" href="/docs/components/dialog" />
        </.tree_item>
      </.tree_item>
      <.tree_item label="priv" expanded>
        <.tree_item label="static">
          <.tree_item label="sutra_ui.css" href="/docs/theming" />
        </.tree_item>
      </.tree_item>
      <.tree_item label="README.md" href="/docs" />
    </.tree_view>\
    """
  end

  defp interactive_code do
    """
    <.tree_view id="settings-tree" label="Settings" select_event="select_node">
      <.tree_item label="Workspace" expanded value="ws">
        <.tree_item label="General" value="general" selected={@selected_node == "general"} />
        <.tree_item label="Members" value="members" selected={@selected_node == "members"} />
        <.tree_item label="Billing" value="billing" selected={@selected_node == "billing"} />
      </.tree_item>
      <.tree_item
        label="Security"
        value="security"
        selected={@selected_node == "security"}
        disabled
      />
    </.tree_view>
    <p class="text-sm text-muted-foreground">
      Selected: <strong class="text-foreground">{@selected_node}</strong>
    </p>\
    """
  end

  defp custom_code do
    """
    <.tree_view id="file-system-tree" label="File system">
      <.tree_item expanded>
        <:trigger>
          <.icon name="lucide-folder-open" class="size-4 text-muted-foreground" />
          <span class="font-medium">src</span>
        </:trigger>
        <.tree_item>
          <:trigger>
            <.icon name="lucide-file-code" class="size-4 text-muted-foreground" />
            <span>app.ex</span>
          </:trigger>
        </.tree_item>
        <.tree_item>
          <:trigger>
            <.icon name="lucide-file-code" class="size-4 text-muted-foreground" />
            <span>router.ex</span>
          </:trigger>
        </.tree_item>
      </.tree_item>
      <.tree_item>
        <:trigger>
          <.icon name="lucide-folder" class="size-4 text-muted-foreground" />
          <span>test</span>
        </:trigger>
        <.tree_item>
          <:trigger>
            <.icon name="lucide-file-code" class="size-4 text-muted-foreground" />
            <span>router_test.exs</span>
          </:trigger>
        </.tree_item>
      </.tree_item>
    </.tree_view>\
    """
  end
end
