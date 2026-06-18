defmodule SutrauiDemoWeb.Components.StepperLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Stepper", current_step: 2)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/stepper">
      <.docs_header
        title="Stepper"
        description="A progress indicator for multi-step workflows. States auto-compute from the current step."
      />

      <.component_demo title="Horizontal" code={horizontal_code()}>
        <div class="w-full max-w-xl">
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
        </div>
      </.component_demo>

      <.section_heading id="vertical">Vertical</.section_heading>
      <.prose>
        Use
        <.inline_code>orientation="vertical"</.inline_code>
        for side panels or mobile flows. The connector line runs vertically
        between markers.
      </.prose>

      <.component_demo title="Vertical" code={vertical_code()}>
        <div class="w-full max-w-md">
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
        </div>
      </.component_demo>

      <.section_heading id="responsive">Responsive</.section_heading>
      <.prose>
        Set
        <.inline_code>orientation="responsive"</.inline_code>
        to stack vertically on mobile and switch to horizontal on larger
        screens.
      </.prose>

      <.component_demo title="Responsive" code={responsive_code()}>
        <div class="w-full">
          <.stepper current={2} orientation="responsive">
            <:step>
              <h4>Design</h4>
              <p>Wireframes</p>
            </:step>
            <:step>
              <h4>Build</h4>
              <p>Implementation</p>
            </:step>
            <:step>
              <h4>Review</h4>
              <p>QA pass</p>
            </:step>
            <:step>
              <h4>Ship</h4>
              <p>Deploy</p>
            </:step>
          </.stepper>
        </div>
      </.component_demo>

      <.section_heading id="clickable">Clickable Steps</.section_heading>
      <.prose>
        Pass a
        <.inline_code>select_event</.inline_code>
        and a
        <.inline_code>value</.inline_code>
        on each step to make markers clickable. The event fires with
        <.inline_code>phx-value-step</.inline_code>
        set to the step's value.
      </.prose>

      <.component_demo title="Interactive Wizard" code={clickable_code()}>
        <div class="w-full max-w-xl">
          <.stepper current={@current_step} select_event="jump_to_step">
            <:step value="profile">
              <h4>Profile</h4>
              <p>Tell us about yourself</p>
            </:step>
            <:step value="workspace">
              <h4>Workspace</h4>
              <p>Configure defaults</p>
            </:step>
            <:step value="invite">
              <h4>Invite</h4>
              <p>Bring in teammates</p>
            </:step>
          </.stepper>
          <p class="mt-4 text-sm text-muted-foreground">
            Click any marker above to jump to that step. Currently on step {@current_step}.
          </p>
        </div>
      </.component_demo>

      <.section_heading id="error">Error State</.section_heading>
      <.prose>
        Pass an
        <.inline_code>errors</.inline_code>
        map keyed by step index (1-based). The step auto-marks as error and
        shows the message — no per-step state attrs needed.
      </.prose>

      <.component_demo title="Error State" code={error_code()}>
        <div class="w-full max-w-xl">
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
        </div>
      </.component_demo>

      <.section_heading id="variants">Variants</.section_heading>
      <.prose>
        The
        <.inline_code>default</.inline_code>
        variant uses solid markers.
        <.inline_code>variant="outline"</.inline_code>
        gives a lighter, bordered look that reads well on muted backgrounds.
      </.prose>

      <.component_demo title="Outline Variant" code={outline_code()}>
        <div class="w-full max-w-xl rounded-lg bg-muted/40 p-6">
          <.stepper current={2} variant="outline">
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
        </div>
      </.component_demo>

      <.section_heading id="custom-icons">Custom Markers</.section_heading>
      <.prose>
        Use the
        <.inline_code>icon</.inline_code>
        slot attr to replace the marker content with text or an emoji. This
        overrides both the number and the auto-state check/error icons.
      </.prose>

      <.component_demo title="Custom Icons" code={icons_code()}>
        <div class="w-full max-w-md">
          <.stepper current={3} orientation="vertical">
            <:step icon="✓">
              <h4>Order placed</h4>
            </:step>
            <:step icon="✓">
              <h4>Shipped</h4>
            </:step>
            <:step icon="🚚">
              <h4>In transit</h4>
              <p>Arriving today</p>
            </:step>
            <:step icon="📦">
              <h4>Delivered</h4>
            </:step>
          </.stepper>
        </div>
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          Step states auto-compute from
          <.inline_code>current</.inline_code>
          (1-based): before = complete, at = current, after = pending.
        </.list_item>
        <.list_item>
          The
          <.inline_code>errors</.inline_code>
          map overrides auto-state — a step with an error entry shows the error
          icon and message regardless of its position.
        </.list_item>
        <.list_item>
          When
          <.inline_code>select_event</.inline_code>
          is set, markers render as buttons with keyboard focus and hover
          states. Without it, they're non-interactive spans.
        </.list_item>
        <.list_item>
          Use
          <.inline_code>orientation="responsive"</.inline_code>
          for wizards that need to work on both mobile and desktop.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  def handle_event("jump_to_step", %{"step" => step}, socket) do
    step_index =
      case step do
        "profile" -> 1
        "workspace" -> 2
        "invite" -> 3
        _ -> 1
      end

    {:noreply, assign(socket, current_step: step_index)}
  end

  defp horizontal_code do
    """
    <.stepper current={2}>
      <:step><h4>Profile</h4><p>Tell us about yourself</p></:step>
      <:step><h4>Workspace</h4><p>Configure team defaults</p></:step>
      <:step><h4>Invite</h4><p>Bring in teammates</p></:step>
    </.stepper>\
    """
  end

  defp vertical_code do
    """
    <.stepper current={3} orientation="vertical">
      <:step><h4>Account</h4><p>Email and password</p></:step>
      <:step><h4>Team</h4><p>Invite collaborators</p></:step>
      <:step><h4>Billing</h4><p>Choose a plan</p></:step>
      <:step><h4>Launch</h4><p>Go live</p></:step>
    </.stepper>\
    """
  end

  defp responsive_code do
    """
    <.stepper current={2} orientation="responsive">
      <:step><h4>Design</h4><p>Wireframes</p></:step>
      <:step><h4>Build</h4><p>Implementation</p></:step>
      <:step><h4>Review</h4><p>QA pass</p></:step>
      <:step><h4>Ship</h4><p>Deploy</p></:step>
    </.stepper>\
    """
  end

  defp clickable_code do
    """
    <.stepper current={@current_step} select_event="jump_to_step">
      <:step value="profile"><h4>Profile</h4></:step>
      <:step value="workspace"><h4>Workspace</h4></:step>
      <:step value="invite"><h4>Invite</h4></:step>
    </.stepper>\
    """
  end

  defp error_code do
    """
    <.stepper current={3} errors={%{3 => "Card declined"}}>
      <:step><h4>Select plan</h4></:step>
      <:step><h4>Payment</h4></:step>
      <:step><h4>Confirm</h4></:step>
    </.stepper>\
    """
  end

  defp outline_code do
    """
    <.stepper current={2} variant="outline">
      <:step><h4>Design</h4><p>Wireframes</p></:step>
      <:step><h4>Build</h4><p>Implementation</p></:step>
      <:step><h4>Ship</h4><p>Deploy</p></:step>
    </.stepper>\
    """
  end

  defp icons_code do
    """
    <.stepper current={3} orientation="vertical">
      <:step icon="✓"><h4>Order placed</h4></:step>
      <:step icon="✓"><h4>Shipped</h4></:step>
      <:step icon="🚚"><h4>In transit</h4><p>Arriving today</p></:step>
      <:step icon="📦"><h4>Delivered</h4></:step>
    </.stepper>\
    """
  end
end
