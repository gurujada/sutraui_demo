defmodule SutrauiDemoWeb.Components.TimeLive do
  use SutrauiDemoWeb, :live_view

  @zone "Asia/Kolkata"

  def mount(_params, _session, socket) do
    now = DateTime.utc_now()

    {:ok,
     socket
     |> assign(page_title: "Time")
     |> assign(zone: @zone, now: now)
     |> assign(
       just_now: DateTime.add(now, -20, :second),
       minutes: DateTime.add(now, -17 * 60, :second),
       hours: DateTime.add(now, -3 * 3600, :second),
       days: DateTime.add(now, -2 * 86_400, :second),
       soon: DateTime.add(now, 2 * 86_400 + 3600, :second),
       due: ~U[2026-11-05 09:00:00Z],
       dst: ~U[2026-03-08 07:30:00Z]
     )}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} sutra_commands={@sutra_commands} current_path="/docs/components/time">
      <.docs_header
        title="Time"
        description="Relative and absolute times that stay correct without JavaScript and in one shown zone."
      />

      <.callout>
        Absolute times show in the place's zone (here <.inline_code>Asia/Kolkata</.inline_code>) on a 24-hour clock.
        When your browser's zone shows a different wall time, a hint with your own time is added. Nothing is converted silently.
      </.callout>

      <.section_heading id="relative">Relative time</.section_heading>
      <.prose>
        <.inline_code>relative_time</.inline_code>
        renders final English words inside
        <.inline_code>&lt;time datetime title&gt;</.inline_code>
        and refreshes them from one shared timer on the page. The
        <.inline_code>title</.inline_code>
        holds the exact time.
      </.prose>

      <.component_demo title="Relative time" code={relative_code()}>
        <ul class="space-y-2 text-sm">
          <li>Joined: <.relative_time id="rel-just-now" at={@just_now} /></li>
          <li>Edited: <.relative_time id="rel-minutes" at={@minutes} /></li>
          <li>Posted: <.relative_time id="rel-hours" at={@hours} /></li>
          <li>Replied: <.relative_time id="rel-days" at={@days} /></li>
          <li>Due: <.relative_time id="rel-soon" at={@soon} /></li>
        </ul>
      </.component_demo>

      <.section_heading id="length">Short and long</.section_heading>
      <.prose>
        <.inline_code>length</.inline_code>
        is
        <.inline_code>:long</.inline_code>
        (default) or
        <.inline_code>:short</.inline_code>
        for tight places such as table cells.
      </.prose>

      <.component_demo title="Length" code={length_code()}>
        <ul class="space-y-2 text-sm">
          <li>Long: <.relative_time id="len-long" at={@hours} length={:long} /></li>
          <li>Short: <.relative_time id="len-short" at={@hours} length={:short} /></li>
          <li>Short, future: <.relative_time id="len-short-soon" at={@soon} length={:short} /></li>
        </ul>
      </.component_demo>

      <.section_heading id="local">Local time</.section_heading>
      <.prose>
        <.inline_code>local_time</.inline_code>
        shows an instant in the place's zone. The format is one of <.inline_code>:date</.inline_code>, <.inline_code>:short</.inline_code>, <.inline_code>:long</.inline_code>, <.inline_code>:day</.inline_code>, <.inline_code>:time</.inline_code>, <.inline_code>:date_time</.inline_code>, <.inline_code>:day_time</.inline_code>,
        <.inline_code>:full</.inline_code>
        or <.inline_code>:month</.inline_code>.
      </.prose>

      <.component_demo title="Formats" code={local_code()}>
        <dl id="local-formats" class="grid grid-cols-[8rem_1fr] gap-x-4 gap-y-2 text-sm">
          <%= for format <- ~w(date short long day time date_time day_time full month)a do %>
            <dt class="font-mono text-xs text-muted-foreground">{inspect(format)}</dt>
            <dd><.local_time id={"local-#{format}"} at={@due} format={format} zone={@zone} /></dd>
          <% end %>
        </dl>
      </.component_demo>

      <.section_heading id="viewer-zone">The viewer's zone</.section_heading>
      <.prose>
        The place's zone is <.inline_code>Asia/Kolkata</.inline_code>.
        If your browser is set to another zone, the line below gains a hint such as <.inline_code>· Thu 04:30 your time</.inline_code>.
        In India you see no hint, because both clocks agree.
      </.prose>

      <.component_demo title="Place zone and your zone" code={zone_code()}>
        <div class="space-y-2 text-sm">
          <p>
            Class starts <.local_time id="zone-start" at={@due} format={:day_time} zone={@zone} />
          </p>
          <p>
            Same instant in New York:
            <.local_time id="zone-ny" at={@due} format={:day_time} zone="America/New_York" />
          </p>
          <p>
            Hint switched off:
            <.local_time id="zone-nohint" at={@due} format={:day_time} zone={@zone} hint={false} />
          </p>
        </div>
      </.component_demo>

      <.section_heading id="setup">Setup</.section_heading>
      <.prose>
        Converting to a named zone needs a time zone database. Sutra UI does not bundle one:
        add
        <.inline_code>tz</.inline_code>
        and configure it once.
      </.prose>
      <.code_block language="elixir" code={setup_code()} />

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          The server renders the words, so tests, emails and first paint are right without JavaScript.
        </.list_item>
        <.list_item>
          Relative words refresh every 30 seconds while any is under an hour, then every five minutes.
        </.list_item>
        <.list_item>
          A
          <.inline_code>Date</.inline_code>
          given a time format reads as its day; a
          <.inline_code>NaiveDateTime</.inline_code>
          has no zone, so its zone words are left out.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp relative_code do
    """
    <.relative_time at={@post.inserted_at} />
    <%!-- "3 hours ago", refreshed by the hook --%>\
    """
  end

  defp length_code do
    """
    <.relative_time at={@due} length={:long} />   <%!-- "in 2 days" --%>
    <.relative_time at={@due} length={:short} />  <%!-- "in 2d" --%>\
    """
  end

  defp local_code do
    """
    <.local_time at={@due} format={:day_time} zone="Asia/Kolkata" />
    <%!-- "Thu 5 Nov, 14:30 IST" --%>

    SutraUI.Time.format(~U[2026-11-05 09:00:00Z], :full, "Asia/Kolkata")
    #=> "5 Nov 2026, 14:30 IST"\
    """
  end

  defp zone_code do
    """
    <.local_time at={@starts_at} format={:day_time} zone={@workbook.time_zone} />
    <.local_time at={@starts_at} format={:day_time} zone="America/New_York" />
    <.local_time at={@starts_at} format={:day_time} zone={@zone} hint={false} />\
    """
  end

  defp setup_code do
    """
    # mix.exs
    {:tz, "~> 0.28"}

    # config/config.exs
    config :elixir, :time_zone_database, Tz.TimeZoneDatabase\
    """
  end
end
