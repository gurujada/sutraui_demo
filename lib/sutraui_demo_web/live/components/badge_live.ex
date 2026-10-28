defmodule SutrauiDemoWeb.Components.BadgeLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Badge")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/badge"
    >
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

      <.section_heading id="tones">Tones</.section_heading>
      <.prose>
        <.inline_code>info</.inline_code>, <.inline_code>warning</.inline_code>,
        <.inline_code>brand</.inline_code>
        and
        <.inline_code>ai</.inline_code>
        run on theme tokens (<.inline_code>--info</.inline_code>, <.inline_code>--warning</.inline_code>, <.inline_code>--brand</.inline_code>, <.inline_code>--ai</.inline_code>), so overriding a token re-themes them.
      </.prose>

      <.component_demo title="Tones" code={tones_code()}>
        <div class="flex flex-wrap gap-2">
          <.badge variant="info">Info</.badge>
          <.badge variant="warning">Warning</.badge>
          <.badge variant="brand">Brand</.badge>
          <.badge variant="ai">AI</.badge>
        </div>
      </.component_demo>

      <.section_heading id="appearances">Appearances</.section_heading>
      <.prose>
        Every variant comes in three appearances:
        <.inline_code>solid</.inline_code>
        (default),
        <.inline_code>soft</.inline_code>
        (tinted background, tinted text) and
        <.inline_code>dashed</.inline_code>
        (for pending or suggested things).
      </.prose>

      <.component_demo title="Appearances" code={appearances_code()}>
        <div id="badge-appearances" class="space-y-3">
          <div
            :for={appearance <- ~w(solid soft dashed)}
            class="flex flex-wrap items-center gap-2"
          >
            <span class="w-16 text-xs text-muted-foreground">{appearance}</span>
            <.badge
              :for={v <- ~w(default secondary success destructive outline info warning brand ai)}
              variant={v}
              appearance={appearance}
            >
              {String.capitalize(v)}
            </.badge>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="icon">With an icon</.section_heading>
      <.prose>
        The
        <.inline_code>icon</.inline_code>
        slot is decorative; the content names the badge.
      </.prose>

      <.component_demo title="Icon slot" code={icon_code()}>
        <div class="flex flex-wrap gap-2">
          <.badge variant="success" appearance="soft">
            <:icon><.icon name="lucide-circle-check" class="size-3" /></:icon>
            Verified
          </.badge>
          <.badge variant="warning" appearance="soft">
            <:icon><.icon name="lucide-clock" class="size-3" /></:icon>
            Due soon
          </.badge>
          <.badge variant="ai" appearance="dashed">
            <:icon><.icon name="lucide-sparkles" class="size-3" /></:icon>
            Suggested
          </.badge>
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

  defp tones_code do
    """
    <.badge variant="info">Info</.badge>
    <.badge variant="warning">Warning</.badge>
    <.badge variant="brand">Brand</.badge>
    <.badge variant="ai">AI</.badge>\
    """
  end

  defp appearances_code do
    """
    <.badge variant="info">Solid</.badge>
    <.badge variant="info" appearance="soft">Soft</.badge>
    <.badge variant="info" appearance="dashed">Dashed</.badge>\
    """
  end

  defp icon_code do
    """
    <.badge variant="success" appearance="soft">
      <:icon><.icon name="lucide-circle-check" class="size-3" /></:icon>
      Verified
    </.badge>\
    """
  end
end
