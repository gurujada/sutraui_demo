defmodule SutrauiDemoWeb.Components.BadgeLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Badge")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/badge">
      <.docs_header
        title="Badge"
        description="Small status indicator for counts, labels, or status."
      />

      <.component_demo title="Default" code={~s|<.badge>Badge</.badge>|}>
        <.badge>Badge</.badge>
      </.component_demo>

      <.section_heading id="variants">Variants</.section_heading>
      <.prose>
        Badges support different variants for various status types.
      </.prose>

      <.component_demo title="Variants" code={variants_code()}>
        <div class="flex flex-wrap gap-2">
          <.badge>Default</.badge>
          <.badge variant="secondary">Secondary</.badge>
          <.badge variant="success">Success</.badge>
          <.badge variant="destructive">Destructive</.badge>
          <.badge variant="outline">Outline</.badge>
        </div>
      </.component_demo>

      <.section_heading id="as-link">As Link</.section_heading>
      <.prose>
        Badges can render as links when given an
        <.inline_code>href</.inline_code>
        prop.
      </.prose>

      <.component_demo title="As Link" code={link_code()}>
        <.badge href="/docs">Documentation</.badge>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp variants_code do
    """
    <.badge>Default</.badge>
    <.badge variant="secondary">Secondary</.badge>
    <.badge variant="success">Success</.badge>
    <.badge variant="destructive">Destructive</.badge>
    <.badge variant="outline">Outline</.badge>\
    """
  end

  defp link_code, do: ~s|<.badge href="/docs">Documentation</.badge>|
end
