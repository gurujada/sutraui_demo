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
        description="A progress indicator for multi-step workflows. States auto-compute from the current step."
      />

      <.component_demo title="Default" code={default_code()}>
        <.stepper current={2}>
          <:step>
            <h4>Profile</h4>
            <p>Tell us about yourself</p>
          </:step>
          <:step>
            <h4>Workspace</h4>
            <p>Configure team defaults</p>
          </:step>
          <:step>
            <h4>Invite</h4>
            <p>Bring in teammates</p>
          </:step>
        </.stepper>
      </.component_demo>

      <.section_heading id="vertical">Vertical</.section_heading>
      <.prose>
        Use
        <.inline_code>orientation="vertical"</.inline_code>
        for side panels or mobile flows.
      </.prose>

      <.component_demo title="Vertical" code={vertical_code()}>
        <.stepper current={3} orientation="vertical">
          <:step>
            <h4>Account</h4>
            <p>Email and password</p>
          </:step>
          <:step>
            <h4>Team</h4>
            <p>Invite collaborators</p>
          </:step>
          <:step>
            <h4>Billing</h4>
            <p>Choose a plan</p>
          </:step>
          <:step>
            <h4>Launch</h4>
            <p>Go live</p>
          </:step>
        </.stepper>
      </.component_demo>

      <.section_heading id="error">Error State</.section_heading>
      <.prose>
        Pass an
        <.inline_code>errors</.inline_code>
        map keyed by step index. No per-step state attrs needed.
      </.prose>

      <.component_demo title="Error State" code={error_code()}>
        <.stepper current={3} errors={%{3 => "Card declined"}}>
          <:step>
            <h4>Select plan</h4>
          </:step>
          <:step>
            <h4>Payment</h4>
          </:step>
          <:step>
            <h4>Confirm</h4>
          </:step>
        </.stepper>
      </.component_demo>

      <.section_heading id="variants">Variants</.section_heading>
      <.prose>
        The
        <.inline_code>default</.inline_code>
        variant uses solid markers.
        <.inline_code>variant="white"</.inline_code>
        gives a lighter, bordered look.
      </.prose>

      <.component_demo title="White Variant" code={white_code()}>
        <.stepper current={2} variant="white">
          <:step>
            <h4>Design</h4>
            <p>Wireframes</p>
          </:step>
          <:step>
            <h4>Build</h4>
            <p>Implementation</p>
          </:step>
          <:step>
            <h4>Ship</h4>
            <p>Deploy</p>
          </:step>
        </.stepper>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    ~s|<.stepper current={2}>\n  <:step><h4>Profile</h4><p>Tell us about yourself</p></:step>\n  <:step><h4>Workspace</h4><p>Configure team defaults</p></:step>\n  <:step><h4>Invite</h4><p>Bring in teammates</p></:step>\n</.stepper>|
  end

  defp vertical_code do
    ~s|<.stepper current={3} orientation="vertical">\n  <:step><h4>Account</h4><p>Email and password</p></:step>\n  <:step><h4>Team</h4><p>Invite collaborators</p></:step>\n  <:step><h4>Billing</h4><p>Choose a plan</p></:step>\n  <:step><h4>Launch</h4><p>Go live</p></:step>\n</.stepper>|
  end

  defp error_code do
    ~s|<.stepper current={3} errors={%{3 => "Card declined"}}>\n  <:step><h4>Select plan</h4></:step>\n  <:step><h4>Payment</h4></:step>\n  <:step><h4>Confirm</h4></:step>\n</.stepper>|
  end

  defp white_code do
    ~s|<.stepper current={2} variant="white">\n  <:step><h4>Design</h4><p>Wireframes</p></:step>\n  <:step><h4>Build</h4><p>Implementation</p></:step>\n  <:step><h4>Ship</h4><p>Deploy</p></:step>\n</.stepper>|
  end
end
