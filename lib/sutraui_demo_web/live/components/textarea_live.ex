defmodule SutrauiDemoWeb.Components.TextareaLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Textarea")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/textarea">
      <.docs_header
        title="Textarea"
        description="A multi-line text input for longer form content."
      />

      <.component_demo title="Default" code={~s|<.textarea placeholder="Enter your message..." />|}>
        <div class="w-full max-w-sm">
          <.textarea placeholder="Enter your message..." />
        </div>
      </.component_demo>

      <%!-- TODO: Uncomment after fixing rows CSS issue in Sutra UI (see ISSUES.md)
      <.section_heading id="with-rows">Custom Rows</.section_heading>
      <.prose>
        Control the initial height with the
        <.inline_code>rows</.inline_code>
        attribute.
      </.prose>

      <.component_demo title="Custom Rows" code={rows_code()}>
        <div class="grid grid-cols-2 gap-4 w-full">
          <div>
            <label class="text-sm font-medium mb-1.5 block" style="color: var(--fg);">
              2 rows
            </label>
            <.textarea placeholder="Short textarea" rows={2} />
          </div>
          <div>
            <label class="text-sm font-medium mb-1.5 block" style="color: var(--fg);">
              5 rows
            </label>
            <.textarea placeholder="Taller textarea" rows={5} />
          </div>
        </div>
      </.component_demo>
      --%>

      <.section_heading id="disabled">Disabled</.section_heading>
      <.prose>
        Use the disabled attribute to prevent interaction.
      </.prose>

      <.component_demo title="Disabled" code={~s|<.textarea placeholder="Cannot edit..." disabled />|}>
        <div class="w-full max-w-sm">
          <.textarea placeholder="Cannot edit..." disabled />
        </div>
      </.component_demo>

      <.section_heading id="with-form">With Form</.section_heading>
      <.prose>
        The textarea integrates with Phoenix forms using the
        <.inline_code>field</.inline_code>
        attribute.
      </.prose>

      <.code_block language="heex" code={form_code()} />
    </Layouts.docs>
    """
  end

  # TODO: Uncomment after fixing rows CSS issue in Sutra UI (see ISSUES.md)
  # defp rows_code do
  #   """
  #   <.textarea placeholder="2 rows" rows={2} />
  #   <.textarea placeholder="5 rows" rows={5} />\
  #   """
  # end

  defp form_code do
    """
    <.form for={@form} phx-submit="save">
      <.textarea field={@form[:bio]} placeholder="Tell us about yourself..." rows={4} />
      <.button type="submit">Save</.button>
    </.form>\
    """
  end
end
