defmodule SutrauiDemoWeb.Components.CheckboxLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Checkbox")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/checkbox">
      <.docs_header
        title="Checkbox"
        description="A control that allows the user to toggle between checked and unchecked states."
      />

      <.component_demo title="Default" code={~s|<.checkbox name="terms" />|}>
        <.checkbox name="terms" />
      </.component_demo>

      <.section_heading id="with-label">With Label</.section_heading>
      <.prose>
        Combine with the
        <.inline_code>Field</.inline_code>
        component or a label element for better accessibility.
      </.prose>

      <.component_demo title="With Label" code={label_code()}>
        <div class="flex items-center gap-2">
          <.checkbox name="agree" id="agree-checkbox" />
          <label for="agree-checkbox" class="text-sm" style="color: var(--fg);">
            I agree to the terms and conditions
          </label>
        </div>
      </.component_demo>

      <.section_heading id="checked">Checked State</.section_heading>
      <.prose>
        Use the
        <.inline_code>checked</.inline_code>
        attribute to set the initial state.
      </.prose>

      <.component_demo title="Checked" code={~s|<.checkbox name="notifications" checked />|}>
        <div class="flex items-center gap-2">
          <.checkbox name="notifications" id="notifications-checkbox" checked />
          <label for="notifications-checkbox" class="text-sm" style="color: var(--fg);">
            Enable notifications
          </label>
        </div>
      </.component_demo>

      <.section_heading id="disabled">Disabled</.section_heading>
      <.prose>
        Use the disabled attribute to prevent interaction.
      </.prose>

      <.component_demo title="Disabled" code={disabled_code()}>
        <div class="space-y-3">
          <div class="flex items-center gap-2">
            <.checkbox name="disabled1" id="disabled-unchecked" disabled />
            <label for="disabled-unchecked" class="text-sm" style="color: var(--fg-muted);">
              Disabled unchecked
            </label>
          </div>
          <div class="flex items-center gap-2">
            <.checkbox name="disabled2" id="disabled-checked" checked disabled />
            <label for="disabled-checked" class="text-sm" style="color: var(--fg-muted);">
              Disabled checked
            </label>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="with-form">With Form</.section_heading>
      <.prose>
        Checkboxes integrate with Phoenix forms. The checkbox will submit
        <.inline_code>"true"</.inline_code>
        when checked.
      </.prose>

      <.code_block language="heex" code={form_code()} />
    </Layouts.docs>
    """
  end

  defp label_code do
    """
    <div class="flex items-center gap-2">
      <.checkbox name="agree" id="agree-checkbox" />
      <label for="agree-checkbox">
        I agree to the terms and conditions
      </label>
    </div>\
    """
  end

  defp disabled_code do
    """
    <.checkbox name="disabled1" disabled />
    <.checkbox name="disabled2" checked disabled />\
    """
  end

  defp form_code do
    """
    <.form for={@form} phx-submit="save">
      <div class="flex items-center gap-2">
        <.checkbox name={@form[:remember_me].name} id="remember-me" />
        <label for="remember-me">Remember me</label>
      </div>
      <.button type="submit">Login</.button>
    </.form>\
    """
  end
end
