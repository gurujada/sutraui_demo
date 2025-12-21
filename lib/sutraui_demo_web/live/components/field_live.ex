defmodule SutrauiDemoWeb.Components.FieldLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Field")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/field">
      <.docs_header
        title="Field"
        description="A wrapper component that provides structure for form fields with labels, descriptions, and error messages."
      />

      <.component_demo title="Default" code={default_code()}>
        <div class="w-full max-w-sm">
          <.field>
            <:label>Email</:label>
            <:input>
              <.input type="email" placeholder="name@example.com" />
            </:input>
          </.field>
        </div>
      </.component_demo>

      <.section_heading id="with-description">With Description</.section_heading>
      <.prose>
        Add helper text below the input using the
        <.inline_code>description</.inline_code>
        slot.
      </.prose>

      <.component_demo title="With Description" code={description_code()}>
        <div class="w-full max-w-sm">
          <.field>
            <:label>Username</:label>
            <:input>
              <.input type="text" placeholder="johndoe" />
            </:input>
            <:description>This will be your public display name.</:description>
          </.field>
        </div>
      </.component_demo>

      <%!--
      TODO: Re-enable once Sutra UI Field supports automatic error extraction from form fields.
      See ISSUES.md in sutra_ui repo.

      <.section_heading id="with-error">With Error</.section_heading>
      <.prose>
        Display validation errors using the
        <.inline_code>error</.inline_code>
        slot and
        <.inline_code>invalid</.inline_code>
        attribute.
      </.prose>

      <.component_demo title="With Error" code={error_code()}>
        <div class="w-full max-w-sm">
          <.field invalid>
            <:label>Password</:label>
            <:input>
              <.input type="password" placeholder="Enter password" />
            </:input>
            <:error>Password must be at least 8 characters.</:error>
          </.field>
        </div>
      </.component_demo>
      --%>

      <.section_heading id="horizontal">Horizontal Layout</.section_heading>
      <.prose>
        Use
        <.inline_code>orientation="horizontal"</.inline_code>
        for side-by-side label and input layout.
      </.prose>

      <.component_demo title="Horizontal" code={horizontal_code()}>
        <div class="w-full max-w-md">
          <.field orientation="horizontal">
            <:label>Full Name</:label>
            <:input>
              <.input type="text" placeholder="John Doe" />
            </:input>
          </.field>
        </div>
      </.component_demo>

      <.section_heading id="with-checkbox">With Checkbox</.section_heading>
      <.prose>
        Field works with any input type, including checkboxes.
      </.prose>

      <.component_demo title="With Checkbox" code={checkbox_code()}>
        <.field orientation="horizontal" class="flex-row-reverse justify-end gap-2">
          <:label for="terms-checkbox">Accept terms and conditions</:label>
          <:input>
            <.checkbox name="terms" id="terms-checkbox" />
          </:input>
        </.field>
      </.component_demo>

      <.section_heading id="fieldset">Fieldset</.section_heading>
      <.prose>
        Use
        <.inline_code>&lt;.fieldset&gt;</.inline_code>
        to group related fields with a legend.
      </.prose>

      <.component_demo title="Fieldset" code={fieldset_code()}>
        <.fieldset>
          <:legend>Personal Information</:legend>
          <:fields>
            <.field>
              <:label>First Name</:label>
              <:input>
                <.input type="text" placeholder="John" />
              </:input>
            </.field>
            <.field>
              <:label>Last Name</:label>
              <:input>
                <.input type="text" placeholder="Doe" />
              </:input>
            </.field>
          </:fields>
        </.fieldset>
      </.component_demo>

      <.section_heading id="section">Section Slot</.section_heading>
      <.prose>
        Use the
        <.inline_code>section</.inline_code>
        slot to add content between the label and input.
      </.prose>

      <.component_demo title="With Section" code={section_code()}>
        <div class="w-full max-w-sm">
          <.field>
            <:label>Avatar</:label>
            <:section>
              <div
                class="w-16 h-16 rounded-full flex items-center justify-center text-lg font-medium mb-2"
                style="background: var(--bg-muted); color: var(--fg-muted);"
              >
                JD
              </div>
            </:section>
            <:input>
              <.input type="file" />
            </:input>
            <:description>Upload a profile picture.</:description>
          </.field>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.field>
      <:label>Email</:label>
      <:input>
        <.input type="email" placeholder="name@example.com" />
      </:input>
    </.field>\
    """
  end

  defp description_code do
    """
    <.field>
      <:label>Username</:label>
      <:input>
        <.input type="text" placeholder="johndoe" />
      </:input>
      <:description>This will be your public display name.</:description>
    </.field>\
    """
  end

  # TODO: Re-enable once Sutra UI Field supports automatic error extraction from form fields.
  # See ISSUES.md in sutra_ui repo.
  # defp error_code do
  #   """
  #   <.field invalid>
  #     <:label>Password</:label>
  #     <:input>
  #       <.input type="password" placeholder="Enter password" />
  #     </:input>
  #     <:error>Password must be at least 8 characters.</:error>
  #   </.field>\
  #   """
  # end

  defp horizontal_code do
    """
    <.field orientation="horizontal">
      <:label>Full Name</:label>
      <:input>
        <.input type="text" placeholder="John Doe" />
      </:input>
    </.field>\
    """
  end

  defp checkbox_code do
    """
    <.field orientation="horizontal" class="flex-row-reverse justify-end gap-2">
      <:label for="terms-checkbox">Accept terms and conditions</:label>
      <:input>
        <.checkbox name="terms" id="terms-checkbox" />
      </:input>
    </.field>\
    """
  end

  defp fieldset_code do
    """
    <.fieldset>
      <:legend>Personal Information</:legend>
      <:fields>
        <.field>
          <:label>First Name</:label>
          <:input><.input type="text" placeholder="John" /></:input>
        </.field>
        <.field>
          <:label>Last Name</:label>
          <:input><.input type="text" placeholder="Doe" /></:input>
        </.field>
      </:fields>
    </.fieldset>\
    """
  end

  defp section_code do
    """
    <.field>
      <:label>Avatar</:label>
      <:section>
        <div class="w-16 h-16 rounded-full bg-muted">JD</div>
      </:section>
      <:input>
        <.input type="file" />
      </:input>
      <:description>Upload a profile picture.</:description>
    </.field>\
    """
  end
end
