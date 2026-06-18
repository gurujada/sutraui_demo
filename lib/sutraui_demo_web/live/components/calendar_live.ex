defmodule SutrauiDemoWeb.Components.CalendarLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    today = Date.utc_today()

    socket =
      socket
      |> assign(page_title: "Calendar")
      |> assign(selected: today, year: today.year, month: today.month)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/calendar">
      <.docs_header
        title="Calendar"
        description="A monthly calendar grid with prev/next navigation and date selection."
      />

      <.component_demo title="Basic" code={basic_code()}>
        <.calendar />
      </.component_demo>

      <.section_heading id="with-selected-date">With Selected Date</.section_heading>
      <.prose>
        Pass a
        <.inline_code>selected</.inline_code>
        date and a
        <.inline_code>select_event</.inline_code>
        to make the calendar interactive. Prev/next navigation emits the same event.
      </.prose>

      <.component_demo title="With Selected Date" code={selected_code()}>
        <.calendar
          year={@year}
          month={@month}
          selected={@selected}
          select_event="select_date"
        />
      </.component_demo>

      <.section_heading id="monday-start">Monday Start</.section_heading>
      <.prose>
        Set
        <.inline_code>week_start={1}</.inline_code>
        to start the week on Monday instead of Sunday.
      </.prose>

      <.component_demo title="Monday Start" code={monday_code()}>
        <.calendar year={2026} month={6} selected="2026-06-15" week_start={1} />
      </.component_demo>
    </Layouts.docs>
    """
  end

  def handle_event("select_date", %{"date" => date}, socket) do
    d = Date.from_iso8601!(date)
    {:noreply, assign(socket, selected: d, year: d.year, month: d.month)}
  end

  def handle_event("select_date", %{"year" => year, "month" => month}, socket) do
    {:noreply, assign(socket, year: String.to_integer(year), month: String.to_integer(month))}
  end

  defp basic_code do
    """
    <.calendar />\
    """
  end

  defp selected_code do
    """
    <.calendar
      year={@year}
      month={@month}
      selected={@selected}
      select_event="select_date"
    />\
    """
  end

  defp monday_code do
    """
    <.calendar year={2026} month={6} selected="2026-06-15" week_start={1} />\
    """
  end
end
