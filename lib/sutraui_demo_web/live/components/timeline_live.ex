defmodule SutrauiDemoWeb.Components.TimelineLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Timeline")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/timeline">
      <.docs_header
        title="Timeline"
        description="Displays chronological events for activity feeds, releases, and process history."
      />

      <.component_demo title="Default" code={default_code()}>
        <.timeline>
          <:item
            title="Project created"
            time="09:00"
            description="Workspace and default settings were created."
          />
          <:item
            title="Invite sent"
            time="09:24"
            description="Team members were invited to collaborate."
          />
          <:item
            title="Ready for review"
            time="10:10"
            description="The project moved into final review."
            state="current"
          />
        </.timeline>
      </.component_demo>

      <.section_heading id="custom-content">Custom Content</.section_heading>
      <.component_demo title="Release Timeline" code={release_code()}>
        <.timeline>
          <:item title="v0.3.0" time="Today" state="complete">
            <div
              class="mt-3 rounded-md border p-3 text-sm"
              style="border-color: var(--border); color: var(--fg-muted);"
            >
              Separator, Marquee, and the next component batch are available.
            </div>
          </:item>
          <:item
            title="v0.4.0"
            time="Next"
            description="More form and navigation primitives."
            state="muted"
          />
        </.timeline>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.timeline>
      <:item title="Project created" time="09:00" description="Workspace created." />
      <:item title="Ready for review" time="10:10" state="current" />
    </.timeline>\
    """
  end

  defp release_code do
    """
    <.timeline>
      <:item title="v0.3.0" time="Today" state="complete">
        Separator and Marquee are available.
      </:item>
    </.timeline>\
    """
  end
end
