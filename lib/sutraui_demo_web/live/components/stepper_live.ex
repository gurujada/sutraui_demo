defmodule SutrauiDemoWeb.Components.StepperLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Stepper")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/stepper">
      <.docs_header
        title="Stepper"
        description="Displays progress through a sequence of steps."
      />

      <.component_demo title="Default" code={default_code()}>
        <div class="w-full">
          <.stepper current={2}>
            <:step title="Profile" description="Add personal details" />
            <:step title="Workspace" description="Choose defaults" />
            <:step title="Invite" description="Add collaborators" />
          </.stepper>
        </div>
      </.component_demo>

      <.section_heading id="vertical">Vertical</.section_heading>
      <.component_demo title="Vertical Stepper" code={vertical_code()}>
        <.stepper orientation="vertical" current={3}>
          <:step title="Account created" description="Workspace owner confirmed" />
          <:step title="Billing reviewed" description="Plan and payment method verified" />
          <:step title="Ready to launch" description="Final settings are being checked" />
        </.stepper>
      </.component_demo>

      <.section_heading id="states">States</.section_heading>
      <.component_demo title="Explicit States" code={states_code()}>
        <.stepper variant="solid" linear>
          <:step title="Queued" state="complete" />
          <:step title="Syncing" state="current" />
          <:step title="Failed" state="error" />
        </.stepper>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.stepper current={2}>
      <:step title="Profile" description="Add personal details" />
      <:step title="Workspace" description="Choose defaults" />
      <:step title="Invite" description="Add collaborators" />
    </.stepper>\
    """
  end

  defp vertical_code do
    """
    <.stepper orientation="vertical" current={3}>
      <:step title="Account created" description="Workspace owner confirmed" />
      <:step title="Billing reviewed" description="Plan and payment method verified" />
      <:step title="Ready to launch" description="Final settings are being checked" />
    </.stepper>\
    """
  end

  defp states_code do
    """
    <.stepper variant="solid" linear>
      <:step title="Queued" state="complete" />
      <:step title="Syncing" state="current" />
      <:step title="Failed" state="error" />
    </.stepper>\
    """
  end
end
