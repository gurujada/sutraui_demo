defmodule SutrauiDemoWeb.Components.BreadcrumbLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Breadcrumb")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/breadcrumb">
      <.docs_header
        title="Breadcrumb"
        description="Displays the path to the current resource using a hierarchy of links."
      />

      <.component_demo title="Default" code={default_code()}>
        <.breadcrumb>
          <:item navigate="/">Home</:item>
          <:item navigate="/docs">Documentation</:item>
          <:item navigate="/docs/components">Components</:item>
          <:item>Breadcrumb</:item>
        </.breadcrumb>
      </.component_demo>

      <.section_heading id="separator">Separator Styles</.section_heading>
      <.prose>
        Use the
        <.inline_code>separator</.inline_code>
        prop to change the separator between items. Available options are
        <.inline_code>chevron</.inline_code>
        (default) and <.inline_code>slash</.inline_code>.
      </.prose>

      <.component_demo title="Chevron Separator" code={chevron_code()}>
        <.breadcrumb separator="chevron">
          <:item navigate="/">Home</:item>
          <:item navigate="/products">Products</:item>
          <:item>Details</:item>
        </.breadcrumb>
      </.component_demo>

      <.component_demo title="Slash Separator" code={slash_code()}>
        <.breadcrumb separator="slash">
          <:item navigate="/">Home</:item>
          <:item navigate="/products">Products</:item>
          <:item>Details</:item>
        </.breadcrumb>
      </.component_demo>

      <.section_heading id="external-links">External Links</.section_heading>
      <.prose>
        Use the
        <.inline_code>href</.inline_code>
        attribute for external URLs.
      </.prose>

      <.component_demo title="External Link" code={external_code()}>
        <.breadcrumb>
          <:item href="https://github.com">GitHub</:item>
          <:item href="https://github.com/sutra-ui">Sutra UI</:item>
          <:item>Repository</:item>
        </.breadcrumb>
      </.component_demo>

      <.section_heading id="accessibility">Accessibility</.section_heading>
      <.prose>
        The breadcrumb component includes proper ARIA attributes for accessibility:
      </.prose>
      <ul class="list-disc list-inside space-y-1 text-sm" style="color: var(--fg-secondary);">
        <li>
          Uses semantic
          <.inline_code>&lt;nav&gt;</.inline_code>
          element with
          <.inline_code>aria-label="Breadcrumb"</.inline_code>
        </li>
        <li>Uses ordered list for semantic structure</li>
        <li>
          Current page marked with
          <.inline_code>aria-current="page"</.inline_code>
        </li>
        <li>Separator icons hidden from screen readers</li>
      </ul>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.breadcrumb>
      <:item navigate="/">Home</:item>
      <:item navigate="/docs">Documentation</:item>
      <:item navigate="/docs/components">Components</:item>
      <:item>Breadcrumb</:item>
    </.breadcrumb>\
    """
  end

  defp chevron_code do
    """
    <.breadcrumb separator="chevron">
      <:item navigate="/">Home</:item>
      <:item navigate="/products">Products</:item>
      <:item>Details</:item>
    </.breadcrumb>\
    """
  end

  defp slash_code do
    """
    <.breadcrumb separator="slash">
      <:item navigate="/">Home</:item>
      <:item navigate="/products">Products</:item>
      <:item>Details</:item>
    </.breadcrumb>\
    """
  end

  defp external_code do
    """
    <.breadcrumb>
      <:item href="https://github.com">GitHub</:item>
      <:item href="https://github.com/sutra-ui">Sutra UI</:item>
      <:item>Repository</:item>
    </.breadcrumb>\
    """
  end
end
