defmodule SutrauiDemoWeb.Components.ThemeSwitcherLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Theme Switcher")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/theme-switcher">
      <.docs_header
        title="Theme Switcher"
        description="A button component that toggles between light and dark themes with localStorage persistence."
      />

      <.callout>
        <strong>Try it!</strong>
        Click the sun/moon icon in the site header to toggle between light and dark modes.
      </.callout>

      <.component_demo title="Basic" code={basic_code()}>
        <div class="flex items-center gap-4">
          <.theme_switcher id="demo-theme-1" />
          <span style="color: var(--fg-muted);">Click to toggle theme</span>
        </div>
      </.component_demo>

      <.section_heading id="variants">Button Variants</.section_heading>
      <.prose>
        The theme switcher supports all button variants.
      </.prose>

      <.component_demo title="Variants" code={variants_code()}>
        <div class="flex flex-wrap items-center gap-4">
          <div class="text-center">
            <.theme_switcher id="demo-outline" variant="outline" />
            <p class="text-xs mt-1" style="color: var(--fg-muted);">outline</p>
          </div>
          <div class="text-center">
            <.theme_switcher id="demo-ghost" variant="ghost" />
            <p class="text-xs mt-1" style="color: var(--fg-muted);">ghost</p>
          </div>
          <div class="text-center">
            <.theme_switcher id="demo-secondary" variant="secondary" />
            <p class="text-xs mt-1" style="color: var(--fg-muted);">secondary</p>
          </div>
          <div class="text-center">
            <.theme_switcher id="demo-primary" variant="primary" />
            <p class="text-xs mt-1" style="color: var(--fg-muted);">primary</p>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="icon-sizes">Icon Sizes</.section_heading>
      <.prose>
        Control the icon size with the
        <.inline_code>icon_class</.inline_code>
        prop.
      </.prose>

      <.component_demo title="Icon Sizes" code={sizes_code()}>
        <div class="flex flex-wrap items-center gap-4">
          <div class="text-center">
            <.theme_switcher id="demo-icon-sm" icon_class="size-3" />
            <p class="text-xs mt-1" style="color: var(--fg-muted);">size-3</p>
          </div>
          <div class="text-center">
            <.theme_switcher id="demo-icon-default" icon_class="size-4" />
            <p class="text-xs mt-1" style="color: var(--fg-muted);">size-4 (default)</p>
          </div>
          <div class="text-center">
            <.theme_switcher id="demo-icon-lg" icon_class="size-5" />
            <p class="text-xs mt-1" style="color: var(--fg-muted);">size-5</p>
          </div>
          <div class="text-center">
            <.theme_switcher id="demo-icon-xl" icon_class="size-6" />
            <p class="text-xs mt-1" style="color: var(--fg-muted);">size-6</p>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="with-tooltip">With Tooltip</.section_heading>
      <.prose>
        Add a tooltip with the
        <.inline_code>tooltip</.inline_code>
        prop. Control position with <.inline_code>tooltip_side</.inline_code>.
      </.prose>

      <.component_demo title="With Tooltip" code={tooltip_code()}>
        <div class="flex items-center gap-8">
          <.theme_switcher id="demo-tooltip-bottom" tooltip="Toggle theme" tooltip_side="bottom" />
          <.theme_switcher
            id="demo-tooltip-right"
            tooltip="Switch to dark/light"
            tooltip_side="right"
          />
        </div>
      </.component_demo>

      <.section_heading id="setup">Setup</.section_heading>
      <.prose>
        Add this script to your root layout's
        <.inline_code>&lt;head&gt;</.inline_code>
        to prevent flash of unstyled content and enable theme persistence.
      </.prose>

      <.code_block language="html" code={setup_code()} />

      <.section_heading id="how-it-works">How It Works</.section_heading>
      <.list>
        <.list_item>
          Theme preference is stored in localStorage under
          <.inline_code>sutra-ui:theme</.inline_code>
        </.list_item>
        <.list_item>
          Falls back to system preference (<.inline_code>prefers-color-scheme</.inline_code>) if no stored preference
        </.list_item>
        <.list_item>
          Toggles the
          <.inline_code>.dark</.inline_code>
          class on the document root
        </.list_item>
        <.list_item>Changes sync across browser tabs automatically</.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.theme_switcher id="theme-toggle" />\
    """
  end

  defp variants_code do
    """
    <.theme_switcher id="theme-1" variant="outline" />
    <.theme_switcher id="theme-2" variant="ghost" />
    <.theme_switcher id="theme-3" variant="secondary" />
    <.theme_switcher id="theme-4" variant="primary" />\
    """
  end

  defp sizes_code do
    """
    <.theme_switcher id="theme-1" icon_class="size-3" />
    <.theme_switcher id="theme-2" icon_class="size-4" />
    <.theme_switcher id="theme-3" icon_class="size-5" />
    <.theme_switcher id="theme-4" icon_class="size-6" />\
    """
  end

  defp tooltip_code do
    """
    <.theme_switcher id="theme-toggle" tooltip="Toggle theme" tooltip_side="bottom" />\
    """
  end

  defp setup_code do
    """
    <script>
      (function() {
        const theme = localStorage.getItem('sutra-ui:theme') ||
          (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
        if (theme === 'dark') document.documentElement.classList.add('dark');
        
        window.addEventListener('sutra-ui:set-theme', (e) => {
          const newTheme = e.detail?.theme;
          if (newTheme === 'dark') {
            document.documentElement.classList.add('dark');
          } else {
            document.documentElement.classList.remove('dark');
          }
          localStorage.setItem('sutra-ui:theme', newTheme);
        });
      })();
    </script>\
    """
  end
end
