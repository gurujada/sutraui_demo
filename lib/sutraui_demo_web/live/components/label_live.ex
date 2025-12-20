defmodule SutrauiDemoWeb.Components.LabelLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Label")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/label">
      <.docs_header
        title="Label"
        description="Renders an accessible label associated with form controls."
      />

      <.component_demo title="Default" code={~s|<.label for="email">Email</.label>|}>
        <.label for="email">Email</.label>
      </.component_demo>

      <.section_heading id="with-input">With Input</.section_heading>
      <.prose>
        The
        <.inline_code>for</.inline_code>
        attribute links the label to an input by its <.inline_code>id</.inline_code>.
        Clicking the label will focus the associated input.
      </.prose>

      <.component_demo title="With Input" code={with_input_code()}>
        <div class="space-y-2">
          <.label for="username">Username</.label>
          <.input type="text" id="username" name="username" placeholder="Enter your username" />
        </div>
      </.component_demo>

      <.section_heading id="with-textarea">With Textarea</.section_heading>
      <.prose>
        Labels work with any form control.
      </.prose>

      <.component_demo title="With Textarea" code={with_textarea_code()}>
        <div class="space-y-2">
          <.label for="message">Message</.label>
          <.textarea id="message" name="message" placeholder="Type your message here..." />
        </div>
      </.component_demo>

      <.section_heading id="with-checkbox">With Checkbox</.section_heading>
      <.prose>
        For checkboxes, place the label after the input and use inline layout.
      </.prose>

      <.component_demo title="With Checkbox" code={with_checkbox_code()}>
        <div class="flex items-center gap-2">
          <.checkbox id="terms" name="terms" />
          <.label for="terms">Accept terms and conditions</.label>
        </div>
      </.component_demo>

      <.section_heading id="required">Required Field</.section_heading>
      <.prose>
        Add a visual indicator for required fields.
      </.prose>

      <.component_demo title="Required" code={required_code()}>
        <div class="space-y-2">
          <.label for="email-required">
            Email <span style="color: var(--destructive);">*</span>
          </.label>
          <.input type="email" id="email-required" name="email" required />
        </div>
      </.component_demo>

      <.section_heading id="with-hint">With Hint Text</.section_heading>
      <.prose>
        Combine labels with hint text for additional context.
      </.prose>

      <.component_demo title="With Hint" code={with_hint_code()}>
        <div class="space-y-2">
          <.label for="password">Password</.label>
          <.input type="password" id="password" name="password" />
          <p class="text-sm" style="color: var(--fg-muted);">
            Must be at least 8 characters long.
          </p>
        </div>
      </.component_demo>

      <.section_heading id="disabled">Disabled State</.section_heading>
      <.prose>
        Style labels for disabled inputs differently.
      </.prose>

      <.component_demo title="Disabled" code={disabled_code()}>
        <div class="space-y-2">
          <.label for="disabled-input" class="opacity-50">Disabled field</.label>
          <.input type="text" id="disabled-input" name="disabled" disabled value="Cannot edit" />
        </div>
      </.component_demo>

      <.section_heading id="form-example">Form Example</.section_heading>
      <.prose>
        A complete form example using labels.
      </.prose>

      <.component_demo title="Form" code={form_code()}>
        <form class="space-y-4">
          <div class="space-y-2">
            <.label for="form-name">
              Full name <span style="color: var(--destructive);">*</span>
            </.label>
            <.input type="text" id="form-name" name="name" required />
          </div>
          <div class="space-y-2">
            <.label for="form-email">
              Email <span style="color: var(--destructive);">*</span>
            </.label>
            <.input type="email" id="form-email" name="email" required />
          </div>
          <div class="space-y-2">
            <.label for="form-bio">Bio</.label>
            <.textarea id="form-bio" name="bio" placeholder="Tell us about yourself..." />
          </div>
          <div class="flex items-center gap-2">
            <.checkbox id="form-newsletter" name="newsletter" />
            <.label for="form-newsletter">Subscribe to newsletter</.label>
          </div>
        </form>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp with_input_code do
    """
    <div class="space-y-2">
      <.label for="username">Username</.label>
      <.input type="text" id="username" name="username" />
    </div>\
    """
  end

  defp with_textarea_code do
    """
    <div class="space-y-2">
      <.label for="message">Message</.label>
      <.textarea id="message" name="message" />
    </div>\
    """
  end

  defp with_checkbox_code do
    """
    <div class="flex items-center gap-2">
      <.checkbox id="terms" name="terms" />
      <.label for="terms">Accept terms and conditions</.label>
    </div>\
    """
  end

  defp required_code do
    """
    <div class="space-y-2">
      <.label for="email">
        Email <span class="text-destructive">*</span>
      </.label>
      <.input type="email" id="email" name="email" required />
    </div>\
    """
  end

  defp with_hint_code do
    """
    <div class="space-y-2">
      <.label for="password">Password</.label>
      <.input type="password" id="password" name="password" />
      <p class="text-sm text-muted">Must be at least 8 characters.</p>
    </div>\
    """
  end

  defp disabled_code do
    """
    <div class="space-y-2">
      <.label for="disabled" class="opacity-50">Disabled field</.label>
      <.input type="text" id="disabled" name="disabled" disabled />
    </div>\
    """
  end

  defp form_code do
    """
    <form class="space-y-4">
      <div class="space-y-2">
        <.label for="name">Full name</.label>
        <.input type="text" id="name" name="name" />
      </div>
      <div class="space-y-2">
        <.label for="email">Email</.label>
        <.input type="email" id="email" name="email" />
      </div>
      <div class="flex items-center gap-2">
        <.checkbox id="newsletter" name="newsletter" />
        <.label for="newsletter">Subscribe</.label>
      </div>
    </form>\
    """
  end
end
