defmodule SutrauiDemoWeb.Components.InputOTPLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Input OTP")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/input-otp">
      <.docs_header
        title="Input OTP"
        description="One-time password input with individual digit slots, paste support, and arrow-key navigation."
      />

      <.component_demo title="Default" code={default_code()}>
        <.input_otp id="demo-otp" name="code" value="123" length={6} />
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
        <.input_otp id="demo-pin" name="pin" value="42" length={4} mask placeholder="•" />
      </.component_demo>

      <.section_heading id="grouped">Grouped with Separator</.section_heading>
      <.prose>
        Use the
        <.inline_code>:group</.inline_code>
        and
        <.inline_code>:separator</.inline_code>
        slots with
        <.inline_code>input_otp_slot</.inline_code>
        to build custom groupings.
      </.prose>

      <.component_demo title="Grouped" code={grouped_code()}>
        <.input_otp id="demo-grouped" name="code" value="123" length={6}>
          <:group>
            <.input_otp_slot index={0} />
            <.input_otp_slot index={1} />
            <.input_otp_slot index={2} />
          </:group>
          <:separator>
            <div class="text-muted-foreground">&mdash;</div>
          </:separator>
          <:group>
            <.input_otp_slot index={3} />
            <.input_otp_slot index={4} />
            <.input_otp_slot index={5} />
          </:group>
        </.input_otp>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.input_otp id="demo-otp" name="code" value="123" length={6} />\
    """
  end

  defp pin_code do
    """
    <.input_otp id="demo-pin" name="pin" value="42" length={4} mask placeholder="•" />\
    """
  end

  defp grouped_code do
    """
    <.input_otp id="demo-grouped" name="code" value="123" length={6}>
      <:group>
        <.input_otp_slot index={0} />
        <.input_otp_slot index={1} />
        <.input_otp_slot index={2} />
      </:group>
      <:separator>
        <div class="text-muted-foreground">&mdash;</div>
      </:separator>
      <:group>
        <.input_otp_slot index={3} />
        <.input_otp_slot index={4} />
        <.input_otp_slot index={5} />
      </:group>
    </.input_otp>\
    """
  end
end
