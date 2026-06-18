defmodule SutrauiDemoWeb.Components.StepperLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(page_title: "Stepper", current_step: 2)
      |> assign(
        wizard_step: "account",
        wizard_params: %{},
        wizard_errors: %{},
        wizard_field_errors: %{}
      )

    {:ok, socket}
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

      <.section_heading id="wizard-form">Wizard Form</.section_heading>
      <.prose>
        Use the stepper as navigation chrome for larger LiveView forms. The
        parent LiveView owns validation and decides when to advance.
      </.prose>

      <.component_demo title="Workspace Wizard" code={wizard_code()}>
        <div class="w-full max-w-xl">
          <.form
            id="workspace-wizard-form"
            for={%{}}
            as={:wizard}
            phx-change="validate"
            phx-submit="next_step"
            class="grid gap-6"
          >
            <.stepper_wizard
              id="workspace-wizard"
              current={@wizard_step}
              errors={@wizard_errors}
              orientation="responsive"
            >
              <:step id="account" label="Account" description="Profile details">
                <div class="grid gap-4">
                  <.input
                    name="wizard[full_name]"
                    label="Full name"
                    value={@wizard_params["full_name"]}
                    errors={field_errors(@wizard_field_errors, "full_name")}
                    placeholder="Maya Chen"
                  />
                  <.input
                    name="wizard[email]"
                    type="email"
                    label="Email"
                    value={@wizard_params["email"]}
                    errors={field_errors(@wizard_field_errors, "email")}
                    placeholder="maya@example.com"
                  />
                </div>
              </:step>
              <:step id="workspace" label="Workspace" description="Team setup">
                <div class="grid gap-4">
                  <.input
                    name="wizard[company]"
                    label="Company"
                    value={@wizard_params["company"]}
                    placeholder="Acme Inc."
                  />
                  <.input
                    name="wizard[workspace]"
                    label="Workspace URL"
                    value={@wizard_params["workspace"]}
                    placeholder="acme"
                  />
                </div>
              </:step>
              <:step id="invite" label="Invite" description="Add teammates">
                <div class="rounded-md border bg-muted/30 p-4 text-sm text-muted-foreground">
                  Invite teammates after the workspace is created.
                </div>
              </:step>
              <:actions>
                <.button type="submit">Continue</.button>
              </:actions>
            </.stepper_wizard>
          </.form>
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

  def handle_event("validate", %{"wizard" => params}, socket) do
    field_errors = validate_touched_wizard_step(socket.assigns.wizard_step, params)

    step_errors =
      if field_errors == %{} do
        %{}
      else
        %{socket.assigns.wizard_step => "Complete required fields"}
      end

    {:noreply,
     socket
     |> assign(wizard_params: params)
     |> assign(wizard_errors: step_errors)
     |> assign(wizard_field_errors: field_errors)}
  end

  def handle_event("next_step", %{"wizard" => params}, socket) do
    case validate_wizard_step(socket.assigns.wizard_step, params) do
      :ok ->
        {:noreply,
         socket
         |> assign(wizard_step: next_wizard_step(socket.assigns.wizard_step))
         |> assign(wizard_params: params, wizard_errors: %{}, wizard_field_errors: %{})}

      {:error, field_errors} ->
        {:noreply,
         socket
         |> assign(wizard_params: params)
         |> assign(wizard_errors: %{socket.assigns.wizard_step => "Complete required fields"})
         |> assign(wizard_field_errors: field_errors)}
    end
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
    </.stepper>
    <p class="text-sm text-muted-foreground">
      Click any marker above to jump to that step. Currently on step {@current_step}.
    </p>\
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

  defp wizard_code do
    """
    <.form
      id="workspace-wizard-form"
      for={%{}}
      as={:wizard}
      phx-change="validate"
      phx-submit="next_step"
      class="grid gap-6"
    >
      <.stepper_wizard
        id="workspace-wizard"
        current={@wizard_step}
        errors={@wizard_errors}
        orientation="responsive"
      >
        <:step id="account" label="Account" description="Profile details">
          <.input
            name="wizard[full_name]"
            label="Full name"
            value={@wizard_params["full_name"]}
            errors={field_errors(@wizard_field_errors, "full_name")}
            placeholder="Maya Chen"
          />
          <.input
            name="wizard[email]"
            type="email"
            label="Email"
            value={@wizard_params["email"]}
            errors={field_errors(@wizard_field_errors, "email")}
            placeholder="maya@example.com"
          />
        </:step>
        <:step id="workspace" label="Workspace" description="Team setup">
          <.input name="wizard[company]" label="Company" value={@wizard_params["company"]} placeholder="Acme Inc." />
          <.input name="wizard[workspace]" label="Workspace URL" value={@wizard_params["workspace"]} placeholder="acme" />
        </:step>
        <:step id="invite" label="Invite" description="Add teammates">
          <div class="rounded-md border bg-muted/30 p-4 text-sm text-muted-foreground">
            Invite teammates after the workspace is created.
          </div>
        </:step>
        <:actions>
          <.button type="submit">Continue</.button>
        </:actions>
      </.stepper_wizard>
    </.form>\
    """
  end

  defp validate_wizard_step("account", params) do
    required =
      %{}
      |> require_param(params, "full_name")
      |> require_param(params, "email")

    if required == %{}, do: :ok, else: {:error, required}
  end

  defp validate_wizard_step(_step, _params), do: :ok

  defp validate_touched_wizard_step("account", params) do
    %{}
    |> require_touched_param(params, "full_name")
    |> require_touched_param(params, "email")
  end

  defp validate_touched_wizard_step(_step, _params), do: %{}

  defp require_param(errors, params, field) do
    value = params[field] |> to_string() |> String.trim()

    if value == "" do
      Map.put(errors, field, ["can't be blank"])
    else
      errors
    end
  end

  defp require_touched_param(errors, params, field) do
    if Map.has_key?(params, "_unused_#{field}") do
      errors
    else
      require_param(errors, params, field)
    end
  end

  defp field_errors(errors, field), do: Map.get(errors, field, [])

  defp next_wizard_step("account"), do: "workspace"
  defp next_wizard_step("workspace"), do: "invite"
  defp next_wizard_step(step), do: step
end
