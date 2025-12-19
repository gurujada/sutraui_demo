defmodule SutrauiDemoWeb.Components.ButtonLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Button")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/button">
      <.docs_header
        title="Button"
        description="A versatile button component with multiple variants, sizes, and navigation support."
      />

      <.component_demo title="Default" code={default_code()}>
        <.button>Button</.button>
      </.component_demo>

      <.section_heading id="variants">Variants</.section_heading>
      <.prose>
        The button component supports multiple visual variants for different contexts.
      </.prose>

      <.component_demo title="Variants" code={variants_code()}>
        <div class="flex flex-wrap gap-4">
          <.button variant="primary">Primary</.button>
          <.button variant="secondary">Secondary</.button>
          <.button variant="destructive">Destructive</.button>
          <.button variant="outline">Outline</.button>
          <.button variant="ghost">Ghost</.button>
          <.button variant="link">Link</.button>
        </div>
      </.component_demo>

      <.section_heading id="sizes">Sizes</.section_heading>
      <.prose>
        Buttons come in different sizes to fit various UI contexts.
      </.prose>

      <.component_demo title="Sizes" code={sizes_code()}>
        <div class="flex flex-wrap items-center gap-4">
          <.button size="sm">Small</.button>
          <.button size="default">Default</.button>
          <.button size="lg">Large</.button>
          <.button size="icon" aria-label="Settings">
            <.icon name="hero-cog-6-tooth" class="h-4 w-4" />
          </.button>
        </div>
      </.component_demo>

      <.section_heading id="with-icon">With Icon</.section_heading>
      <.prose>
        Add icons to buttons for better visual communication.
      </.prose>

      <.component_demo title="With Icon" code={icon_code()}>
        <div class="flex flex-wrap gap-4">
          <.button>
            <.icon name="hero-envelope" class="mr-2 h-4 w-4" /> Login with Email
          </.button>
          <.button variant="outline">
            <.icon name="hero-arrow-down-tray" class="mr-2 h-4 w-4" /> Download
          </.button>
        </div>
      </.component_demo>

      <.section_heading id="loading">Loading State</.section_heading>
      <.prose>
        Show a loading state while an action is being processed.
      </.prose>

      <.component_demo title="Loading" code={loading_code()}>
        <div class="flex flex-wrap gap-4">
          <.button loading>Loading</.button>
          <.button loading variant="secondary">Please wait</.button>
        </div>
      </.component_demo>

      <.section_heading id="as-link">As Link</.section_heading>
      <.prose>
        Buttons can render as links using the <.inline_code>navigate</.inline_code>, <.inline_code>patch</.inline_code>, or
        <.inline_code>href</.inline_code>
        props.
      </.prose>

      <.component_demo title="As Link" code={link_code()}>
        <div class="flex flex-wrap gap-4">
          <.button navigate="/docs">Navigate</.button>
          <.button href="https://github.com" variant="outline">External Link</.button>
        </div>
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          When using <.inline_code>size="icon"</.inline_code>, always provide an
          <.inline_code>aria-label</.inline_code>
          for accessibility.
        </.list_item>
        <.list_item>
          The loading state automatically sets
          <.inline_code>aria-busy="true"</.inline_code>
          and disables the button.
        </.list_item>
        <.list_item>
          Use
          <.inline_code>navigate</.inline_code>
          for LiveView navigation,
          <.inline_code>patch</.inline_code>
          for same-LiveView updates, and
          <.inline_code>href</.inline_code>
          for external links.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp default_code, do: ~s|<.button>Button</.button>|

  defp variants_code do
    """
    <.button variant="primary">Primary</.button>
    <.button variant="secondary">Secondary</.button>
    <.button variant="destructive">Destructive</.button>
    <.button variant="outline">Outline</.button>
    <.button variant="ghost">Ghost</.button>
    <.button variant="link">Link</.button>\
    """
  end

  defp sizes_code do
    """
    <.button size="sm">Small</.button>
    <.button size="default">Default</.button>
    <.button size="lg">Large</.button>
    <.button size="icon" aria-label="Settings">
      <.icon name="hero-cog-6-tooth" class="h-4 w-4" />
    </.button>\
    """
  end

  defp icon_code do
    """
    <.button>
      <.icon name="hero-envelope" class="mr-2 h-4 w-4" /> Login with Email
    </.button>
    <.button variant="outline">
      <.icon name="hero-arrow-down-tray" class="mr-2 h-4 w-4" /> Download
    </.button>\
    """
  end

  defp loading_code do
    """
    <.button loading>Loading</.button>
    <.button loading variant="secondary">Please wait</.button>\
    """
  end

  defp link_code do
    """
    <.button navigate="/docs">Navigate</.button>
    <.button href="https://github.com" variant="outline">External Link</.button>\
    """
  end
end
