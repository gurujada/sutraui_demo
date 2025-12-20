defmodule SutrauiDemoWeb.Components.RadioGroupLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Radio Group")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/radio-group">
      <.docs_header
        title="Radio Group"
        description="A set of checkable buttons where only one can be checked at a time."
      />

      <.component_demo title="Default" code={default_code()}>
        <.radio_group name="plan" label="Select a plan">
          <:radio value="free" label="Free" checked />
          <:radio value="pro" label="Pro" />
          <:radio value="enterprise" label="Enterprise" />
        </.radio_group>
      </.component_demo>

      <.section_heading id="horizontal">Horizontal Layout</.section_heading>
      <.prose>
        Radio groups are vertical by default. You can style them horizontally with CSS.
      </.prose>

      <.component_demo title="Horizontal" code={horizontal_code()}>
        <.radio_group name="size" label="Size" class="flex flex-row gap-4">
          <:radio value="sm" label="Small" />
          <:radio value="md" label="Medium" checked />
          <:radio value="lg" label="Large" />
        </.radio_group>
      </.component_demo>

      <.section_heading id="with-errors">With Errors</.section_heading>
      <.prose>
        Pass an
        <.inline_code>errors</.inline_code>
        list to display validation messages.
      </.prose>

      <.component_demo title="With Errors" code={errors_code()}>
        <.radio_group name="priority" label="Priority" errors={["Please select a priority"]}>
          <:radio value="low" label="Low" />
          <:radio value="medium" label="Medium" />
          <:radio value="high" label="High" />
        </.radio_group>
      </.component_demo>

      <.section_heading id="disabled">Disabled</.section_heading>
      <.prose>
        Disable the entire group or individual options.
      </.prose>

      <.component_demo title="Disabled Group" code={disabled_code()}>
        <.radio_group name="disabled_plan" label="Disabled group" disabled>
          <:radio value="a" label="Option A" checked />
          <:radio value="b" label="Option B" />
        </.radio_group>
      </.component_demo>

      <.component_demo title="Disabled Option" code={disabled_option_code()}>
        <.radio_group name="availability" label="Availability">
          <:radio value="available" label="Available" checked />
          <:radio value="limited" label="Limited" />
          <:radio value="sold_out" label="Sold Out" disabled />
        </.radio_group>
      </.component_demo>

      <.section_heading id="standalone">Standalone Radio</.section_heading>
      <.prose>
        Use
        <.inline_code>&lt;.radio&gt;</.inline_code>
        directly for custom layouts.
      </.prose>

      <.component_demo title="Standalone" code={standalone_code()}>
        <div class="space-y-2">
          <.radio name="standalone" value="yes" label="Yes" id="standalone-yes" checked />
          <.radio name="standalone" value="no" label="No" id="standalone-no" />
        </div>
      </.component_demo>

      <.section_heading id="with-form">With Form</.section_heading>
      <.prose>
        Radio groups integrate with Phoenix forms seamlessly.
      </.prose>

      <.code_block language="heex" code={form_code()} />
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.radio_group name="plan" label="Select a plan">
      <:radio value="free" label="Free" checked />
      <:radio value="pro" label="Pro" />
      <:radio value="enterprise" label="Enterprise" />
    </.radio_group>\
    """
  end

  defp horizontal_code do
    """
    <.radio_group name="size" label="Size" class="flex flex-row gap-4">
      <:radio value="sm" label="Small" />
      <:radio value="md" label="Medium" checked />
      <:radio value="lg" label="Large" />
    </.radio_group>\
    """
  end

  defp errors_code do
    """
    <.radio_group name="priority" label="Priority" errors={["Please select a priority"]}>
      <:radio value="low" label="Low" />
      <:radio value="medium" label="Medium" />
      <:radio value="high" label="High" />
    </.radio_group>\
    """
  end

  defp disabled_code do
    """
    <.radio_group name="disabled_plan" label="Disabled group" disabled>
      <:radio value="a" label="Option A" checked />
      <:radio value="b" label="Option B" />
    </.radio_group>\
    """
  end

  defp disabled_option_code do
    """
    <.radio_group name="availability" label="Availability">
      <:radio value="available" label="Available" checked />
      <:radio value="limited" label="Limited" />
      <:radio value="sold_out" label="Sold Out" disabled />
    </.radio_group>\
    """
  end

  defp standalone_code do
    """
    <.radio name="standalone" value="yes" label="Yes" id="standalone-yes" checked />
    <.radio name="standalone" value="no" label="No" id="standalone-no" />\
    """
  end

  defp form_code do
    """
    <.form for={@form} phx-submit="save">
      <.radio_group name={@form[:plan].name} label="Select a plan">
        <:radio value="free" label="Free" />
        <:radio value="pro" label="Pro" />
        <:radio value="enterprise" label="Enterprise" />
      </.radio_group>
      <.button type="submit">Continue</.button>
    </.form>\
    """
  end
end
