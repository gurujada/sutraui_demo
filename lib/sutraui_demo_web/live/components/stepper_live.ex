defmodule SutrauiDemoWeb.Components.StepperLive do
  use SutrauiDemoWeb, :live_view

  @types %{
    full_name: :string,
    email: :string,
    company: :string,
    role: :string,
    plan: :string,
    seats: :integer,
    billing_email: :string
  }

  @empty_data %{
    full_name: nil,
    email: nil,
    company: nil,
    role: nil,
    plan: nil,
    seats: nil,
    billing_email: nil
  }

  @steps ["account", "workspace", "billing", "review"]

  @step_fields %{
    "account" => [:full_name, :email],
    "workspace" => [:company, :role],
    "billing" => [:plan, :seats, :billing_email],
    "review" => []
  }

  def mount(_params, _session, socket) do
    params = %{}

    socket =
      socket
      |> assign(:page_title, "Stepper")
      |> assign(:step, "account")
      |> assign(:params, params)
      |> assign(:step_errors, %{})
      |> assign_form(params)

    {:ok, socket}
  end

  def handle_event("validate", %{"wizard" => params}, socket) do
    clean_params = merge_params(socket.assigns.params, params)
    form_params = with_unused_params(clean_params, params)
    changeset = wizard_changeset(form_params, :validate, current_fields(socket.assigns.step))

    step_errors =
      maybe_clear_step_error(socket.assigns.step_errors, changeset, socket.assigns.step)

    {:noreply,
     socket
     |> assign(:params, clean_params)
     |> assign(:step_errors, step_errors)
     |> assign(:form, to_form(changeset, as: "wizard"))}
  end

  def handle_event("previous", _params, socket) do
    {:noreply, assign(socket, :step, previous_step(socket.assigns.step))}
  end

  def handle_event("submit_wizard", %{"wizard" => params}, socket) do
    params = merge_params(socket.assigns.params, params)
    step = socket.assigns.step
    fields = fields_for_submit(step)
    changeset = wizard_changeset(params, :validate, fields)

    cond do
      step == "review" && changeset.valid? ->
        {:noreply,
         socket
         |> put_flash(:info, "Workspace setup saved.")
         |> assign(:params, %{})
         |> assign(:step, "account")
         |> assign(:step_errors, %{})
         |> assign_form(%{})}

      step == "review" ->
        {:noreply,
         socket
         |> assign(:params, params)
         |> assign(:step_errors, step_error_map(changeset, @steps))
         |> assign(:form, to_form(changeset, as: "wizard"))}

      step_valid?(changeset, step) ->
        next = next_step(step)

        {:noreply,
         socket
         |> assign(:step, next)
         |> assign(:params, params)
         |> assign(:step_errors, Map.delete(socket.assigns.step_errors, step))
         |> assign_form(params)}

      true ->
        {:noreply,
         socket
         |> assign(:params, params)
         |> assign(:step_errors, step_error_map(changeset, [step]))
         |> assign(:form, to_form(changeset, as: "wizard"))}
    end
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

      <.section_heading id="wizard">Wizard Composition</.section_heading>
      <.prose>
        Compose the stepper with
        <.inline_code>stepper_wizard</.inline_code>
        when a long form needs to render one step at a time. The parent LiveView owns the form, validation, and persistence.
      </.prose>

      <.component_demo title="Multi-step Form" code={wizard_code()}>
        <div class="w-full max-w-3xl">
          <.form for={@form} phx-change="validate" phx-submit="submit_wizard" class="form">
            <.stepper_wizard
              id="workspace-wizard"
              current={@step}
              errors={@step_errors}
              orientation="responsive"
            >
              <:step id="account" label="Account" description="Owner details">
                <div class="grid gap-4 sm:grid-cols-2">
                  <.input
                    field={@form[:full_name]}
                    type="text"
                    label="Full name"
                    placeholder="Maya Chen"
                  />
                  <.input
                    field={@form[:email]}
                    type="email"
                    label="Email"
                    placeholder="maya@example.com"
                  />
                </div>
              </:step>

              <:step id="workspace" label="Workspace" description="Team profile">
                <div class="grid gap-4 sm:grid-cols-2">
                  <.input
                    field={@form[:company]}
                    type="text"
                    label="Company"
                    placeholder="Acme Inc."
                  />
                  <.input
                    field={@form[:role]}
                    type="select"
                    label="Role"
                    prompt="Select role"
                    options={[{"Founder", "founder"}, {"Operations", "ops"}, {"Engineering", "eng"}]}
                  />
                </div>
              </:step>

              <:step id="billing" label="Billing" description="Plan setup">
                <div class="grid gap-4 sm:grid-cols-3">
                  <.input
                    field={@form[:plan]}
                    type="select"
                    label="Plan"
                    prompt="Choose plan"
                    options={[{"Starter", "starter"}, {"Growth", "growth"}, {"Scale", "scale"}]}
                  />
                  <.input field={@form[:seats]} type="number" label="Seats" min="1" />
                  <.input
                    field={@form[:billing_email]}
                    type="email"
                    label="Billing email"
                    placeholder="billing@example.com"
                  />
                </div>
              </:step>

              <:step id="review" label="Review" description="Confirm">
                <dl class="grid gap-3 text-sm sm:grid-cols-2">
                  <div>
                    <dt class="text-muted-foreground">Owner</dt>
                    <dd class="font-medium">{value(@params, "full_name", "Not provided")}</dd>
                  </div>
                  <div>
                    <dt class="text-muted-foreground">Email</dt>
                    <dd class="font-medium">{value(@params, "email", "Not provided")}</dd>
                  </div>
                  <div>
                    <dt class="text-muted-foreground">Company</dt>
                    <dd class="font-medium">{value(@params, "company", "Not provided")}</dd>
                  </div>
                  <div>
                    <dt class="text-muted-foreground">Plan</dt>
                    <dd class="font-medium">{value(@params, "plan", "Not selected")}</dd>
                  </div>
                </dl>
              </:step>

              <:actions>
                <.button
                  type="button"
                  variant="outline"
                  phx-click="previous"
                  disabled={@step == "account"}
                >
                  Back
                </.button>
                <.button :if={@step != "review"} type="submit">
                  Continue
                </.button>
                <.button :if={@step == "review"} type="submit">
                  Save
                </.button>
              </:actions>
            </.stepper_wizard>
          </.form>
        </div>
      </.component_demo>

      <.section_heading id="liveview-form-flow">Usage with LiveView</.section_heading>
      <.prose>
        Keep the active step in LiveView assigns. On
        <.inline_code>phx-change</.inline_code>
        validate the current step only. On submit, validate the same fields before advancing.
        Keep Phoenix's
        <.inline_code>_unused_*</.inline_code>
        keys on the change render, but strip them before storing params; validate all fields on the review step.
      </.prose>

      <.code_block language="elixir" code={form_flow_code()} />

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          The
          <.inline_code>current</.inline_code>
          value drives the active step. Completed and pending states are derived from it.
        </.list_item>
        <.list_item>
          Pass an
          <.inline_code>errors</.inline_code>
          map to mark steps that need attention.
        </.list_item>
        <.list_item>
          <.inline_code>stepper_wizard</.inline_code>
          renders only the active step body. The parent LiveView owns form state, validation, and step transitions.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp form_flow_code do
    """
    @step_fields %{
      "account" => [:full_name, :email],
      "workspace" => [:company, :role],
      "billing" => [:plan, :seats, :billing_email]
    }

    def handle_event("validate", %{"wizard" => params}, socket) do
      clean_params = Map.merge(socket.assigns.params, strip_unused_params(params))
      form_params = Map.merge(clean_params, Map.take(params, unused_param_keys(params)))
      changeset = wizard_changeset(form_params, :validate, @step_fields[socket.assigns.step])

      {:noreply,
       socket
       |> assign(:params, clean_params)
       |> assign(:form, to_form(changeset, as: "wizard"))}
    end

    def handle_event("submit_wizard", %{"wizard" => params}, socket) do
      params = Map.merge(socket.assigns.params, strip_unused_params(params))
      step = socket.assigns.step
      changeset = wizard_changeset(params, :validate, @step_fields[step])

      if step_valid?(changeset, step) do
        {:noreply, socket |> assign(:step, next_step(step)) |> assign(:params, params)}
      else
        {:noreply, socket |> assign(:step_errors, %{step => "Complete required fields"})}
      end
    end\
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

  defp assign_form(socket, params, action \\ nil) do
    assign(
      socket,
      :form,
      to_form(wizard_changeset(params, action, current_fields(socket.assigns.step)), as: "wizard")
    )
  end

  defp wizard_changeset(params, action, fields) do
    changeset =
      {@empty_data, @types}
      |> Ecto.Changeset.cast(params, Map.keys(@types))
      |> Ecto.Changeset.validate_required(fields)
      |> validate_email(fields, :email)
      |> validate_email(fields, :billing_email)
      |> validate_seats(fields)

    if action, do: Map.put(changeset, :action, action), else: changeset
  end

  defp validate_email(changeset, fields, field) do
    if field in fields do
      Ecto.Changeset.validate_format(changeset, field, ~r/^[^\s]+@[^\s]+\.[^\s]+$/,
        message: "must be a valid email"
      )
    else
      changeset
    end
  end

  defp validate_seats(changeset, fields) do
    if :seats in fields do
      Ecto.Changeset.validate_number(changeset, :seats, greater_than: 0)
    else
      changeset
    end
  end

  defp step_valid?(changeset, step) do
    @step_fields
    |> Map.fetch!(step)
    |> Enum.all?(fn field -> !Keyword.has_key?(changeset.errors, field) end)
  end

  defp step_error_map(changeset, steps) do
    steps
    |> Enum.filter(fn step ->
      @step_fields
      |> Map.fetch!(step)
      |> Enum.any?(&Keyword.has_key?(changeset.errors, &1))
    end)
    |> Map.new(&{&1, "Complete required fields"})
  end

  defp maybe_clear_step_error(step_errors, changeset, step) do
    if step_valid?(changeset, step) do
      Map.delete(step_errors, step)
    else
      step_errors
    end
  end

  defp strip_unused_params(params) do
    Map.reject(params, fn {key, _value} -> String.starts_with?(to_string(key), "_unused_") end)
  end

  defp merge_params(stored_params, params) do
    Map.merge(stored_params, strip_unused_params(params))
  end

  defp with_unused_params(clean_params, params) do
    Map.merge(clean_params, Map.take(params, unused_param_keys(params)))
  end

  defp unused_param_keys(params) do
    params
    |> Map.keys()
    |> Enum.filter(&String.starts_with?(to_string(&1), "_unused_"))
  end

  defp current_fields(step), do: Map.fetch!(@step_fields, step)

  defp fields_for_submit("review"), do: Map.keys(@types)
  defp fields_for_submit(step), do: current_fields(step)

  defp next_step(step) do
    index = Enum.find_index(@steps, &(&1 == step)) || 0
    Enum.at(@steps, min(index + 1, length(@steps) - 1))
  end

  defp previous_step(step) do
    index = Enum.find_index(@steps, &(&1 == step)) || 0
    Enum.at(@steps, max(index - 1, 0))
  end

  defp value(params, key, fallback) do
    case Map.get(params, key) do
      nil -> fallback
      "" -> fallback
      value -> value
    end
  end

  defp wizard_code do
    """
    <.form for={@form} phx-change="validate" phx-submit="submit_wizard" class="form">
      <.stepper_wizard
        id="workspace-wizard"
        current={@step}
        errors={@step_errors}
        orientation="responsive"
      >
        <:step id="account" label="Account" description="Owner details">
          <.account_fields form={@form} />
        </:step>

        <:step id="workspace" label="Workspace" description="Team profile">
          <.workspace_fields form={@form} />
        </:step>

        <:step id="billing" label="Billing" description="Plan setup">
          <.billing_fields form={@form} />
        </:step>

        <:step id="review" label="Review" description="Confirm">
          <.review params={@params} />
        </:step>

        <:actions>
          <.button type="button" variant="outline" phx-click="previous">Back</.button>
          <.button :if={@step != "review"} type="submit">Continue</.button>
          <.button :if={@step == "review"} type="submit">Save</.button>
        </:actions>
      </.stepper_wizard>
    </.form>\
    """
  end
end
