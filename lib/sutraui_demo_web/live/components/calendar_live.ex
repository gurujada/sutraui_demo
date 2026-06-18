defmodule SutrauiDemoWeb.Components.CalendarLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    today = Date.utc_today()

    socket =
      socket
      |> assign(page_title: "Calendar")
      |> assign(:selected, today)
      |> assign(:year, today.year)
      |> assign(:month, today.month)
      |> assign(:range_start, ~D[2026-06-10])
      |> assign(:range_end, ~D[2026-06-20])
      |> assign(:range_year, 2026)
      |> assign(:range_month, 6)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/calendar">
      <.docs_header
        title="Calendar"
        description="A monthly calendar grid with prev/next navigation and date selection. Pure server-rendered — no JavaScript."
      />

      <.component_demo title="Static" code={static_code()}>
        <.calendar year={2026} month={6} selected={~D[2026-06-15]} />
      </.component_demo>

      <.section_heading id="interactive">Interactive</.section_heading>
      <.prose>
        Pass a
        <.inline_code>select_event</.inline_code>
        for date clicks and a
        <.inline_code>nav_event</.inline_code>
        for month navigation. The events carry different payloads —
        <.inline_code>phx-value-date</.inline_code>
        for selection,
        <.inline_code>phx-value-year</.inline_code>
        and
        <.inline_code>phx-value-month</.inline_code>
        for navigation.
      </.prose>

      <.component_demo title="Single Selection" code={interactive_code()}>
        <.calendar
          year={@year}
          month={@month}
          selected={@selected}
          select_event="select_date"
          nav_event="nav_month"
        />
        <p class="mt-4 text-sm text-muted-foreground">
          Selected: <strong class="text-foreground">{@selected}</strong>
        </p>
      </.component_demo>

      <.section_heading id="monday-start">Monday Start</.section_heading>
      <.prose>
        Set
        <.inline_code>week_start={1}</.inline_code>
        to start the week on Monday instead of Sunday.
      </.prose>

      <.component_demo title="Monday Start" code={monday_code()}>
        <.calendar year={2026} month={6} selected={~D[2026-06-15]} week_start={1} />
      </.component_demo>

      <.section_heading id="range">Range Selection</.section_heading>
      <.prose>
        Use
        <.inline_code>mode="range"</.inline_code>
        with
        <.inline_code>selected</.inline_code>
        (range start) and
        <.inline_code>range_end</.inline_code>
        to highlight a span of dates. Dates between the endpoints get the
        <.inline_code>calendar-day-in-range</.inline_code>
        style.
      </.prose>

      <.component_demo title="Date Range" code={range_code()}>
        <.calendar
          year={@range_year}
          month={@range_month}
          mode="range"
          selected={@range_start}
          range_end={@range_end}
          nav_event="nav_range_month"
        />
        <p class="mt-4 text-sm text-muted-foreground">
          Range: <strong class="text-foreground">{@range_start}</strong>
          to <strong class="text-foreground">{@range_end}</strong>
        </p>
      </.component_demo>

      <.section_heading id="disabled-dates">Disabled Dates</.section_heading>
      <.prose>
        Pass a list of
        <.inline_code>Date</.inline_code>
        structs or ISO strings to
        <.inline_code>disabled_dates</.inline_code>
        . Disabled dates can't be clicked and render with reduced opacity.
      </.prose>

      <.component_demo title="Disabled Dates" code={disabled_code()}>
        <.calendar
          year={2026}
          month={6}
          selected={~D[2026-06-15]}
          disabled_dates={[~D[2026-06-08], ~D[2026-06-09], ~D[2026-06-18], ~D[2026-06-25]]}
        />
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          The calendar is pure server-rendered — all date logic runs in Elixir.
          No JavaScript hook required.
        </.list_item>
        <.list_item>
          Use
          <.inline_code>select_event</.inline_code>
          for date clicks and
          <.inline_code>nav_event</.inline_code>
          for month navigation. If
          <.inline_code>nav_event</.inline_code>
          is omitted, navigation falls back to <.inline_code>select_event</.inline_code>.
        </.list_item>
        <.list_item>
          Each day is a native
          <.inline_code>&lt;button&gt;</.inline_code>
          — keyboard-focusable and operable. The grid uses
          <.inline_code>role="grid"</.inline_code>
          with <.inline_code>role="gridcell"</.inline_code>.
        </.list_item>
        <.list_item>
          Days outside the displayed month are visually muted and marked with
          <.inline_code>data-outside</.inline_code>
          — they still render so the grid stays rectangular.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  def handle_event("select_date", %{"date" => date}, socket) do
    d = Date.from_iso8601!(date)
    {:noreply, assign(socket, selected: d, year: d.year, month: d.month)}
  end

  def handle_event("nav_month", %{"year" => year, "month" => month}, socket) do
    {:noreply, assign(socket, year: String.to_integer(year), month: String.to_integer(month))}
  end

  def handle_event("nav_range_month", %{"year" => year, "month" => month}, socket) do
    {:noreply,
     assign(socket, range_year: String.to_integer(year), range_month: String.to_integer(month))}
  end

  defp static_code do
    """
    <.calendar year={2026} month={6} selected={~D[2026-06-15]} />\
    """
  end

  defp interactive_code do
    """
    <.calendar
      year={@year}
      month={@month}
      selected={@selected}
      select_event="select_date"
      nav_event="nav_month"
    />\
    """
  end

  defp monday_code do
    """
    <.calendar year={2026} month={6} selected={~D[2026-06-15]} week_start={1} />\
    """
  end

  defp range_code do
    """
    <.calendar
      mode="range"
      selected={@range_start}
      range_end={@range_end}
      nav_event="nav_range_month"
    />\
    """
  end

  defp disabled_code do
    """
    <.calendar
      year={2026}
      month={6}
      selected={~D[2026-06-15]}
      disabled_dates={[~D[2026-06-08], ~D[2026-06-09], ~D[2026-06-18], ~D[2026-06-25]]}
    />\
    """
  end
end
