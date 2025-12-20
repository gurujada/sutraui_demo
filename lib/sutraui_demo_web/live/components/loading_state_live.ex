defmodule SutrauiDemoWeb.Components.LoadingStateLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Loading State")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/loading-state">
      <.docs_header
        title="Loading State"
        description="A centered loading indicator with spinner and message, commonly used while data is being fetched."
      />

      <.component_demo title="Default" code={default_code()}>
        <.loading_state />
      </.component_demo>

      <.section_heading id="custom-message">Custom Message</.section_heading>
      <.prose>
        Set a custom loading message with the
        <.inline_code>message</.inline_code>
        prop.
      </.prose>

      <.component_demo title="Custom Message" code={message_code()}>
        <.loading_state message="Fetching your data..." />
      </.component_demo>

      <.section_heading id="without-card">Without Card</.section_heading>
      <.prose>
        Use
        <.inline_code>wrap_card={false}</.inline_code>
        for an inline loading state without the card wrapper.
      </.prose>

      <.component_demo title="Without Card" code={no_card_code()}>
        <.loading_state wrap_card={false} />
      </.component_demo>

      <.section_heading id="spinner-sizes">Spinner Sizes</.section_heading>
      <.prose>
        Control the spinner size with the
        <.inline_code>spinner_size</.inline_code>
        prop. Options are <.inline_code>sm</.inline_code>, <.inline_code>default</.inline_code>, <.inline_code>lg</.inline_code>, and <.inline_code>xl</.inline_code>.
      </.prose>

      <.component_demo title="Spinner Sizes" code={sizes_code()}>
        <div class="flex flex-wrap gap-6">
          <.loading_state wrap_card={false} spinner_size="sm" message="Small" />
          <.loading_state wrap_card={false} spinner_size="default" message="Default" />
          <.loading_state wrap_card={false} spinner_size="lg" message="Large" />
          <.loading_state wrap_card={false} spinner_size="xl" message="Extra Large" />
        </div>
      </.component_demo>

      <.section_heading id="inline-usage">Inline Usage</.section_heading>
      <.prose>
        Combine props for compact inline loading indicators.
      </.prose>

      <.component_demo title="Inline Usage" code={inline_code()}>
        <div class="flex items-center gap-4">
          <span style="color: var(--fg-muted);">Saving changes</span>
          <.loading_state wrap_card={false} spinner_size="sm" message="" />
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.loading_state />\
    """
  end

  defp message_code do
    """
    <.loading_state message="Fetching your data..." />\
    """
  end

  defp no_card_code do
    """
    <.loading_state wrap_card={false} />\
    """
  end

  defp sizes_code do
    """
    <.loading_state wrap_card={false} spinner_size="sm" message="Small" />
    <.loading_state wrap_card={false} spinner_size="default" message="Default" />
    <.loading_state wrap_card={false} spinner_size="lg" message="Large" />
    <.loading_state wrap_card={false} spinner_size="xl" message="Extra Large" />\
    """
  end

  defp inline_code do
    """
    <div class="flex items-center gap-4">
      <span>Saving changes</span>
      <.loading_state wrap_card={false} spinner_size="sm" message="" />
    </div>\
    """
  end
end
