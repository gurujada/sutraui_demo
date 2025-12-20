defmodule SutrauiDemoWeb.Components.KbdLive do
  use SutrauiDemoWeb, :live_view

  # Exclude DocsComponents.kbd to use SutraUI.Kbd instead
  import SutrauiDemoWeb.DocsComponents, except: [kbd: 1]

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Kbd")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/kbd">
      <.docs_header
        title="Kbd"
        description="Displays keyboard input that triggers an action in the application."
      />

      <.component_demo title="Default" code={~s|<.kbd>Enter</.kbd>|}>
        <.kbd>Enter</.kbd>
      </.component_demo>

      <.section_heading id="single-keys">Single Keys</.section_heading>
      <.prose>
        Display individual keyboard keys.
      </.prose>

      <.component_demo title="Single Keys" code={single_keys_code()}>
        <div class="flex items-center gap-2">
          <.kbd>Esc</.kbd>
          <.kbd>Tab</.kbd>
          <.kbd>Space</.kbd>
          <.kbd>Enter</.kbd>
          <.kbd>Backspace</.kbd>
        </div>
      </.component_demo>

      <.section_heading id="key-combinations">Key Combinations</.section_heading>
      <.prose>
        Combine multiple
        <.inline_code>kbd</.inline_code>
        elements with a separator for keyboard shortcuts.
      </.prose>

      <.component_demo title="Combinations" code={combinations_code()}>
        <div class="flex flex-col gap-3">
          <div class="flex items-center gap-1">
            <.kbd>Ctrl</.kbd>
            <span style="color: var(--fg-muted);">+</span>
            <.kbd>C</.kbd>
            <span class="ml-2 text-sm" style="color: var(--fg-muted);">Copy</span>
          </div>
          <div class="flex items-center gap-1">
            <.kbd>Ctrl</.kbd>
            <span style="color: var(--fg-muted);">+</span>
            <.kbd>V</.kbd>
            <span class="ml-2 text-sm" style="color: var(--fg-muted);">Paste</span>
          </div>
          <div class="flex items-center gap-1">
            <.kbd>Ctrl</.kbd>
            <span style="color: var(--fg-muted);">+</span>
            <.kbd>Shift</.kbd>
            <span style="color: var(--fg-muted);">+</span>
            <.kbd>Z</.kbd>
            <span class="ml-2 text-sm" style="color: var(--fg-muted);">Redo</span>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="mac-shortcuts">Mac Shortcuts</.section_heading>
      <.prose>
        Use special characters for Mac modifier keys.
      </.prose>

      <.component_demo title="Mac Shortcuts" code={mac_code()}>
        <div class="flex flex-col gap-3">
          <div class="flex items-center gap-1">
            <.kbd>⌘</.kbd>
            <span style="color: var(--fg-muted);">+</span>
            <.kbd>K</.kbd>
            <span class="ml-2 text-sm" style="color: var(--fg-muted);">Command palette</span>
          </div>
          <div class="flex items-center gap-1">
            <.kbd>⌘</.kbd>
            <span style="color: var(--fg-muted);">+</span>
            <.kbd>S</.kbd>
            <span class="ml-2 text-sm" style="color: var(--fg-muted);">Save</span>
          </div>
          <div class="flex items-center gap-1">
            <.kbd>⌥</.kbd>
            <span style="color: var(--fg-muted);">+</span>
            <.kbd>⇧</.kbd>
            <span style="color: var(--fg-muted);">+</span>
            <.kbd>F</.kbd>
            <span class="ml-2 text-sm" style="color: var(--fg-muted);">Format</span>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="arrow-keys">Arrow Keys</.section_heading>
      <.prose>
        Display navigation keys.
      </.prose>

      <.component_demo title="Arrow Keys" code={arrows_code()}>
        <div class="flex items-center gap-2">
          <.kbd>↑</.kbd>
          <.kbd>↓</.kbd>
          <.kbd>←</.kbd>
          <.kbd>→</.kbd>
        </div>
      </.component_demo>

      <.section_heading id="in-context">In Context</.section_heading>
      <.prose>
        Use kbd elements inline with text to describe shortcuts.
      </.prose>

      <.component_demo title="In Context" code={context_code()}>
        <div class="space-y-3 text-sm" style="color: var(--fg);">
          <p>
            Press
            <.kbd>⌘</.kbd>
            <.kbd>K</.kbd>
            to open the command palette.
          </p>
          <p>
            Use
            <.kbd>↑</.kbd>
            and
            <.kbd>↓</.kbd>
            to navigate,
            <.kbd>Enter</.kbd>
            to select.
          </p>
          <p>
            Press
            <.kbd>Esc</.kbd>
            to close.
          </p>
        </div>
      </.component_demo>

      <.section_heading id="shortcut-list">Shortcut List</.section_heading>
      <.prose>
        A common pattern for displaying a list of keyboard shortcuts.
      </.prose>

      <.component_demo title="Shortcut List" code={list_code()}>
        <div
          class="rounded-lg border divide-y"
          style="background: var(--bg-elevated); border-color: var(--border); --tw-divide-opacity: 1; divide-color: var(--border);"
        >
          <div class="flex items-center justify-between px-4 py-3">
            <span class="text-sm" style="color: var(--fg);">Search</span>
            <div class="flex items-center gap-1">
              <.kbd>⌘</.kbd>
              <.kbd>K</.kbd>
            </div>
          </div>
          <div class="flex items-center justify-between px-4 py-3">
            <span class="text-sm" style="color: var(--fg);">New file</span>
            <div class="flex items-center gap-1">
              <.kbd>⌘</.kbd>
              <.kbd>N</.kbd>
            </div>
          </div>
          <div class="flex items-center justify-between px-4 py-3">
            <span class="text-sm" style="color: var(--fg);">Settings</span>
            <div class="flex items-center gap-1">
              <.kbd>⌘</.kbd>
              <.kbd>,</.kbd>
            </div>
          </div>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp single_keys_code do
    """
    <.kbd>Esc</.kbd>
    <.kbd>Tab</.kbd>
    <.kbd>Space</.kbd>
    <.kbd>Enter</.kbd>\
    """
  end

  defp combinations_code do
    """
    <.kbd>Ctrl</.kbd> + <.kbd>C</.kbd>
    <.kbd>Ctrl</.kbd> + <.kbd>V</.kbd>
    <.kbd>Ctrl</.kbd> + <.kbd>Shift</.kbd> + <.kbd>Z</.kbd>\
    """
  end

  defp mac_code do
    """
    <.kbd>⌘</.kbd> + <.kbd>K</.kbd>
    <.kbd>⌘</.kbd> + <.kbd>S</.kbd>
    <.kbd>⌥</.kbd> + <.kbd>⇧</.kbd> + <.kbd>F</.kbd>\
    """
  end

  defp arrows_code do
    """
    <.kbd>↑</.kbd>
    <.kbd>↓</.kbd>
    <.kbd>←</.kbd>
    <.kbd>→</.kbd>\
    """
  end

  defp context_code do
    """
    <p>Press <.kbd>⌘</.kbd><.kbd>K</.kbd> to open the command palette.</p>
    <p>Use <.kbd>↑</.kbd> and <.kbd>↓</.kbd> to navigate.</p>\
    """
  end

  defp list_code do
    """
    <div class="rounded-lg border divide-y">
      <div class="flex items-center justify-between px-4 py-3">
        <span>Search</span>
        <div><.kbd>⌘</.kbd><.kbd>K</.kbd></div>
      </div>
      <div class="flex items-center justify-between px-4 py-3">
        <span>New file</span>
        <div><.kbd>⌘</.kbd><.kbd>N</.kbd></div>
      </div>
    </div>\
    """
  end
end
