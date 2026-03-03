defmodule SutrauiDemoWeb.Components.InputLive do
  use SutrauiDemoWeb, :live_view

  @types %{
    name: :string,
    email: :string,
    password: :string,
    terms: :boolean
  }

  @default_data %{
    name: nil,
    email: nil,
    password: nil,
    terms: false
  }

  def mount(_params, _session, socket) do
    changeset = registration_changeset(@default_data, %{})
    {:ok, assign(socket, page_title: "Input", form: to_form(changeset, as: "registration"))}
  end

  def handle_event("validate", %{"registration" => params}, socket) do
    changeset =
      @default_data
      |> registration_changeset(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset, as: "registration"))}
  end

  def handle_event("save", %{"registration" => params}, socket) do
    changeset =
      @default_data
      |> registration_changeset(params)
      |> Map.put(:action, :validate)

    if changeset.valid? do
      {:noreply,
       socket
       |> put_flash(:info, "Registration submitted successfully!")
       |> assign(form: to_form(registration_changeset(@default_data, %{}), as: "registration"))}
    else
      {:noreply, assign(socket, form: to_form(changeset, as: "registration"))}
    end
  end

  defp registration_changeset(data, params) do
    {data, @types}
    |> Ecto.Changeset.cast(params, Map.keys(@types))
    |> Ecto.Changeset.validate_required([:name, :email, :password])
    |> Ecto.Changeset.validate_format(:email, ~r/^[^\s]+@[^\s]+\.[^\s]+$/,
      message: "must be a valid email address"
    )
    |> Ecto.Changeset.validate_length(:password, min: 8)
    |> Ecto.Changeset.validate_acceptance(:terms, message: "you must accept the terms")
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/input">
      <.docs_header
        title="Input"
        description="The unified form field component. Renders inputs with optional label, description, and error handling. Integrates with Phoenix forms."
      />

      <.component_demo title="Default" code={~s|<.input type="text" placeholder="Enter text..." />|}>
        <div class="w-full max-w-sm">
          <.input type="text" placeholder="Enter text..." />
        </div>
      </.component_demo>

      <.section_heading id="with-label">With Label</.section_heading>
      <.prose>
        Add a label using the
        <.inline_code>label</.inline_code>
        attribute. The label renders directly above the input.
      </.prose>

      <.component_demo title="With Label" code={label_code()}>
        <div class="w-full max-w-sm">
          <.input type="email" label="Email" placeholder="name@example.com" />
        </div>
      </.component_demo>

      <.section_heading id="with-description">With Description</.section_heading>
      <.prose>
        Add helper text using the
        <.inline_code>description</.inline_code>
        attribute. It renders between the label and the input, and is linked via
        <.inline_code>aria-describedby</.inline_code>
        for accessibility.
      </.prose>

      <.component_demo title="With Description" code={description_code()}>
        <div class="w-full max-w-sm">
          <.input
            type="text"
            name="username"
            id="username"
            label="Username"
            description="This will be your public display name."
            placeholder="johndoe"
          />
        </div>
      </.component_demo>

      <.section_heading id="with-errors">With Errors</.section_heading>
      <.prose>
        Pass error messages via the
        <.inline_code>errors</.inline_code>
        attribute. The input automatically gets
        <.inline_code>aria-invalid="true"</.inline_code>
        and errors display below.
      </.prose>

      <.component_demo title="With Errors" code={error_code()}>
        <div class="w-full max-w-sm">
          <.input
            type="password"
            name="password"
            label="Password"
            placeholder="Enter password"
            errors={["Password must be at least 8 characters."]}
          />
        </div>
      </.component_demo>

      <.section_heading id="types">Input Types</.section_heading>
      <.prose>
        The input component supports all standard HTML input types.
      </.prose>

      <.component_demo title="Types" code={types_code()}>
        <div class="w-full max-w-sm space-y-6">
          <div>
            <.input type="email" label="Email" placeholder="name@example.com" />
          </div>
          <div>
            <.input type="password" label="Password" placeholder="Enter password" />
          </div>
          <div>
            <.input type="number" label="Amount" placeholder="0" />
          </div>
          <div>
            <.input type="date" label="Date" />
          </div>
        </div>
      </.component_demo>

      <.section_heading id="checkbox">Checkbox</.section_heading>
      <.prose>
        Use
        <.inline_code>type="checkbox"</.inline_code>
        for boolean inputs. The label renders inline next to the checkbox.
      </.prose>

      <.component_demo title="Checkbox" code={checkbox_code()}>
        <div class="w-full max-w-sm">
          <.input type="checkbox" name="terms" label="Accept terms and conditions" />
        </div>
      </.component_demo>

      <.section_heading id="switch">Switch</.section_heading>
      <.prose>
        Use
        <.inline_code>type="switch"</.inline_code>
        for toggle inputs. Renders with
        <.inline_code>role="switch"</.inline_code>
        for accessibility.
      </.prose>

      <.component_demo title="Switch" code={switch_code()}>
        <div class="w-full max-w-sm">
          <.input
            type="switch"
            name="notifications"
            label="Enable notifications"
            description="Receive email notifications for updates."
          />
        </div>
      </.component_demo>

      <.section_heading id="select">Select</.section_heading>
      <.prose>
        Use
        <.inline_code>type="select"</.inline_code>
        for native select dropdowns.
      </.prose>

      <.component_demo title="Select" code={select_code()}>
        <div class="w-full max-w-sm">
          <.input
            type="select"
            name="country"
            label="Country"
            description="Choose your country of residence."
            prompt="Select a country"
            options={[{"United States", "us"}, {"Canada", "ca"}, {"United Kingdom", "uk"}]}
          />
        </div>
      </.component_demo>

      <.section_heading id="textarea">Textarea</.section_heading>
      <.prose>
        Use
        <.inline_code>type="textarea"</.inline_code>
        for multi-line text input.
      </.prose>

      <.component_demo title="Textarea" code={textarea_code()}>
        <div class="w-full max-w-sm">
          <.input
            type="textarea"
            name="bio"
            label="Bio"
            description="Tell us about yourself."
            rows={4}
            placeholder="Write something..."
          />
        </div>
      </.component_demo>

      <.section_heading id="disabled">Disabled</.section_heading>
      <.prose>
        Use the disabled attribute to prevent interaction.
      </.prose>

      <.component_demo title="Disabled" code={disabled_code()}>
        <div class="w-full max-w-sm">
          <.input type="text" label="Disabled" placeholder="Cannot edit" disabled />
        </div>
      </.component_demo>

      <.section_heading id="with-form">With Form</.section_heading>
      <.prose>
        The input component integrates seamlessly with Phoenix forms using the
        <.inline_code>field</.inline_code>
        attribute. Errors from the changeset are displayed automatically after interaction.
      </.prose>

      <.code_block language="heex" code={form_code()} />

      <.section_heading id="complete-example">Complete Example</.section_heading>
      <.prose>
        A live form with changeset-based validation. Errors appear only after you interact
        with each field. Try tabbing through, or hit Register with empty fields.
      </.prose>

      <.component_demo title="Registration Form" code={complete_code()}>
        <div class="w-full max-w-sm">
          <.form for={@form} phx-change="validate" phx-submit="save">
            <.input field={@form[:name]} type="text" label="Name" placeholder="Jane Smith" />
            <.input
              field={@form[:email]}
              type="email"
              label="Email"
              placeholder="jane@example.com"
            />
            <.input
              field={@form[:password]}
              type="password"
              label="Password"
              description="Must be at least 8 characters."
              placeholder="Create a password"
            />
            <.input
              field={@form[:terms]}
              type="checkbox"
              label="I agree to the terms of service"
            />
            <div class="pt-2">
              <.button type="submit">Register</.button>
            </div>
          </.form>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp label_code do
    ~s|<.input type="email" label="Email" placeholder="name@example.com" />|
  end

  defp description_code do
    """
    <.input
      type="text"
      name="username"
      id="username"
      label="Username"
      description="This will be your public display name."
      placeholder="johndoe"
    />\
    """
  end

  defp error_code do
    """
    <.input
      type="password"
      name="password"
      label="Password"
      placeholder="Enter password"
      errors={["Password must be at least 8 characters."]}
    />\
    """
  end

  defp types_code do
    """
    <.input type="email" label="Email" placeholder="name@example.com" />
    <.input type="password" label="Password" placeholder="Enter password" />
    <.input type="number" label="Amount" placeholder="0" />
    <.input type="date" label="Date" />\
    """
  end

  defp checkbox_code do
    ~s|<.input type="checkbox" name="terms" label="Accept terms and conditions" />|
  end

  defp switch_code do
    """
    <.input
      type="switch"
      name="notifications"
      label="Enable notifications"
      description="Receive email notifications for updates."
    />\
    """
  end

  defp select_code do
    """
    <.input
      type="select"
      name="country"
      label="Country"
      description="Choose your country of residence."
      prompt="Select a country"
      options={[{"United States", "us"}, {"Canada", "ca"}, {"United Kingdom", "uk"}]}
    />\
    """
  end

  defp textarea_code do
    """
    <.input
      type="textarea"
      name="bio"
      label="Bio"
      description="Tell us about yourself."
      rows={4}
      placeholder="Write something..."
    />\
    """
  end

  defp disabled_code do
    ~s|<.input type="text" label="Disabled" placeholder="Cannot edit" disabled />|
  end

  defp form_code do
    """
    <.form for={@form} phx-change="validate" phx-submit="save">
      <.input field={@form[:email]} type="email" label="Email" />
      <.input field={@form[:password]} type="password" label="Password" />
      <.input
        field={@form[:bio]}
        type="textarea"
        label="Bio"
        description="Tell us about yourself."
      />
      <.button type="submit">Submit</.button>
    </.form>\
    """
  end

  defp complete_code do
    """
    <.form for={@form} phx-change="validate" phx-submit="save">
      <.input field={@form[:name]} type="text" label="Name" placeholder="Jane Smith" />
      <.input
        field={@form[:email]}
        type="email"
        label="Email"
        placeholder="jane@example.com"
      />
      <.input
        field={@form[:password]}
        type="password"
        label="Password"
        description="Must be at least 8 characters."
        placeholder="Create a password"
      />
      <.input
        field={@form[:terms]}
        type="checkbox"
        label="I agree to the terms of service"
      />
      <div class="pt-2">
        <.button type="submit">Register</.button>
      </div>
    </.form>\
    """
  end
end
