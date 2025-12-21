defmodule SutrauiDemoWeb.Components.TooltipLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Tooltip")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/tooltip">
      <.docs_header
        title="Tooltip"
        description="A popup that displays information related to an element when hovered or focused."
      />

      <.component_demo title="Default" code={default_code()}>
        <.tooltip id="tooltip-default" tooltip="Add to library">
          <.button variant="outline">Hover me</.button>
        </.tooltip>
      </.component_demo>

      <.section_heading id="positions">Positions</.section_heading>
      <.prose>
        Use the
        <.inline_code>side</.inline_code>
        prop to control where the tooltip appears.
      </.prose>

      <.component_demo title="Positions" code={positions_code()}>
        <div class="flex flex-wrap items-center justify-center gap-4">
          <.tooltip id="tooltip-top" tooltip="Tooltip on top" side="top">
            <.button variant="outline">Top</.button>
          </.tooltip>
          <.tooltip id="tooltip-bottom" tooltip="Tooltip on bottom" side="bottom">
            <.button variant="outline">Bottom</.button>
          </.tooltip>
          <.tooltip id="tooltip-left" tooltip="Tooltip on left" side="left">
            <.button variant="outline">Left</.button>
          </.tooltip>
          <.tooltip id="tooltip-right" tooltip="Tooltip on right" side="right">
            <.button variant="outline">Right</.button>
          </.tooltip>
        </div>
      </.component_demo>

      <.section_heading id="auto-position">Auto Position</.section_heading>
      <.prose>
        Use
        <.inline_code>side="auto"</.inline_code>
        for dynamic positioning that adjusts based on viewport boundaries.
      </.prose>

      <.component_demo title="Auto Position" code={auto_code()}>
        <.tooltip
          id="tooltip-auto"
          tooltip="I automatically position based on available space"
          side="auto"
        >
          <.button variant="outline">Auto Position</.button>
        </.tooltip>
      </.component_demo>

      <.section_heading id="on-icons">On Icons</.section_heading>
      <.prose>
        Tooltips are commonly used with icon buttons to provide context.
      </.prose>

      <.component_demo title="Icon Buttons" code={icons_code()}>
        <div class="flex items-center gap-2">
          <.tooltip id="tooltip-bold" tooltip="Bold">
            <.button variant="ghost" size="icon">
              <.icon name="lucide-bold" class="size-4" />
            </.button>
          </.tooltip>
          <.tooltip id="tooltip-italic" tooltip="Italic">
            <.button variant="ghost" size="icon">
              <.icon name="lucide-italic" class="size-4" />
            </.button>
          </.tooltip>
          <.tooltip id="tooltip-underline" tooltip="Underline">
            <.button variant="ghost" size="icon">
              <.icon name="lucide-underline" class="size-4" />
            </.button>
          </.tooltip>
        </div>
      </.component_demo>

      <.section_heading id="alignment">Alignment</.section_heading>
      <.prose>
        Use the
        <.inline_code>align</.inline_code>
        prop to control tooltip alignment.
      </.prose>

      <.component_demo title="Alignment" code={alignment_code()}>
        <div class="flex flex-wrap items-center gap-4">
          <.tooltip id="tooltip-start" tooltip="Aligned to start" side="bottom" align="start">
            <.button variant="outline">Start</.button>
          </.tooltip>
          <.tooltip id="tooltip-center" tooltip="Aligned to center" side="bottom" align="center">
            <.button variant="outline">Center</.button>
          </.tooltip>
          <.tooltip id="tooltip-end" tooltip="Aligned to end" side="bottom" align="end">
            <.button variant="outline">End</.button>
          </.tooltip>
        </div>
      </.component_demo>

      <.section_heading id="with-shortcut">With Keyboard Shortcut</.section_heading>
      <.prose>
        Combine tooltip text with keyboard shortcuts.
      </.prose>

      <.component_demo title="With Shortcut" code={shortcut_code()}>
        <div class="flex items-center gap-2">
          <.tooltip id="tooltip-save" tooltip="Save (⌘S)">
            <.button variant="outline">
              <.icon name="lucide-save" class="size-4 mr-2" /> Save
            </.button>
          </.tooltip>
          <.tooltip id="tooltip-copy" tooltip="Copy (⌘C)">
            <.button variant="outline">
              <.icon name="lucide-copy" class="size-4 mr-2" /> Copy
            </.button>
          </.tooltip>
        </div>
      </.component_demo>

      <.section_heading id="accessibility">Accessibility</.section_heading>
      <.prose>
        Tooltips are triggered by both mouse hover and keyboard focus, making them accessible
        to keyboard users. However, critical information should not be placed solely in tooltips
        as they may not be accessible to all users.
      </.prose>

      <.code_block
        language="heex"
        code={
          ~s|<.tooltip id="help-tooltip" tooltip="Additional help text">\n  <.button>Help</.button>\n</.tooltip>|
        }
      />
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.tooltip id="my-tooltip" tooltip="Add to library">
      <.button variant="outline">Hover me</.button>
    </.tooltip>\
    """
  end

  defp positions_code do
    """
    <.tooltip id="top" tooltip="Top" side="top">
      <.button>Top</.button>
    </.tooltip>
    <.tooltip id="bottom" tooltip="Bottom" side="bottom">
      <.button>Bottom</.button>
    </.tooltip>
    <.tooltip id="left" tooltip="Left" side="left">
      <.button>Left</.button>
    </.tooltip>
    <.tooltip id="right" tooltip="Right" side="right">
      <.button>Right</.button>
    </.tooltip>\
    """
  end

  defp auto_code do
    """
    <.tooltip id="auto" tooltip="Auto positions" side="auto">
      <.button>Auto</.button>
    </.tooltip>\
    """
  end

  defp icons_code do
    """
    <.tooltip id="bold" tooltip="Bold">
      <.button variant="ghost" size="icon">
        <.icon name="lucide-bold" class="size-4" />
      </.button>
    </.tooltip>\
    """
  end

  defp alignment_code do
    """
    <.tooltip id="start" tooltip="Start" align="start">
      <.button>Start</.button>
    </.tooltip>
    <.tooltip id="center" tooltip="Center" align="center">
      <.button>Center</.button>
    </.tooltip>
    <.tooltip id="end" tooltip="End" align="end">
      <.button>End</.button>
    </.tooltip>\
    """
  end

  defp shortcut_code do
    """
    <.tooltip id="save" tooltip="Save (⌘S)">
      <.button>Save</.button>
    </.tooltip>\
    """
  end
end
