defmodule SutrauiDemoWeb.Components.InputGroupLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Input Group")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/input-group">
      <.docs_header
        title="Input Group"
        description="Display additional information or actions attached to an input or textarea using prefix, suffix, and footer slots."
      />

      <.section_heading id="icon-prefix">Icon Prefix</.section_heading>
      <.prose>
        Add an icon before the input with the
        <.inline_code>:prefix</.inline_code>
        slot and <.inline_code>type="icon"</.inline_code>.
        Remember to add
        <.inline_code>pl-9</.inline_code>
        padding to the input.
      </.prose>

      <.component_demo title="Icon Prefix" code={icon_prefix_code()}>
        <.input_group>
          <:prefix type="icon">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
            >
              <circle cx="11" cy="11" r="8" /><path d="m21 21-4.3-4.3" />
            </svg>
          </:prefix>
          <input type="text" class="input pl-9" placeholder="Search..." />
        </.input_group>
      </.component_demo>

      <.section_heading id="text-prefix-suffix">Text Prefix & Suffix</.section_heading>
      <.prose>
        Add text labels on either side of the input. Adjust padding based on text length.
      </.prose>

      <.component_demo title="Currency Input" code={currency_code()}>
        <.input_group class="max-w-xs">
          <:prefix>$</:prefix>
          <:suffix>USD</:suffix>
          <input type="text" class="input pl-7 pr-12" placeholder="0.00" />
        </.input_group>
      </.component_demo>

      <.section_heading id="icon-suffix">Icon Suffix</.section_heading>
      <.prose>
        Icons work on the suffix side too.
      </.prose>

      <.component_demo title="Email Input" code={email_code()}>
        <.input_group class="max-w-md">
          <:suffix type="icon">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
            >
              <rect width="20" height="16" x="2" y="4" rx="2" />
              <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7" />
            </svg>
          </:suffix>
          <input type="email" class="input pr-9" placeholder="Enter email" />
        </.input_group>
      </.component_demo>

      <.section_heading id="interactive-suffix">Interactive Button</.section_heading>
      <.prose>
        Use
        <.inline_code>type="interactive"</.inline_code>
        for clickable buttons that need pointer events enabled.
      </.prose>

      <.component_demo title="Copy Button" code={interactive_code()}>
        <.input_group class="max-w-md">
          <:suffix type="interactive">
            <button
              type="button"
              class="btn-icon-ghost size-6"
              aria-label="Copy to clipboard"
              phx-click="copy"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="14"
                height="14"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <rect width="8" height="4" x="8" y="2" rx="1" ry="1" />
                <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2" />
              </svg>
            </button>
          </:suffix>
          <input type="text" class="input pr-9" value="https://example.com/share/abc123" readonly />
        </.input_group>
      </.component_demo>

      <.section_heading id="textarea-footer">Textarea with Footer</.section_heading>
      <.prose>
        Add a footer below textareas for actions or character counts.
      </.prose>

      <.component_demo title="With Footer" code={footer_code()}>
        <.input_group class="max-w-md">
          <textarea class="textarea min-h-27 pb-12" placeholder="Enter message..."></textarea>
          <:footer>
            <button type="button" class="btn-icon-outline rounded-full size-6">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="14"
                height="14"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="m21.44 11.05-9.19 9.19a6 6 0 0 1-8.49-8.49l8.57-8.57A4 4 0 1 1 18 8.84l-8.59 8.57a2 2 0 0 1-2.83-2.83l8.49-8.48" />
              </svg>
            </button>
            <div class="text-muted-foreground text-sm ml-auto">0/500</div>
          </:footer>
        </.input_group>
      </.component_demo>

      <.section_heading id="horizontal-layout">Horizontal Layout</.section_heading>
      <.prose>
        Use
        <.inline_code>.input_group_horizontal</.inline_code>
        for external prefix/suffix labels.
      </.prose>

      <.component_demo title="URL Input" code={horizontal_code()}>
        <.input_group_horizontal class="max-w-md">
          <:prefix_label>https://</:prefix_label>
          <:suffix_label>.com</:suffix_label>
          <input type="text" class="input rounded-none" placeholder="example" />
        </.input_group_horizontal>
      </.component_demo>

      <.section_heading id="padding-guidelines">Padding Guidelines</.section_heading>
      <.callout>
        <strong>Remember:</strong>
        You need to manually add padding to inputs to make room for prefix/suffix content.
        <.list>
          <.list_item>
            Icon prefix:
            <.inline_code>pl-9</.inline_code>
          </.list_item>
          <.list_item>
            Icon suffix:
            <.inline_code>pr-9</.inline_code>
          </.list_item>
          <.list_item>
            Short text prefix:
            <.inline_code>pl-7</.inline_code>
          </.list_item>
          <.list_item>
            Short text suffix:
            <.inline_code>pr-12</.inline_code>
          </.list_item>
          <.list_item>
            Textarea footer:
            <.inline_code>pb-12</.inline_code>
          </.list_item>
        </.list>
      </.callout>
    </Layouts.docs>
    """
  end

  defp icon_prefix_code do
    """
    <.input_group>
      <:prefix type="icon">
        <svg><!-- search icon --></svg>
      </:prefix>
      <input type="text" class="input pl-9" placeholder="Search..." />
    </.input_group>\
    """
  end

  defp currency_code do
    """
    <.input_group>
      <:prefix>$</:prefix>
      <:suffix>USD</:suffix>
      <input type="text" class="input pl-7 pr-12" placeholder="0.00" />
    </.input_group>\
    """
  end

  defp email_code do
    """
    <.input_group>
      <:suffix type="icon">
        <svg><!-- mail icon --></svg>
      </:suffix>
      <input type="email" class="input pr-9" placeholder="Enter email" />
    </.input_group>\
    """
  end

  defp interactive_code do
    """
    <.input_group>
      <:suffix type="interactive">
        <button type="button" class="btn-icon-ghost size-6">
          <svg><!-- copy icon --></svg>
        </button>
      </:suffix>
      <input type="text" class="input pr-9" value="https://..." readonly />
    </.input_group>\
    """
  end

  defp footer_code do
    """
    <.input_group>
      <textarea class="textarea min-h-27 pb-12" placeholder="..."></textarea>
      <:footer>
        <button type="button" class="btn-icon-outline rounded-full size-6">
          <svg><!-- attach icon --></svg>
        </button>
        <div class="text-muted-foreground text-sm ml-auto">0/500</div>
      </:footer>
    </.input_group>\
    """
  end

  defp horizontal_code do
    """
    <.input_group_horizontal>
      <:prefix_label>https://</:prefix_label>
      <:suffix_label>.com</:suffix_label>
      <input type="text" class="input rounded-none" placeholder="example" />
    </.input_group_horizontal>\
    """
  end
end
