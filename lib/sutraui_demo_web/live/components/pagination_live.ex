defmodule SutrauiDemoWeb.Components.PaginationLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Pagination", current_page: 5, total_pages: 20)}
  end

  def handle_event("page_changed", %{"page" => page}, socket) do
    {:noreply, assign(socket, current_page: String.to_integer(page))}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/pagination">
      <.docs_header
        title="Pagination"
        description="Pagination with page navigation, next and previous links."
      />

      <.component_demo title="Default" code={default_code()}>
        <.pagination
          page={@current_page}
          total_pages={@total_pages}
          on_page_change="page_changed"
        />
        <p class="mt-4 text-sm" style="color: var(--fg-muted);">
          Current page: {@current_page}
        </p>
      </.component_demo>

      <.section_heading id="few-pages">Few Pages</.section_heading>
      <.prose>
        When there are 7 or fewer pages, all page numbers are shown without ellipsis.
      </.prose>

      <.component_demo title="Few Pages" code={few_pages_code()}>
        <.pagination page={3} total_pages={5} on_page_change="page_changed" />
      </.component_demo>

      <.section_heading id="sibling-count">Sibling Count</.section_heading>
      <.prose>
        Use the
        <.inline_code>sibling_count</.inline_code>
        prop to control how many pages are shown on each side of the current page.
      </.prose>

      <.component_demo title="Sibling Count 2" code={sibling_code()}>
        <.pagination page={10} total_pages={20} sibling_count={2} on_page_change="page_changed" />
      </.component_demo>

      <.section_heading id="custom-content">Custom Previous/Next</.section_heading>
      <.prose>
        Use the
        <.inline_code>previous</.inline_code>
        and
        <.inline_code>next</.inline_code>
        slots for custom button content.
      </.prose>

      <.component_demo title="Custom Buttons" code={custom_code()}>
        <.pagination page={5} total_pages={10} on_page_change="page_changed">
          <:previous>Previous</:previous>
          <:next>Next</:next>
        </.pagination>
      </.component_demo>

      <.section_heading id="edge-cases">Edge Cases</.section_heading>
      <.prose>
        The pagination component handles edge cases gracefully.
      </.prose>

      <.component_demo title="First Page" code={first_page_code()}>
        <.pagination page={1} total_pages={20} on_page_change="page_changed" />
      </.component_demo>

      <.component_demo title="Last Page" code={last_page_code()}>
        <.pagination page={20} total_pages={20} on_page_change="page_changed" />
      </.component_demo>

      <.section_heading id="props">Props</.section_heading>
      <.props_table>
        <.prop name="page" type="integer" required>
          Current page number (1-indexed)
        </.prop>
        <.prop name="total_pages" type="integer" required>
          Total number of pages
        </.prop>
        <.prop name="sibling_count" type="integer" default="1">
          Number of sibling pages to show on each side of current page
        </.prop>
        <.prop name="on_page_change" type="string">
          Event name to send when page changes (sends page number)
        </.prop>
        <.prop name="class" type="string">
          Additional CSS classes
        </.prop>
      </.props_table>

      <.section_heading id="accessibility">Accessibility</.section_heading>
      <.prose>
        The pagination component includes proper ARIA attributes:
      </.prose>
      <ul class="list-disc list-inside space-y-1 text-sm" style="color: var(--fg-secondary);">
        <li>
          Uses
          <.inline_code>&lt;nav&gt;</.inline_code>
          element with
          <.inline_code>aria-label="Pagination"</.inline_code>
        </li>
        <li>
          Current page marked with
          <.inline_code>aria-current="page"</.inline_code>
        </li>
        <li>Previous/next buttons have descriptive aria-labels</li>
        <li>Disabled buttons properly marked</li>
      </ul>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.pagination
      page={@page}
      total_pages={@total_pages}
      on_page_change="page_changed"
    />\
    """
  end

  defp few_pages_code do
    """
    <.pagination page={3} total_pages={5} on_page_change="page_changed" />\
    """
  end

  defp sibling_code do
    """
    <.pagination
      page={10}
      total_pages={20}
      sibling_count={2}
      on_page_change="page_changed"
    />\
    """
  end

  defp custom_code do
    """
    <.pagination page={5} total_pages={10} on_page_change="page_changed">
      <:previous>Previous</:previous>
      <:next>Next</:next>
    </.pagination>\
    """
  end

  defp first_page_code do
    """
    <.pagination page={1} total_pages={20} on_page_change="page_changed" />\
    """
  end

  defp last_page_code do
    """
    <.pagination page={20} total_pages={20} on_page_change="page_changed" />\
    """
  end
end
