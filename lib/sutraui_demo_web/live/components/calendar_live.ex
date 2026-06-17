defmodule SutrauiDemoWeb.Components.CalendarLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    today = Date.utc_today()
    {:ok, assign(socket, page_title: "Calendar", selected: today)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/calendar">
      <.docs_header
        title="Calendar"
        description="A dependency-free monthly calendar grid styled with Sutra UI tokens."
      />

      <.component_demo title="Default" code={default_code()}>
        <.calendar
          year={@selected.year}
          month={@selected.month}
          selected={@selected}
          select_event="select_date"
        />
      </.component_demo>

      <.section_heading id="monday">Monday Week Start</.section_heading>
      <.component_demo title="Monday Start" code={monday_code()}>
        <.calendar year={2026} month={6} selected="2026-06-17" week_start={1} />
      </.component_demo>
    </Layouts.docs>
    """
  end

  def handle_event("select_date", %{"date" => date}, socket) do
    {:noreply, assign(socket, :selected, Date.from_iso8601!(date))}
  end

  defp default_code do
    """
    <.calendar selected={@selected} select_event="select_date" />\
    """
  end

  defp monday_code do
    """
    <.calendar year={2026} month={6} selected="2026-06-17" week_start={1} />\
    """
  end
end
