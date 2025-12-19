defmodule SutrauiDemoWeb.Components.InputLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Input")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/input">
      <.docs_header
        title="Input"
        description="Form input field with optional label. Integrates with Phoenix forms."
      />

      <.component_demo title="Default" code={~s|<.input type="text" placeholder="Enter text..." />|}>
        <.input type="text" placeholder="Enter text..." />
      </.component_demo>

      <.section_heading id="with-label">With Label</.section_heading>
      <.prose>
        Add a label to the input for better accessibility and UX.
      </.prose>

      <.component_demo title="With Label" code={label_code()}>
        <.input type="email" label="Email" placeholder="name@example.com" />
      </.component_demo>

      <.section_heading id="types">Input Types</.section_heading>
      <.prose>
        The input component supports all standard HTML input types.
      </.prose>

      <.component_demo title="Types" code={types_code()}>
        <div class="space-y-4 w-full max-w-sm">
          <.input type="email" label="Email" placeholder="name@example.com" />
          <.input type="password" label="Password" placeholder="Enter password" />
          <.input type="number" label="Amount" placeholder="0" />
          <.input type="date" label="Date" />
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp label_code do
    ~s|<.input type="email" label="Email" placeholder="name@example.com" />|
  end

  defp types_code do
    """
    <.input type="email" label="Email" placeholder="name@example.com" />
    <.input type="password" label="Password" placeholder="Enter password" />
    <.input type="number" label="Amount" placeholder="0" />
    <.input type="date" label="Date" />\
    """
  end
end
