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
        <div class="w-full max-w-sm">
          <.input type="text" placeholder="Enter text..." />
        </div>
      </.component_demo>

      <.section_heading id="with-label">With Label</.section_heading>
      <.prose>
        Add a label to the input for better accessibility and UX.
      </.prose>

      <.component_demo title="With Label" code={label_code()}>
        <div class="w-full max-w-sm">
          <.input type="email" label="Email" placeholder="name@example.com" />
        </div>
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
        attribute.
      </.prose>

      <.code_block language="heex" code={form_code()} />
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

  defp disabled_code do
    ~s|<.input type="text" label="Disabled" placeholder="Cannot edit" disabled />|
  end

  defp form_code do
    """
    <.simple_form for={@form} phx-submit="save">
      <.input field={@form[:email]} type="email" label="Email" />
      <.input field={@form[:password]} type="password" label="Password" />
      <:actions>
        <.button type="submit">Submit</.button>
      </:actions>
    </.simple_form>\
    """
  end
end
