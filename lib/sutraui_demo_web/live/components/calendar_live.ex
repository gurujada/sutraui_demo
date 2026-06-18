defmodule SutrauiDemoWeb.Components.CalendarLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    today = Date.utc_today()

    socket =
      socket
      |> assign(page_title: "Calendar")
      |> assign(:selected, nil)
      |> assign(:year, today.year)
      |> assign(:month, today.month)
      |> assign(:picker_selected, nil)
      |> assign(:picker_year, today.year)
      |> assign(:picker_month, today.month)
      |> assign(:range_start, nil)
      |> assign(:range_end, nil)
      |> assign(:range_year, 2026)
      |> assign(:range_month, 6)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/calendar">
      <.docs_header
        title="Calendar"
        description="A monthly calendar grid for date selection, range selection, and LiveView-owned month navigation."
      />

      <.component_demo title="Static" code={static_code()}>
        <.calendar year={2026} month={6} />
      </.component_demo>

      <.section_heading id="date-picker-composition">Date Picker Composition</.section_heading>
      <.prose>
        Calendar is the grid primitive. Pair it with
        <.inline_code>popover</.inline_code>
        and a hidden form input when you need a date-picker field.
      </.prose>

      <.component_demo
        title="Popover Date Picker"
        code={picker_code()}
        class="[&_.demo-preview]:min-h-[420px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-8"
      >
        <.form
          for={%{}}
          as={:booking}
          phx-change="jump_picker_month"
          class="w-full max-w-sm space-y-2"
        >
          <.label for="booking-date">Date</.label>
          <.popover id="booking-date-popover" class="p-0">
            <:trigger>
              <span class="inline-flex h-9 w-64 items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm text-foreground shadow-xs">
                <span>{date_label(@picker_selected)}</span>
                <.icon name="lucide-calendar-days" class="size-4 text-muted-foreground" />
              </span>
            </:trigger>
            <div class="grid grid-cols-[1fr_6rem] gap-2 border-b p-3">
              <label class="grid gap-1">
                <span class="text-xs text-muted-foreground">Month</span>
                <select
                  id="booking-display-month"
                  name="booking[display_month]"
                  class="select h-8 w-full"
                >
                  <option
                    :for={{label, month} <- month_options()}
                    value={month}
                    selected={month == @picker_month}
                  >
                    {label}
                  </option>
                </select>
              </label>
              <label class="grid gap-1">
                <span class="text-xs text-muted-foreground">Year</span>
                <input
                  id="booking-display-year"
                  type="number"
                  name="booking[display_year]"
                  value={@picker_year}
                  class="input h-8 w-full"
                />
              </label>
            </div>
            <.calendar
              id="booking-date-calendar"
              class="rounded-t-none border-0 shadow-none"
              year={@picker_year}
              month={@picker_month}
              selected={@picker_selected}
              select_event="select_picker_date"
              nav_event="nav_picker_month"
            />
          </.popover>
          <input
            id="booking-date"
            type="hidden"
            name="booking[date]"
            value={date_value(@picker_selected)}
          />
        </.form>
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
        <div class="grid justify-items-center gap-4">
          <.calendar
            id="single-selection-calendar"
            year={@year}
            month={@month}
            selected={@selected}
            select_event="select_date"
            nav_event="nav_month"
          />
          <p class="text-sm text-muted-foreground">
            Selected: <strong class="text-foreground">{@selected || "No date selected"}</strong>
          </p>
        </div>
      </.component_demo>

      <.section_heading id="monday-start">Monday Start</.section_heading>
      <.prose>
        Set
        <.inline_code>week_start</.inline_code>
        to choose the first weekday. Use
        <.inline_code>0</.inline_code>
        for Sunday,
        <.inline_code>1</.inline_code>
        for Monday, up to
        <.inline_code>6</.inline_code>
        for Saturday.
      </.prose>

      <.component_demo title="Monday Start" code={monday_code()}>
        <.calendar year={2026} month={6} week_start={1} />
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
        <div class="grid justify-items-center gap-4">
          <.calendar
            id="date-range-calendar"
            year={@range_year}
            month={@range_month}
            mode="range"
            selected={@range_start}
            range_end={@range_end}
            select_event="select_range_date"
            nav_event="nav_range_month"
          />
          <div class="grid w-full max-w-xs grid-cols-2 gap-3 text-sm">
            <div>
              <p class="text-xs text-muted-foreground">Start</p>
              <p class="font-medium text-foreground">{date_label(@range_start)}</p>
            </div>
            <div>
              <p class="text-xs text-muted-foreground">End</p>
              <p class="font-medium text-foreground">{date_label(@range_end)}</p>
            </div>
          </div>
        </div>
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
          disabled_dates={[~D[2026-06-08], ~D[2026-06-09], ~D[2026-06-18], ~D[2026-06-25]]}
        />
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          The parent LiveView owns date state. Click a selected date again to
          clear it, or keep the date selected in your event handler.
        </.list_item>
        <.list_item>
          Use
          <.inline_code>select_event</.inline_code>
          for date clicks and
          <.inline_code>nav_event</.inline_code>
          for month navigation. For year jumps, render your own controls
          around the calendar and assign
          <.inline_code>year</.inline_code>
          /
          <.inline_code>month</.inline_code>
          from the parent LiveView.
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

    selected =
      if socket.assigns.selected && Date.compare(socket.assigns.selected, d) == :eq do
        nil
      else
        d
      end

    {:noreply, assign(socket, selected: selected, year: d.year, month: d.month)}
  end

  def handle_event("select_picker_date", %{"date" => date}, socket) do
    d = Date.from_iso8601!(date)
    {:noreply, assign(socket, picker_selected: d, picker_year: d.year, picker_month: d.month)}
  end

  def handle_event("jump_picker_month", %{"booking" => params}, socket) do
    case parse_picker_month(params) do
      {:ok, {year, month}} ->
        {:noreply, assign(socket, picker_year: year, picker_month: month)}

      :error ->
        {:noreply, socket}
    end
  end

  def handle_event("select_range_date", %{"date" => date}, socket) do
    d = Date.from_iso8601!(date)

    {range_start, range_end} =
      cond do
        is_nil(socket.assigns.range_start) or not is_nil(socket.assigns.range_end) ->
          {d, nil}

        Date.compare(socket.assigns.range_start, d) == :eq ->
          {nil, nil}

        true ->
          ordered_range(socket.assigns.range_start, d)
      end

    {:noreply, assign(socket, range_start: range_start, range_end: range_end)}
  end

  def handle_event("nav_month", params, socket) do
    {year, month} = nav_params(params)
    {:noreply, assign(socket, year: year, month: month)}
  end

  def handle_event("nav_picker_month", params, socket) do
    {year, month} = nav_params(params)
    {:noreply, assign(socket, picker_year: year, picker_month: month)}
  end

  def handle_event("nav_range_month", params, socket) do
    {year, month} = nav_params(params)
    {:noreply, assign(socket, range_year: year, range_month: month)}
  end

  defp static_code do
    """
    <.calendar year={2026} month={6} />\
    """
  end

  defp picker_code do
    """
    <.form for={%{}} as={:booking} phx-change="jump_picker_month">
      <.label for="booking-date">Date</.label>
      <.popover id="booking-date-popover" class="p-0">
        <:trigger>
          <span class="inline-flex h-9 w-64 items-center justify-between rounded-md border px-3 text-sm">
            <span>{date_label(@picker_selected)}</span>
            <.icon name="lucide-calendar-days" class="size-4" />
          </span>
        </:trigger>
        <div class="grid grid-cols-[1fr_6rem] gap-2 border-b p-3">
          <label class="grid gap-1">
            <span class="text-xs text-muted-foreground">Month</span>
            <select id="booking-display-month" name="booking[display_month]" class="select h-8 w-full">
              <option :for={{label, month} <- month_options()} value={month} selected={month == @picker_month}>
                {label}
              </option>
            </select>
          </label>
          <label class="grid gap-1">
            <span class="text-xs text-muted-foreground">Year</span>
            <input
              id="booking-display-year"
              type="number"
              name="booking[display_year]"
              value={@picker_year}
              class="input h-8 w-full"
            />
          </label>
        </div>
        <.calendar
          id="booking-date-calendar"
          class="rounded-t-none border-0 shadow-none"
          year={@picker_year}
          month={@picker_month}
          selected={@picker_selected}
          select_event="select_picker_date"
          nav_event="nav_picker_month"
        />
      </.popover>
      <input type="hidden" name="booking[date]" value={date_value(@picker_selected)} />
    </.form>\
    """
  end

  defp interactive_code do
    """
    <.calendar
      id="single-selection-calendar"
      year={@year}
      month={@month}
      selected={@selected}
      select_event="select_date"
      nav_event="nav_month"
    />
    <p class="text-sm text-muted-foreground">
      Selected: <strong class="text-foreground">{@selected || "No date selected"}</strong>
    </p>\
    """
  end

  defp monday_code do
    """
    <.calendar year={2026} month={6} week_start={1} />\
    """
  end

  defp range_code do
    """
    <.calendar
      id="date-range-calendar"
      year={@range_year}
      month={@range_month}
      mode="range"
      selected={@range_start}
      range_end={@range_end}
      select_event="select_range_date"
      nav_event="nav_range_month"
    />
    <div class="grid w-full max-w-xs grid-cols-2 gap-3 text-sm">
      <div>
        <p class="text-xs text-muted-foreground">Start</p>
        <p class="font-medium text-foreground">{date_label(@range_start)}</p>
      </div>
      <div>
        <p class="text-xs text-muted-foreground">End</p>
        <p class="font-medium text-foreground">{date_label(@range_end)}</p>
      </div>
    </div>\
    """
  end

  defp disabled_code do
    """
    <.calendar
      year={2026}
      month={6}
      disabled_dates={[~D[2026-06-08], ~D[2026-06-09], ~D[2026-06-18], ~D[2026-06-25]]}
    />\
    """
  end

  defp nav_params(%{"year" => year, "month" => month}) do
    {String.to_integer(year), String.to_integer(month)}
  end

  defp parse_picker_month(params) do
    with {year, ""} <- Integer.parse(to_string(params["display_year"])),
         {month, ""} <- Integer.parse(to_string(params["display_month"])),
         true <- month in 1..12 do
      {:ok, {year, month}}
    else
      _ -> :error
    end
  end

  defp ordered_range(start_date, end_date) do
    case Date.compare(start_date, end_date) do
      :gt -> {end_date, start_date}
      _ -> {start_date, end_date}
    end
  end

  defp date_label(nil), do: "No date selected"
  defp date_label(%Date{} = date), do: Calendar.strftime(date, "%b %-d, %Y")
  defp date_value(nil), do: ""
  defp date_value(%Date{} = date), do: Date.to_iso8601(date)

  defp month_options do
    [
      {"January", 1},
      {"February", 2},
      {"March", 3},
      {"April", 4},
      {"May", 5},
      {"June", 6},
      {"July", 7},
      {"August", 8},
      {"September", 9},
      {"October", 10},
      {"November", 11},
      {"December", 12}
    ]
  end
end
