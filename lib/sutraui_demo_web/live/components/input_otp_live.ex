defmodule SutrauiDemoWeb.Components.InputOTPLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Input OTP", completed_code: nil)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/input-otp">
      <.docs_header
        title="Input OTP"
        description="One-time password input with individual digit slots, paste support, and arrow-key navigation."
      />

      <.component_demo title="Six-digit Code" code={default_code()}>
        <.input_otp id="demo-otp" name="code" length={6} />
      </.component_demo>

      <.section_heading id="masked-pin">Masked PIN</.section_heading>
      <.prose>
        Set
        <.inline_code>mask</.inline_code>
        to render password-style slots, and use a shorter
        <.inline_code>length</.inline_code>
        for PIN entry.
      </.prose>

      <.component_demo title="Four-digit PIN" code={pin_code()}>
        <.input_otp id="demo-pin" name="pin" length={4} mask placeholder="•" />
      </.component_demo>

      <.section_heading id="grouped">Grouped With Separator</.section_heading>
      <.prose>
        Use the
        <.inline_code>:group</.inline_code>
        and
        <.inline_code>:separator</.inline_code>
        slots with
        <.inline_code>input_otp_slot</.inline_code>
        to build custom groupings. Slots inherit <.inline_code>mask</.inline_code>, <.inline_code>placeholder</.inline_code>,
        and
        <.inline_code>invalid</.inline_code>
        from the parent — no need to repeat them on each slot.
      </.prose>

      <.component_demo title="Grouped" code={grouped_code()}>
        <.input_otp id="demo-grouped" name="code" length={6} value="123">
          <:group>
            <.input_otp_slot index={0} />
            <.input_otp_slot index={1} />
            <.input_otp_slot index={2} />
          </:group>
          <:separator>—</:separator>
          <:group>
            <.input_otp_slot index={3} />
            <.input_otp_slot index={4} />
            <.input_otp_slot index={5} />
          </:group>
        </.input_otp>
      </.component_demo>

      <.section_heading id="auto-verify">Auto-Verify On Complete</.section_heading>
      <.prose>
        Pass an
        <.inline_code>on_complete</.inline_code>
        event name to fire a LiveView event the moment all slots are filled —
        perfect for auto-submitting verification codes.
      </.prose>

      <.component_demo title="Auto-Verify" code={auto_verify_code()}>
        <.input_otp id="demo-auto" name="code" length={6} on_complete="verify_code" />
        <p :if={@completed_code} class="mt-4 text-sm text-muted-foreground">
          Auto-verified code: <strong class="text-foreground">{@completed_code}</strong>
        </p>
      </.component_demo>

      <.section_heading id="invalid">Invalid State</.section_heading>
      <.prose>
        Pass
        <.inline_code>invalid={true}</.inline_code>
        to mark all slots with
        <.inline_code>aria-invalid</.inline_code>
        and apply the destructive border/ring styling — use this when a code
        fails verification.
      </.prose>

      <.component_demo title="Invalid" code={invalid_code()}>
        <.input_otp id="demo-invalid" name="code" length={6} value="000000" invalid />
      </.component_demo>
    </Layouts.docs>
    """
  end

  def handle_event("verify_code", %{"value" => value}, socket) do
    {:noreply, assign(socket, completed_code: value)}
  end

  defp default_code do
    """
    <.input_otp id="verify" name="code" length={6} />\
    """
  end

  defp pin_code do
    """
    <.input_otp id="pin" name="pin" length={4} mask placeholder="•" />\
    """
  end

  defp grouped_code do
    """
    <.input_otp id="verify" name="code" length={6}>
      <:group>
        <.input_otp_slot index={0} />
        <.input_otp_slot index={1} />
        <.input_otp_slot index={2} />
      </:group>
      <:separator>—</:separator>
      <:group>
        <.input_otp_slot index={3} />
        <.input_otp_slot index={4} />
        <.input_otp_slot index={5} />
      </:group>
    </.input_otp>\
    """
  end

  defp auto_verify_code do
    """
    <.input_otp id="verify" name="code" length={6} on_complete="verify_code" />\
    """
  end

  defp invalid_code do
    """
    <.input_otp id="verify" name="code" length={6} value="000000" invalid />\
    """
  end
end
