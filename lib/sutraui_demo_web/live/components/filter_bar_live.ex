defmodule SutrauiDemoWeb.Components.FilterBarLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Filter Bar")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/filter-bar"
    >
      <.docs_header
        title="Filter Bar"
        description="A standardized filter bar for index pages with responsive grid layout and optional clear button."
      />

      <.callout variant="warning">
        <strong>Deprecated.</strong>
        Filtering moves to LiveTable 0.5 (filter chips).
        <.inline_code>filter_bar</.inline_code>
        is removed in SutraUI 0.6. The examples below are code only, because calling it now compiles with a deprecation warning.
      </.callout>

      <.code_block language="heex" code={basic_code()} />

      <.section_heading id="with-clear-button">With Clear Button</.section_heading>
      <.prose>
        Show a clear button when filters are active using
        <.inline_code>show_clear</.inline_code>
        and
        <.inline_code>on_clear</.inline_code>
        props.
      </.prose>

      <.code_block language="heex" code={clear_code()} />

      <.section_heading id="column-count">Column Count</.section_heading>
      <.prose>
        Control the grid layout with the
        <.inline_code>cols</.inline_code>
        prop (1-6 columns).
      </.prose>

      <.code_block language="heex" code={cols_code()} />

      <.code_block language="heex" code={four_cols_code()} />
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.filter_bar on_change="filter">
      <:filter>
        <.input type="text" name="search" value={@search} placeholder="Search..." />
      </:filter>
      <:filter>
        <.select id="status-select" name="status" value={@status}>
          <.select_option value="" label="All" />
          <.select_option value="active" label="Active" />
        </.select>
      </:filter>
    </.filter_bar>\
    """
  end

  defp clear_code do
    """
    <.filter_bar on_change="filter" on_clear="clear_filters" show_clear={@has_filters}>
      <:filter>
        <.input type="text" name="search" value={@search} placeholder="Search..." />
      </:filter>
      <:filter>
        <.select id="status-select" name="status" value={@status}>
          <.select_option value="" label="All Statuses" />
          <.select_option value="active" label="Active" />
        </.select>
      </:filter>
    </.filter_bar>\
    """
  end

  defp cols_code do
    """
    <.filter_bar on_change="filter" cols={2}>
      <:filter>
        <.input type="text" name="search" placeholder="Search..." />
      </:filter>
      <:filter>
        <.select id="status-select" name="status" value={@status}>
          <.select_option value="" label="All" />
          <.select_option value="active" label="Active" />
        </.select>
      </:filter>
    </.filter_bar>\
    """
  end

  defp four_cols_code do
    """
    <.filter_bar on_change="filter" cols={4}>
      <:filter><.input type="text" name="name" placeholder="Name" /></:filter>
      <:filter><.input type="text" name="email" placeholder="Email" /></:filter>
      <:filter>
        <.select id="role-select" name="role" value="">
          <.select_option value="" label="All Roles" />
          <.select_option value="admin" label="Admin" />
        </.select>
      </:filter>
      <:filter>
        <.select id="status-select" name="status" value="">
          <.select_option value="" label="All" />
          <.select_option value="active" label="Active" />
        </.select>
      </:filter>
    </.filter_bar>\
    """
  end
end
