defmodule SutrauiDemoWeb.Components.ItemLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Item")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/item">
      <.docs_header
        title="Item"
        description="A versatile list item component for displaying content with icons, avatars, and actions."
      />

      <.component_demo title="Basic" code={basic_code()}>
        <.item>
          <:title>Basic Item</:title>
          <:description>A simple item with title and description.</:description>
        </.item>
      </.component_demo>

      <.section_heading id="with-icon">With Icon</.section_heading>
      <.prose>
        Add an icon using the
        <.inline_code>:leading</.inline_code>
        slot with the
        <.inline_code>item-icon-box</.inline_code>
        class.
      </.prose>

      <.component_demo title="With Icon" code={icon_code()}>
        <.item>
          <:leading>
            <div class="item-icon-box">
              <.icon name="lucide-shield-alert" class="size-6" />
            </div>
          </:leading>
          <:title>Security Alert</:title>
          <:description>New login detected from unknown device.</:description>
          <:trailing>
            <.button variant="outline" size="sm">Review</.button>
          </:trailing>
        </.item>
      </.component_demo>

      <.section_heading id="with-avatar">With Avatar</.section_heading>
      <.prose>
        Use any image or avatar component in the leading slot.
      </.prose>

      <.component_demo title="With Avatar" code={avatar_code()}>
        <.item>
          <:leading>
            <.avatar src="https://i.pravatar.cc/150?u=demo" initials="JD" size="md" />
          </:leading>
          <:title>John Doe</:title>
          <:description>Last seen 5 minutes ago</:description>
          <:trailing>
            <.button variant="ghost" size="icon" class="rounded-full">
              <.icon name="lucide-plus" class="size-4" />
            </.button>
          </:trailing>
        </.item>
      </.component_demo>

      <.section_heading id="variants">Variants</.section_heading>
      <.prose>
        Choose from <.inline_code>default</.inline_code>, <.inline_code>outline</.inline_code>, or
        <.inline_code>muted</.inline_code>
        variants.
      </.prose>

      <.component_demo title="Variants" code={variants_code()}>
        <div class="space-y-3">
          <.item variant="default">
            <:title>Default Variant</:title>
            <:description>Transparent border, minimal styling.</:description>
          </.item>

          <.item variant="outline">
            <:title>Outline Variant</:title>
            <:description>Visible border for separation.</:description>
          </.item>

          <.item variant="muted">
            <:title>Muted Variant</:title>
            <:description>Subtle background for grouping.</:description>
          </.item>
        </div>
      </.component_demo>

      <.section_heading id="as-link">As Link</.section_heading>
      <.prose>
        Use
        <.inline_code>as="a"</.inline_code>
        to render as an anchor tag with href.
      </.prose>

      <.component_demo title="As Link" code={link_code()}>
        <.item as="a" href="#" variant="outline">
          <:leading>
            <div class="item-icon-inline">
              <.icon name="lucide-badge-check" class="size-5" />
            </div>
          </:leading>
          <:title>Your profile has been verified.</:title>
          <:trailing>
            <.icon name="lucide-chevron-right" class="size-4" />
          </:trailing>
        </.item>
      </.component_demo>

      <.section_heading id="as-button">As Button</.section_heading>
      <.prose>
        Use
        <.inline_code>as="button"</.inline_code>
        for clickable items with event handlers.
      </.prose>

      <.component_demo title="As Button" code={button_code()}>
        <.item as="button" variant="outline" phx-click="item_clicked">
          <:leading>
            <div class="item-icon-box">
              <.icon name="lucide-pencil" class="size-5" />
            </div>
          </:leading>
          <:title>Edit Settings</:title>
          <:description>Click to modify your preferences.</:description>
        </.item>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.item>
      <:title>Basic Item</:title>
      <:description>A simple item with title and description.</:description>
    </.item>\
    """
  end

  defp icon_code do
    """
    <.item>
      <:leading>
        <div class="item-icon-box">
          <.icon name="lucide-shield-alert" class="size-6" />
        </div>
      </:leading>
      <:title>Security Alert</:title>
      <:description>New login detected from unknown device.</:description>
      <:trailing>
        <.button variant="outline" size="sm">Review</.button>
      </:trailing>
    </.item>\
    """
  end

  defp avatar_code do
    """
    <.item>
      <:leading>
        <.avatar src="https://..." fallback="JD" size="md" />
      </:leading>
      <:title>John Doe</:title>
      <:description>Last seen 5 minutes ago</:description>
      <:trailing>
        <.button variant="ghost" size="icon">
          <.icon name="lucide-plus" class="size-4" />
        </.button>
      </:trailing>
    </.item>\
    """
  end

  defp variants_code do
    """
    <.item variant="default">
      <:title>Default Variant</:title>
    </.item>

    <.item variant="outline">
      <:title>Outline Variant</:title>
    </.item>

    <.item variant="muted">
      <:title>Muted Variant</:title>
    </.item>\
    """
  end

  defp link_code do
    """
    <.item as="a" href="/profile" variant="outline">
      <:leading>
        <div class="item-icon-inline">
          <.icon name="lucide-badge-check" class="size-5" />
        </div>
      </:leading>
      <:title>Your profile has been verified.</:title>
      <:trailing>
        <.icon name="lucide-chevron-right" class="size-4" />
      </:trailing>
    </.item>\
    """
  end

  defp button_code do
    """
    <.item as="button" variant="outline" phx-click="item_clicked">
      <:leading>
        <div class="item-icon-box">
          <.icon name="lucide-pencil" class="size-5" />
        </div>
      </:leading>
      <:title>Edit Settings</:title>
      <:description>Click to modify your preferences.</:description>
    </.item>\
    """
  end
end
