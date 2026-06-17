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

      <.component_demo
        title="Default"
        code={~s|<.input_otp id="demo-otp" name="code" value="123" length={6} />|}
      >
        <.input_otp id="demo-otp" name="code" value="123" length={6} />
      </.component_demo>

      <.component_demo
        title="Four-digit PIN"
        code={~s|<.input_otp id="demo-pin" name="pin" value="42" length={4} mask placeholder="•" />|}
      >
        <.input_otp id="demo-pin" name="pin" value="42" length={4} mask placeholder="•" />
      </.component_demo>

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
