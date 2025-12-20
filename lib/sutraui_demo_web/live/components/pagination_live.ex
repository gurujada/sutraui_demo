defmodule SutrauiDemoWeb.Components.PaginationLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Pagination",
       # Each demo has its own page state
       demo1_page: 5,
       demo2_page: 3,
       demo3_page: 10,
       demo4_page: 5,
       demo5_page: 1,
       demo6_page: 20
     )}
  end

  def handle_event("demo1_page", %{"page" => page}, socket) do
    {:noreply, assign(socket, demo1_page: String.to_integer(page))}
  end

  def handle_event("demo2_page", %{"page" => page}, socket) do
    {:noreply, assign(socket, demo2_page: String.to_integer(page))}
  end

  def handle_event("demo3_page", %{"page" => page}, socket) do
    {:noreply, assign(socket, demo3_page: String.to_integer(page))}
  end

  def handle_event("demo4_page", %{"page" => page}, socket) do
    {:noreply, assign(socket, demo4_page: String.to_integer(page))}
  end

  def handle_event("demo5_page", %{"page" => page}, socket) do
    {:noreply, assign(socket, demo5_page: String.to_integer(page))}
  end

  def handle_event("demo6_page", %{"page" => page}, socket) do
    {:noreply, assign(socket, demo6_page: String.to_integer(page))}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/pagination">
      <.docs_header
        title="Pagination"
        description="Pagination with page navigation, next and previous links."
      />

      <.component_demo title="Default" code={default_code()}>
        <.pagination page={@demo1_page} total_pages={20} on_page_change="demo1_page" />
      </.component_demo>

      <.section_heading id="few-pages">Few Pages</.section_heading>
      <.prose>
        When there are 7 or fewer pages, all page numbers are shown without ellipsis.
      </.prose>

      <.component_demo title="Few Pages" code={few_pages_code()}>
        <.pagination page={@demo2_page} total_pages={5} on_page_change="demo2_page" />
      </.component_demo>

      <.section_heading id="sibling-count">Sibling Count</.section_heading>
      <.prose>
        Use the
        <.inline_code>sibling_count</.inline_code>
        prop to control how many pages are shown on each side of the current page.
      </.prose>

      <.component_demo title="Sibling Count 2" code={sibling_code()}>
        <.pagination
          page={@demo3_page}
          total_pages={20}
          sibling_count={2}
          on_page_change="demo3_page"
        />
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
        <.pagination page={@demo4_page} total_pages={10} on_page_change="demo4_page">
          <:previous>Previous</:previous>
          <:next>Next</:next>
        </.pagination>
      </.component_demo>

      <.section_heading id="edge-cases">Edge Cases</.section_heading>
      <.prose>
        The pagination component handles edge cases gracefully.
      </.prose>

      <.component_demo title="First Page" code={first_page_code()}>
        <.pagination page={@demo5_page} total_pages={20} on_page_change="demo5_page" />
      </.component_demo>

      <.component_demo title="Last Page" code={last_page_code()}>
        <.pagination page={@demo6_page} total_pages={20} on_page_change="demo6_page" />
      </.component_demo>

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
