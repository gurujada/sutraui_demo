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
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z" />
                <path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z" />
              </svg>
            </.button>
          </.tooltip>
          <.tooltip id="tooltip-italic" tooltip="Italic">
            <.button variant="ghost" size="icon">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <line x1="19" x2="10" y1="4" y2="4" />
                <line x1="14" x2="5" y1="20" y2="20" />
                <line x1="15" x2="9" y1="4" y2="20" />
              </svg>
            </.button>
          </.tooltip>
          <.tooltip id="tooltip-underline" tooltip="Underline">
            <.button variant="ghost" size="icon">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M6 4v6a6 6 0 0 0 12 0V4" />
                <line x1="4" x2="20" y1="20" y2="20" />
              </svg>
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
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="w-4 h-4 mr-2"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z" />
                <polyline points="17,21 17,13 7,13 7,21" />
                <polyline points="7,3 7,8 15,8" />
              </svg>
              Save
            </.button>
          </.tooltip>
          <.tooltip id="tooltip-copy" tooltip="Copy (⌘C)">
            <.button variant="outline">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="w-4 h-4 mr-2"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <rect width="14" height="14" x="8" y="8" rx="2" ry="2" />
                <path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2" />
              </svg>
              Copy
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
        <svg>...</svg>
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
