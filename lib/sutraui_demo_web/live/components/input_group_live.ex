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
            <.icon name="lucide-search" class="size-4" />
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
            <.icon name="lucide-mail" class="size-4" />
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
              <.icon name="lucide-copy" class="size-3.5" />
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
              <.icon name="lucide-paperclip" class="size-3.5" />
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
        <.icon name="lucide-search" class="size-4" />
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
        <.icon name="lucide-mail" class="size-4" />
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
          <.icon name="lucide-copy" class="size-3.5" />
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
          <.icon name="lucide-paperclip" class="size-3.5" />
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
