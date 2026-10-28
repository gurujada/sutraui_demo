defmodule SutrauiDemoWeb.Components.DatePickerLive do
  use SutrauiDemoWeb, :live_view

  alias SutraUI.DateRules

  @zone "Asia/Kolkata"
  @types %{day: :date, time: :time, starts: :string}

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page_title: "Date & time pickers", zone: @zone)
     |> assign(booking_form(%{}, :init))
     |> assign(period: %{}, period_error: nil, ny: "2026-11-01T01:30", ny_result: nil)
     |> assign(dialog_open: false, dialog_form: to_form(%{}, as: :visit), dialog_saved: nil)
     |> assign(ny_result: ny_result("2026-11-01T01:30"))}
  end

  # ---- booking form ---------------------------------------------------------

  def rules do
    %DateRules{
      min: :today,
      max: {:today, 90},
      disabled_weekdays: [6, 7],
      disabled_dates: [~D[2026-12-25]],
      step: 15
    }
  end

  defp booking_form(params, mode) do
    changeset =
      {%{}, @types}
      |> Ecto.Changeset.cast(params, Map.keys(@types))
      |> DateRules.validate(:day, rules(), zone: @zone)
      |> DateRules.validate(:time, rules(), zone: @zone)

    changeset = if mode == :init, do: changeset, else: Map.put(changeset, :action, :validate)
    [booking: to_form(changeset, as: :booking), booking_params: params]
  end

  def handle_event("validate", %{"booking" => params}, socket) do
    {:noreply, assign(socket, booking_form(params, :validate))}
  end

  def handle_event("book", %{"booking" => params}, socket) do
    socket = assign(socket, booking_form(params, :validate))

    if socket.assigns.booking.source.valid? do
      SutraUI.Toast.send(:success, "Booked #{params["day"]} at #{params["time"]}")
    else
      SutraUI.Toast.send(:error, "Fix the highlighted fields")
    end

    {:noreply, socket}
  end

  def handle_event("period", %{"period" => params}, socket) do
    error =
      with {:ok, from} <- Date.from_iso8601(params["start"] || ""),
           {:ok, to} <- Date.from_iso8601(params["end"] || ""),
           :ok <- DateRules.check_range(%DateRules{max_length: 14}, from, to, Date.utc_today()) do
        nil
      else
        {:error, :too_long} -> "Pick at most 14 days."
        {:error, :reversed} -> "The end is before the start."
        _ -> nil
      end

    {:noreply, assign(socket, period: params, period_error: error)}
  end

  def handle_event("ny", %{"ny" => %{"starts" => starts}}, socket) do
    {:noreply, assign(socket, ny: starts, ny_result: ny_result(starts))}
  end

  def handle_event("open_dialog", _params, socket) do
    {:noreply, assign(socket, :dialog_open, true)}
  end

  def handle_event("close_dialog", _params, socket) do
    {:noreply, assign(socket, :dialog_open, false)}
  end

  def handle_event("dialog_change", %{"visit" => params}, socket) do
    {:noreply, assign(socket, :dialog_form, to_form(params, as: :visit))}
  end

  def handle_event("dialog_save", %{"visit" => params}, socket) do
    {:noreply,
     assign(socket,
       dialog_open: false,
       dialog_saved: "#{params["campus"]}, #{params["day"]}",
       dialog_form: to_form(params, as: :visit)
     )}
  end

  defp ny_result(starts) do
    case SutraUI.Time.parse_datetime(starts, "America/New_York") do
      {:ok, dt} ->
        "Exact: " <> DateTime.to_iso8601(dt)

      {:ambiguous, first, second} ->
        "Ambiguous: #{DateTime.to_iso8601(first)} or #{DateTime.to_iso8601(second)}"

      {:gap, _before, _after} ->
        "That time does not exist on this day (clocks jump forward)."

      {:error, :invalid} ->
        "Nothing chosen."
    end
  end

  defp errors(form, field) do
    if Phoenix.Component.used_input?(form[field]) do
      for {message, _} <- form[field].errors, do: message
    else
      []
    end
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/date-picker"
    >
      <.docs_header
        title="Date & time pickers"
        description="A segmented field you type into, and a calendar. Day-first for en-IN, read in the place's zone."
      />

      <.callout>
        Type digits and the field moves on; arrow keys step a segment; paste reads a whole value. On phones the field opens the number keyboard and
        the calendar becomes a bottom sheet. The browser's own
        <.inline_code>&lt;input type="date"&gt;</.inline_code>
        is the posted field underneath, so forms also work without JavaScript.
      </.callout>

      <.section_heading id="date">Date, with rules</.section_heading>
      <.prose>
        A
        <.inline_code>SutraUI.DateRules</.inline_code>
        struct disables days in the calendar, marks a typed value it refuses, and checks the same on the server with <.inline_code>DateRules.validate/4</.inline_code>.
        Here: from today to 90 days ahead, no weekends, no 25 Dec, times on the quarter hour. Presets today, tomorrow, next Monday and end of week come with the picker.
      </.prose>

      <.component_demo
        title="Booking form"
        code={booking_code()}
        class="[&_.demo-preview]:items-start"
      >
        <div class="w-full">
          <.form
            for={@booking}
            id="booking-form"
            phx-change="validate"
            phx-submit="book"
            class="w-full max-w-lg"
          >
            <div class="mb-5 space-y-1.5">
              <.label for="booking_day">Day</.label>
              <.date_picker
                field={@booking[:day]}
                label="Day"
                rules={rules()}
                zone={@zone}
                aria-describedby="booking-day-errors"
              />
              <p
                :for={message <- errors(@booking, :day)}
                id="booking-day-errors"
                class="text-sm text-destructive"
              >
                {message}
              </p>
            </div>

            <div class="mb-5 space-y-1.5">
              <.label for="booking_time">Time</.label>
              <.time_picker field={@booking[:time]} label="Time" rules={rules()} step={15} />
              <p :for={message <- errors(@booking, :time)} class="text-sm text-destructive">
                {message}
              </p>
            </div>

            <div class="mb-5 space-y-1.5">
              <.label for="booking_starts">Class starts (Asia/Kolkata)</.label>
              <.datetime_picker field={@booking[:starts]} label="Class starts" zone={@zone} />
            </div>

            <.button type="submit">Book</.button>
          </.form>
          <pre id="booking-posted" class="mt-4 w-full overflow-x-auto rounded-md bg-muted p-3 text-xs">{inspect(@booking_params, pretty: true)}</pre>
        </div>
      </.component_demo>

      <.section_heading id="range">Date range</.section_heading>
      <.prose>
        A range posts
        <.inline_code>name[start]</.inline_code>
        and
        <.inline_code>name[end]</.inline_code>
        and shows its length as you draw it. In a filter,
        <.inline_code>preset_key</.inline_code>
        also posts
        <.inline_code>name[preset]</.inline_code>
        so a shared link stays relative ("last 7 days").
      </.prose>

      <.component_demo title="Date range" code={range_code()} class="[&_.demo-preview]:items-start">
        <div class="w-full">
          <.form for={%{}} as={:period} id="period-form" phx-change="period" class="w-full max-w-lg">
            <div class="mb-5 space-y-1.5">
              <.label for="period_start">Period (at most 14 days)</.label>
              <.date_range_picker
                id="period"
                name="period"
                label="Period"
                rules={%DateRules{max_length: 14}}
                preset_key
                zone={@zone}
                value={@period}
              />
              <p :if={@period_error} id="period-error" class="text-sm text-destructive">
                {@period_error}
              </p>
            </div>
          </.form>
          <pre id="period-posted" class="mt-4 w-full overflow-x-auto rounded-md bg-muted p-3 text-xs">{inspect(@period, pretty: true)}</pre>
        </div>
      </.component_demo>

      <.section_heading id="presets">Presets</.section_heading>
      <.prose>
        <.inline_code>presets</.inline_code>
        takes keys,
        <.inline_code>{"{key, label}"}</.inline_code>
        pairs, or maps with a value of your own.
        <.inline_code>presets=&lbrace;[]&rbrace;</.inline_code>
        turns them off.
      </.prose>

      <.component_demo title="Presets" code={presets_code()} class="[&_.demo-preview]:items-start">
        <div class="grid w-full max-w-sm gap-5">
          <div class="space-y-1.5">
            <.label for="preset_none">No presets</.label>
            <.date_picker
              id="preset_none"
              name="preset_none"
              label="No presets"
              presets={[]}
              zone={@zone}
            />
          </div>
          <div class="space-y-1.5">
            <.label for="preset_custom">Custom presets</.label>
            <.date_picker
              id="preset_custom"
              name="preset_custom"
              label="Custom presets"
              zone={@zone}
              presets={[
                :today,
                :end_of_month,
                %{key: "term_start", label: "Start of term", value: ~D[2026-11-02]}
              ]}
            />
          </div>
          <div class="space-y-1.5">
            <.label for="preset_range">Range presets</.label>
            <.date_range_picker
              id="preset_range"
              name="preset_range"
              label="Range presets"
              zone={@zone}
              presets={[:last_7_days, :this_week, :last_month]}
            />
          </div>
        </div>
      </.component_demo>

      <.section_heading id="zones">A zoned datetime and a clock change</.section_heading>
      <.prose>
        <.inline_code>datetime_picker</.inline_code>
        shows and posts the wall time in its required
        <.inline_code>zone</.inline_code>
        with that moment's offset. A clock change is <em>shown, never guessed</em>:
        on 1 Nov 2026 New York repeats the hour 01:00 to 02:00, so 01:30 happens twice and the picker offers "01:30 EDT" and "01:30 EST".
        On 14 Mar 2027 the hour 02:00 to 03:00 does not exist, so 02:30 posts nothing and says so.
        When your browser's zone differs, your own time is added as a hint.
      </.prose>

      <.component_demo
        title="America/New_York"
        code={zone_code()}
        class="[&_.demo-preview]:items-start"
      >
        <div class="w-full">
          <.form for={%{}} as={:ny} id="ny-form" phx-change="ny" class="w-full max-w-lg">
            <div class="mb-5 space-y-1.5">
              <.label for="ny_starts">Starts (New York time)</.label>
              <.datetime_picker
                id="ny_starts"
                name="ny[starts]"
                label="Starts"
                zone="America/New_York"
                value={@ny}
              />
            </div>
          </.form>
          <p id="ny-result" class="mt-2 text-sm text-muted-foreground">{@ny_result}</p>
        </div>
      </.component_demo>

      <.section_heading id="dialog">Inside a dialog</.section_heading>
      <.prose>
        The calendar is a fixed card placed from the field, so a dialog body does not clip it. Below 640 px it is a bottom sheet.
      </.prose>

      <.component_demo title="In a dialog" code={dialog_code()}>
        <.button id="open-visit-dialog" variant="outline" phx-click="open_dialog">Plan a visit</.button>
        <p :if={@dialog_saved} id="visit-saved" class="mt-3 text-sm text-muted-foreground">
          Saved: {@dialog_saved}
        </p>

        <.dialog id="visit-dialog" show={@dialog_open} on_cancel="close_dialog">
          <:title>Plan a visit</:title>
          <:description>Choose a campus and a day.</:description>
          <.form
            for={@dialog_form}
            id="visit-form"
            phx-change="dialog_change"
            phx-submit="dialog_save"
          >
            <.input
              field={@dialog_form[:campus]}
              type="select"
              label="Campus"
              prompt="Choose a campus"
              options={["Hyderabad", "Bengaluru", "Chennai"]}
            />
            <div class="mb-5 space-y-1.5">
              <.label for="visit_day">Day</.label>
              <.date_picker field={@dialog_form[:day]} label="Day" rules={rules()} zone={@zone} />
            </div>
            <div class="flex justify-end gap-2">
              <.button type="button" variant="outline" phx-click="close_dialog">Cancel</.button>
              <.button type="submit">Save</.button>
            </div>
          </.form>
        </.dialog>
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          The segment order comes from
          <.inline_code>config :sutra_ui, locale: "en-IN"</.inline_code>
          (or the
          <.inline_code>locale</.inline_code>
          attribute), never from the viewer's browser.
        </.list_item>
        <.list_item>
          The picker fires the input's own
          <.inline_code>input</.inline_code>
          and
          <.inline_code>change</.inline_code>
          events, so
          <.inline_code>phx-change</.inline_code>
          and
          <.inline_code>used_input?</.inline_code>
          work as with any input.
        </.list_item>
        <.list_item>
          Read a datetime with <.inline_code>SutraUI.Time.parse_datetime/3</.inline_code>.
        </.list_item>
        <.list_item>
          The pickers draw no label or error text of their own; put them beside a
          <.inline_code>label</.inline_code>
          and your own errors, as above.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp booking_code do
    """
    rules = %SutraUI.DateRules{
      min: :today,
      max: {:today, 90},
      disabled_weekdays: [6, 7],
      disabled_dates: [~D[2026-12-25]],
      step: 15
    }

    <.date_picker field={@form[:day]} label="Day" rules={rules} zone="Asia/Kolkata" />
    <.time_picker field={@form[:time]} label="Time" rules={rules} step={15} />
    <.datetime_picker field={@form[:starts]} label="Class starts" zone="Asia/Kolkata" />

    # server: the same rules the calendar shows
    changeset |> SutraUI.DateRules.validate(:day, rules, zone: "Asia/Kolkata")\
    """
  end

  defp range_code do
    """
    <.date_range_picker
      id="period"
      name="period"
      label="Period"
      rules={%SutraUI.DateRules{max_length: 14}}
      preset_key
      zone="Asia/Kolkata"
    />

    # posts %{"period" => %{"start" => "2026-11-02", "end" => "2026-11-08", "preset" => ""}}\
    """
  end

  defp presets_code do
    """
    <.date_picker name="due" presets={[]} />

    <.date_picker name="start" presets={[
      :today,
      :end_of_month,
      %{key: "term_start", label: "Start of term", value: ~D[2026-11-02]}
    ]} />

    <.date_range_picker name="period" presets={[:last_7_days, :this_week, :last_month]} />\
    """
  end

  defp zone_code do
    """
    <.datetime_picker name="ny[starts]" label="Starts" zone="America/New_York" value="2026-11-01T01:30" />

    case SutraUI.Time.parse_datetime(params["starts"], "America/New_York") do
      {:ok, datetime} -> ...
      {:ambiguous, first, second} -> ...   # a repeated hour: the picker asks which
      {:gap, before, after} -> ...         # a skipped time: nothing is posted
      {:error, :invalid} -> ...
    end\
    """
  end

  defp dialog_code do
    """
    <.dialog id="visit-dialog" show={@open} on_cancel="close">
      <:title>Plan a visit</:title>
      <.form for={@form} phx-change="change" phx-submit="save">
        <.input field={@form[:campus]} type="select" label="Campus" options={@campuses} />
        <.date_picker field={@form[:day]} label="Day" rules={@rules} zone="Asia/Kolkata" />
        <.button type="submit">Save</.button>
      </.form>
    </.dialog>\
    """
  end
end
