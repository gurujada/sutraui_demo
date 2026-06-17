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
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.tree_view label="Project files">
      <.tree_item label="lib" expanded>
        <.tree_item label="sutra_ui">
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
end
