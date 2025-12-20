defmodule SutrauiDemoWeb.Components.FilterBarLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Filter Bar",
       search: "",
       status: "",
       category: "",
       has_filters: false
     )}
  end

  def handle_event("filter", params, socket) do
    search = params["search"] || ""
    status = params["status"] || ""
    category = params["category"] || ""
    has_filters = search != "" or status != "" or category != ""

    {:noreply,
     assign(socket,
       search: search,
       status: status,
       category: category,
       has_filters: has_filters
     )}
  end

  def handle_event("clear_filters", _params, socket) do
    {:noreply,
     assign(socket,
       search: "",
       status: "",
       category: "",
       has_filters: false
     )}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/filter-bar">
      <.docs_header
        title="Filter Bar"
        description="A standardized filter bar for index pages with responsive grid layout and optional clear button."
      />

      <.component_demo title="Basic" code={basic_code()}>
        <.filter_bar on_change="filter">
          <:filter>
            <input type="text" name="search" value={@search} placeholder="Search..." class="input" />
          </:filter>
          <:filter>
            <select name="status" class="select">
              <option value="" selected={@status == ""}>All Statuses</option>
              <option value="active" selected={@status == "active"}>Active</option>
              <option value="inactive" selected={@status == "inactive"}>Inactive</option>
            </select>
          </:filter>
        </.filter_bar>
      </.component_demo>

      <.section_heading id="with-clear-button">With Clear Button</.section_heading>
      <.prose>
        Show a clear button when filters are active using
        <.inline_code>show_clear</.inline_code>
        and
        <.inline_code>on_clear</.inline_code>
        props.
      </.prose>

      <.component_demo title="With Clear" code={clear_code()}>
        <.filter_bar on_change="filter" on_clear="clear_filters" show_clear={@has_filters}>
          <:filter>
            <input
              type="text"
              name="search"
              value={@search}
              placeholder="Search products..."
              class="input"
            />
          </:filter>
          <:filter>
            <select name="status" class="select">
              <option value="" selected={@status == ""}>All Statuses</option>
              <option value="active" selected={@status == "active"}>Active</option>
              <option value="archived" selected={@status == "archived"}>Archived</option>
            </select>
          </:filter>
          <:filter>
            <select name="category" class="select">
              <option value="" selected={@category == ""}>All Categories</option>
              <option value="electronics" selected={@category == "electronics"}>Electronics</option>
              <option value="clothing" selected={@category == "clothing"}>Clothing</option>
              <option value="books" selected={@category == "books"}>Books</option>
            </select>
          </:filter>
        </.filter_bar>

        <div
          :if={@has_filters}
          class="mt-4 p-3 rounded-lg text-sm"
          style="background: var(--bg-subtle);"
        >
          Active filters: {if @search != "", do: "search=\"#{@search}\" ", else: ""}{if @status != "",
            do: "status=\"#{@status}\" ",
            else: ""}{if @category != "", do: "category=\"#{@category}\"", else: ""}
        </div>
      </.component_demo>

      <.section_heading id="column-count">Column Count</.section_heading>
      <.prose>
        Control the grid layout with the
        <.inline_code>cols</.inline_code>
        prop (1-6 columns).
      </.prose>

      <.component_demo title="Two Columns" code={cols_code()}>
        <.filter_bar on_change="filter" cols={2}>
          <:filter>
            <input type="text" name="search" value={@search} placeholder="Search..." class="input" />
          </:filter>
          <:filter>
            <select name="status" class="select">
              <option value="" selected={@status == ""}>All</option>
              <option value="active" selected={@status == "active"}>Active</option>
              <option value="inactive" selected={@status == "inactive"}>Inactive</option>
            </select>
          </:filter>
        </.filter_bar>
      </.component_demo>

      <.component_demo title="Four Columns" code={four_cols_code()}>
        <.filter_bar on_change="filter" cols={4}>
          <:filter>
            <input type="text" name="name" value="" placeholder="Name" class="input" />
          </:filter>
          <:filter>
            <input type="text" name="email" value="" placeholder="Email" class="input" />
          </:filter>
          <:filter>
            <select name="role" class="select">
              <option value="">All Roles</option>
              <option value="admin">Admin</option>
              <option value="user">User</option>
            </select>
          </:filter>
          <:filter>
            <select name="status" class="select">
              <option value="">All</option>
              <option value="active">Active</option>
              <option value="inactive">Inactive</option>
            </select>
          </:filter>
        </.filter_bar>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.filter_bar on_change="filter">
      <:filter>
        <input type="text" name="search" value={@search} class="input" />
      </:filter>
      <:filter>
        <select name="status" class="select">
          <option value="">All</option>
          <option value="active">Active</option>
        </select>
      </:filter>
    </.filter_bar>\
    """
  end

  defp clear_code do
    """
    <.filter_bar on_change="filter" on_clear="clear_filters" show_clear={@has_filters}>
      <:filter>
        <input type="text" name="search" value={@search} class="input" />
      </:filter>
      <:filter>
        <select name="status" class="select">...</select>
      </:filter>
      <:filter>
        <select name="category" class="select">...</select>
      </:filter>
    </.filter_bar>\
    """
  end

  defp cols_code do
    """
    <.filter_bar on_change="filter" cols={2}>
      <:filter>
        <input type="text" name="search" class="input" />
      </:filter>
      <:filter>
        <select name="status" class="select">...</select>
      </:filter>
    </.filter_bar>\
    """
  end

  defp four_cols_code do
    """
    <.filter_bar on_change="filter" cols={4}>
      <:filter><input type="text" name="name" class="input" /></:filter>
      <:filter><input type="text" name="email" class="input" /></:filter>
      <:filter><select name="role" class="select">...</select></:filter>
      <:filter><select name="status" class="select">...</select></:filter>
    </.filter_bar>\
    """
  end
end
