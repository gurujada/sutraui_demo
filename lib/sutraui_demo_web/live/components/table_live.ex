defmodule SutrauiDemoWeb.Components.TableLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    users = [
      %{id: 1, name: "Alice Johnson", email: "alice@example.com", role: "Admin"},
      %{id: 2, name: "Bob Smith", email: "bob@example.com", role: "User"},
      %{id: 3, name: "Carol White", email: "carol@example.com", role: "Editor"}
    ]

    {:ok, assign(socket, page_title: "Table", users: users)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/table">
      <.docs_header
        title="Table"
        description="Table component with two variants: simple wrapper and data-driven."
      />

      <.section_heading id="data-table">Data Table</.section_heading>
      <.prose>
        The data table variant accepts a list of rows and uses slots to define columns.
      </.prose>

      <.component_demo title="Data Table" code={data_table_code()}>
        <.data_table rows={@users}>
          <:col :let={user} label="Name">{user.name}</:col>
          <:col :let={user} label="Email">{user.email}</:col>
          <:col :let={user} label="Role">
            <.badge variant="secondary">{user.role}</.badge>
          </:col>
          <:action :let={_user}>
            <.button size="sm" variant="ghost">Edit</.button>
          </:action>
        </.data_table>
      </.component_demo>

      <.section_heading id="simple-table">Simple Table</.section_heading>
      <.prose>
        For more control, use the simple table wrapper with manual HTML.
      </.prose>

      <.component_demo title="Simple Table" code={simple_table_code()}>
        <.table>
          <thead>
            <tr>
              <th>Invoice</th>
              <th>Status</th>
              <th class="text-right">Amount</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>INV001</td>
              <td>
                <.badge variant="success">Paid</.badge>
              </td>
              <td class="text-right">$250.00</td>
            </tr>
            <tr>
              <td>INV002</td>
              <td>
                <.badge variant="outline">Pending</.badge>
              </td>
              <td class="text-right">$150.00</td>
            </tr>
          </tbody>
        </.table>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp data_table_code do
    """
    <.data_table rows={@users}>
      <:col :let={user} label="Name">{user.name}</:col>
      <:col :let={user} label="Email">{user.email}</:col>
      <:col :let={user} label="Role">
        <.badge variant="secondary">{user.role}</.badge>
      </:col>
      <:action :let={user}>
        <.button size="sm" variant="ghost">Edit</.button>
      </:action>
    </.data_table>\
    """
  end

  defp simple_table_code do
    """
    <.table>
      <thead>
        <tr>
          <th>Invoice</th>
          <th>Status</th>
          <th class="text-right">Amount</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>INV001</td>
          <td><.badge variant="success">Paid</.badge></td>
          <td class="text-right">$250.00</td>
        </tr>
      </tbody>
    </.table>\
    """
  end
end
