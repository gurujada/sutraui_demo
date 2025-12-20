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
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              >
                <path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z" />
                <path d="M12 8v4" />
                <path d="M12 16h.01" />
              </svg>
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
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M5 12h14" /><path d="M12 5v14" />
              </svg>
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
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="20"
                height="20"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M3.85 8.62a4 4 0 0 1 4.78-4.77 4 4 0 0 1 6.74 0 4 4 0 0 1 4.78 4.78 4 4 0 0 1 0 6.74 4 4 0 0 1-4.77 4.78 4 4 0 0 1-6.75 0 4 4 0 0 1-4.78-4.77 4 4 0 0 1 0-6.76Z" />
                <path d="m9 12 2 2 4-4" />
              </svg>
            </div>
          </:leading>
          <:title>Your profile has been verified.</:title>
          <:trailing>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
            >
              <path d="m9 18 6-6-6-6" />
            </svg>
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
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="20"
                height="20"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M12 20h9" />
                <path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4Z" />
              </svg>
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
          <svg><!-- shield icon --></svg>
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
        <.button variant="ghost" size="icon">+</.button>
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
          <svg><!-- verified icon --></svg>
        </div>
      </:leading>
      <:title>Your profile has been verified.</:title>
      <:trailing>
        <svg><!-- chevron right --></svg>
      </:trailing>
    </.item>\
    """
  end

  defp button_code do
    """
    <.item as="button" variant="outline" phx-click="item_clicked">
      <:leading>
        <div class="item-icon-box">
          <svg><!-- edit icon --></svg>
        </div>
      </:leading>
      <:title>Edit Settings</:title>
      <:description>Click to modify your preferences.</:description>
    </.item>\
    """
  end
end
