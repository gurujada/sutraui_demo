defmodule SutrauiDemoWeb.Components.SwitchLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Switch", airplane_mode: false)}
  end

  def handle_event("toggle_airplane", _params, socket) do
    {:noreply, assign(socket, airplane_mode: !socket.assigns.airplane_mode)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/switch">
      <.docs_header
        title="Switch"
        description="A toggle control that allows the user to switch between on and off states."
      />

      <.component_demo title="Default" code={~s|<.switch name="setting" />|}>
        <.switch name="setting" />
      </.component_demo>

      <.section_heading id="with-label">With Label</.section_heading>
      <.prose>
        Add a label alongside the switch for context.
      </.prose>

      <.component_demo title="With Label" code={label_code()}>
        <div class="flex items-center justify-between w-full max-w-xs">
          <label for="notifications-switch" class="text-sm font-medium" style="color: var(--fg);">
            Enable notifications
          </label>
          <.switch name="notifications" id="notifications-switch" />
        </div>
      </.component_demo>

      <.section_heading id="checked">Checked State</.section_heading>
      <.prose>
        Use the
        <.inline_code>checked</.inline_code>
        attribute to set the initial state.
      </.prose>

      <.component_demo title="Checked" code={~s|<.switch name="feature" checked />|}>
        <div class="flex items-center justify-between w-full max-w-xs">
          <label for="feature-switch" class="text-sm font-medium" style="color: var(--fg);">
            Dark mode
          </label>
          <.switch name="feature" id="feature-switch" checked />
        </div>
      </.component_demo>

      <.section_heading id="interactive">Interactive Example</.section_heading>
      <.prose>
        Use
        <.inline_code>phx-click</.inline_code>
        to handle toggle events.
      </.prose>

      <.component_demo title="Interactive" code={interactive_code()}>
        <div class="flex items-center justify-between w-full max-w-xs">
          <div>
            <label for="airplane-switch" class="text-sm font-medium block" style="color: var(--fg);">
              Airplane Mode
            </label>
            <span class="text-xs" style="color: var(--fg-muted);">
              {if @airplane_mode, do: "Enabled", else: "Disabled"}
            </span>
          </div>
          <.switch
            name="airplane"
            id="airplane-switch"
            checked={@airplane_mode}
            phx-click="toggle_airplane"
          />
        </div>
      </.component_demo>

      <.section_heading id="disabled">Disabled</.section_heading>
      <.prose>
        Use the disabled attribute to prevent interaction.
      </.prose>

      <.component_demo title="Disabled" code={disabled_code()}>
        <div class="space-y-4">
          <div class="flex items-center justify-between w-full max-w-xs">
            <label class="text-sm" style="color: var(--fg-muted);">Disabled off</label>
            <.switch name="disabled1" disabled />
          </div>
          <div class="flex items-center justify-between w-full max-w-xs">
            <label class="text-sm" style="color: var(--fg-muted);">Disabled on</label>
            <.switch name="disabled2" checked disabled />
          </div>
        </div>
      </.component_demo>

      <.section_heading id="accessibility">Accessibility</.section_heading>
      <.prose>
        The switch uses
        <.inline_code>role="switch"</.inline_code>
        and
        <.inline_code>aria-checked</.inline_code>
        for proper screen reader support.
      </.prose>
    </Layouts.docs>
    """
  end

  defp label_code do
    """
    <div class="flex items-center justify-between">
      <label for="notifications-switch">Enable notifications</label>
      <.switch name="notifications" id="notifications-switch" />
    </div>\
    """
  end

  defp interactive_code do
    """
    <.switch
      name="airplane"
      id="airplane-switch"
      checked={@airplane_mode}
      phx-click="toggle_airplane"
    />\
    """
  end

  defp disabled_code do
    """
    <.switch name="disabled1" disabled />
    <.switch name="disabled2" checked disabled />\
    """
  end
end
