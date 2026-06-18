defmodule SutrauiDemoWeb.Components.TreeViewLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Tree View")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/tree-view">
      <.docs_header
        title="Tree View"
        description="A hierarchical disclosure tree for nested navigation and file structures."
      />

      <.component_demo title="Default" code={default_code()}>
        <div class="w-full max-w-sm">
          <.tree_view label="Project files">
            <.tree_item label="lib" expanded>
              <.tree_item label="sutra_ui" expanded>
                <.tree_item label="button.ex" />
                <.tree_item label="calendar.ex" selected />
                <.tree_item label="context_menu.ex" />
              </.tree_item>
            </.tree_item>
            <.tree_item label="priv" expanded>
              <.tree_item label="static">
                <.tree_item label="sutra_ui.css" />
              </.tree_item>
            </.tree_item>
            <.tree_item label="README.md" href="/docs" />
          </.tree_view>
        </div>
      </.component_demo>

      <.section_heading id="selected">Selected Item</.section_heading>
      <.prose>
        Mark the active node with <.inline_code>selected</.inline_code>. Disable a branch with <.inline_code>disabled</.inline_code>.
      </.prose>

      <.component_demo title="Navigation Tree" code={selected_code()}>
        <div class="w-full max-w-sm">
          <.tree_view label="Settings">
            <.tree_item label="Workspace" expanded>
              <.tree_item label="General" selected />
              <.tree_item label="Members" />
              <.tree_item label="Billing" />
            </.tree_item>
            <.tree_item label="Security" disabled />
          </.tree_view>
        </div>
      </.component_demo>

      <.section_heading id="with-links">With Links</.section_heading>
      <.prose>
        Leaf nodes render as anchors when you pass <.inline_code>href</.inline_code>. Folders with children stay collapsible
        <.inline_code>&lt;details&gt;</.inline_code>
        elements.
      </.prose>

      <.component_demo title="File Browser" code={links_code()}>
        <div class="w-full max-w-sm">
          <.tree_view label="Source files">
            <.tree_item label="src" expanded>
              <.tree_item label="components">
                <.tree_item label="button.ex" href="/files/button.ex" />
                <.tree_item label="dialog.ex" href="/files/dialog.ex" />
              </.tree_item>
              <.tree_item label="app.ex" href="/files/app.ex" selected />
            </.tree_item>
            <.tree_item label="tests" expanded>
              <.tree_item label="button_test.exs" href="/files/button_test.exs" />
            </.tree_item>
            <.tree_item label="mix.exs" href="/files/mix.exs" />
          </.tree_view>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.tree_view label="Project files">
      <.tree_item label="lib" expanded>
        <.tree_item label="sutra_ui" expanded>
          <.tree_item label="calendar.ex" selected />
        </.tree_item>
      </.tree_item>
      <.tree_item label="README.md" href="/docs" />
    </.tree_view>\
    """
  end

  defp selected_code do
    """
    <.tree_view label="Settings">
      <.tree_item label="Workspace" expanded>
        <.tree_item label="General" selected />
      </.tree_item>
      <.tree_item label="Security" disabled />
    </.tree_view>\
    """
  end

  defp links_code do
    """
    <.tree_view label="Source files">
      <.tree_item label="src" expanded>
        <.tree_item label="components">
          <.tree_item label="button.ex" href="/files/button.ex" />
          <.tree_item label="dialog.ex" href="/files/dialog.ex" />
        </.tree_item>
        <.tree_item label="app.ex" href="/files/app.ex" selected />
      </.tree_item>
      <.tree_item label="tests" expanded>
        <.tree_item label="button_test.exs" href="/files/button_test.exs" />
      </.tree_item>
      <.tree_item label="mix.exs" href="/files/mix.exs" />
    </.tree_view>\
    """
  end
end
