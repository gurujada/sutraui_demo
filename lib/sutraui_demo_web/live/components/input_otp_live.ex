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
        description="One-time password fields with paste handling and a Phoenix-friendly hidden value."
      />

      <.component_demo title="Default" code={default_code()}>
        <.input_otp id="demo-otp" name="code" groups={[3, 3]} />
      </.component_demo>

      <.section_heading id="four-digits">Four Digits</.section_heading>
      <.component_demo title="PIN" code={pin_code()}>
        <.input_otp id="demo-pin" name="pin" length={4} placeholder="0" />
      </.component_demo>

      <.section_heading id="invalid">Invalid</.section_heading>
      <.component_demo title="Invalid State" code={invalid_code()}>
        <.input_otp id="demo-invalid-otp" name="invalid_code" value="000000" groups={[3, 3]} invalid />
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.input_otp id="mfa-code" name="code" groups={[3, 3]} />\
    """
  end

  defp pin_code do
    """
    <.input_otp id="pin" name="pin" length={4} placeholder="0" />\
    """
  end

  defp invalid_code do
    """
    <.input_otp id="invalid-code" name="code" value="000000" groups={[3, 3]} invalid />\
    """
  end
end
