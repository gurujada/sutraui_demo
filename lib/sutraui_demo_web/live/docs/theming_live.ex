defmodule SutrauiDemoWeb.Docs.ThemingLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Theming")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/theming">
      <.docs_header
        title="Theming"
        description="Customize the look and feel of Sutra UI components with CSS variables."
      />

      <.section_heading>How Theming Works</.section_heading>

      <.prose>
        Sutra UI uses CSS custom properties (variables) for theming. This approach has
        several advantages over JavaScript-based theming:
      </.prose>

      <.list>
        <.list_item>Themes work without JavaScript</.list_item>
        <.list_item>Instant theme switching with no flash of unstyled content</.list_item>
        <.list_item>Easy to customize with standard CSS</.list_item>
        <.list_item>Works with server-side rendering</.list_item>
      </.list>

      <.section_heading>CSS Variables</.section_heading>

      <.prose>
        Override theme variables in your
        <.inline_code>app.css</.inline_code>
        after
        importing <.inline_code>sutra_ui.css</.inline_code>. Sutra UI uses the OKLCH
        color format for better perceptual uniformity:
      </.prose>

      <.code_block language="elixir" code={css_variables_code()} />

      <.callout variant="info">
        OKLCH colors provide better perceptual uniformity than HSL. The format is:
        <.inline_code>oklch(L C H)</.inline_code>
        where L = Lightness (0-1),
        C = Chroma (0-0.4), H = Hue (0-360).
      </.callout>

      <.section_heading>Using shadcn Themes</.section_heading>

      <.prose>
        Sutra UI uses the same CSS variable names as shadcn/ui. You can copy theme
        variables directly from
        <a
          href="https://ui.shadcn.com/themes"
          target="_blank"
          class="text-accent hover:underline"
        >
          shadcn/ui themes
        </a>
        and paste them into your <.inline_code>app.css</.inline_code>:
      </.prose>

      <.code_block language="elixir" code={shadcn_code()} />

      <.section_heading>Dark Mode</.section_heading>

      <.prose>
        Dark mode is implemented by overriding the CSS variables within a
        <.inline_code>.dark</.inline_code>
        class:
      </.prose>

      <.code_block language="elixir" code={dark_mode_code()} />

      <.section_heading>Variable Reference</.section_heading>

      <.prose>
        Here are all the available CSS variables and their purpose:
      </.prose>

      <.subsection_heading>Core Colors</.subsection_heading>

      <div class="my-6 overflow-hidden rounded-lg border" style="border-color: var(--border);">
        <table class="w-full text-sm">
          <thead>
            <tr style="background: var(--bg-subtle); border-bottom: 1px solid var(--border);">
              <th class="px-4 py-3 text-left font-medium">Variable</th>
              <th class="px-4 py-3 text-left font-medium">Description</th>
            </tr>
          </thead>
          <tbody>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--background</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Page background color</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--foreground</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Default text color</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--primary</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Primary brand color (buttons, links)</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--secondary</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Secondary/muted actions</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--muted</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Muted backgrounds</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--accent</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Hover/active states</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--destructive</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Error/danger color</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--border</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Border color</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--input</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Input border color</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--ring</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Focus ring color</td>
            </tr>
            <tr>
              <td class="px-4 py-3">
                <.inline_code>--radius</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Base border radius</td>
            </tr>
          </tbody>
        </table>
      </div>

      <.subsection_heading>Surface Colors</.subsection_heading>

      <div class="my-6 overflow-hidden rounded-lg border" style="border-color: var(--border);">
        <table class="w-full text-sm">
          <thead>
            <tr style="background: var(--bg-subtle); border-bottom: 1px solid var(--border);">
              <th class="px-4 py-3 text-left font-medium">Variable</th>
              <th class="px-4 py-3 text-left font-medium">Description</th>
            </tr>
          </thead>
          <tbody>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--card</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Card background</td>
            </tr>
            <tr>
              <td class="px-4 py-3">
                <.inline_code>--popover</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Popover/dropdown background</td>
            </tr>
          </tbody>
        </table>
      </div>

      <.subsection_heading>Drawer Colors</.subsection_heading>

      <div class="my-6 overflow-hidden rounded-lg border" style="border-color: var(--border);">
        <table class="w-full text-sm">
          <thead>
            <tr style="background: var(--bg-subtle); border-bottom: 1px solid var(--border);">
              <th class="px-4 py-3 text-left font-medium">Variable</th>
              <th class="px-4 py-3 text-left font-medium">Description</th>
            </tr>
          </thead>
          <tbody>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--drawer</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Drawer background</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--drawer-foreground</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Drawer text color</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--drawer-primary</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Drawer active item</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--drawer-accent</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Drawer hover state</td>
            </tr>
            <tr style="border-bottom: 1px solid var(--border);">
              <td class="px-4 py-3">
                <.inline_code>--drawer-border</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Drawer border</td>
            </tr>
            <tr>
              <td class="px-4 py-3">
                <.inline_code>--drawer-ring</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Drawer focus ring</td>
            </tr>
          </tbody>
        </table>
      </div>

      <.subsection_heading>Chart Colors</.subsection_heading>

      <div class="my-6 overflow-hidden rounded-lg border" style="border-color: var(--border);">
        <table class="w-full text-sm">
          <thead>
            <tr style="background: var(--bg-subtle); border-bottom: 1px solid var(--border);">
              <th class="px-4 py-3 text-left font-medium">Variable</th>
              <th class="px-4 py-3 text-left font-medium">Description</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="px-4 py-3">
                <.inline_code>--chart-1</.inline_code>
                to
                <.inline_code>--chart-5</.inline_code>
              </td>
              <td class="px-4 py-3 text-muted-foreground">Chart/data visualization colors</td>
            </tr>
          </tbody>
        </table>
      </div>

      <.prose>
        Each color variable also has a
        <.inline_code>-foreground</.inline_code>
        variant
        for text that appears on that background (e.g., <.inline_code>--primary-foreground</.inline_code>).
      </.prose>
    </Layouts.docs>
    """
  end

  defp css_variables_code do
    """
    @import "../../deps/sutra_ui/priv/static/sutra_ui.css";

    /* Custom theme overrides */
    :root {
      --primary: oklch(0.65 0.20 145);        /* Green */
      --primary-foreground: oklch(0.98 0 0);  /* White text */

      --destructive: oklch(0.55 0.25 30);     /* Red */
      --radius: 0.5rem;
    }\
    """
  end

  defp shadcn_code do
    """
    /* Paste shadcn theme variables - they just work! */
    :root {
      --background: oklch(1 0 0);
      --foreground: oklch(0.141 0.005 285.823);
      --primary: oklch(0.21 0.006 285.885);
      --primary-foreground: oklch(0.985 0 0);
      --secondary: oklch(0.967 0.001 286.375);
      --muted: oklch(0.967 0.001 286.375);
      --accent: oklch(0.967 0.001 286.375);
      --destructive: oklch(0.577 0.245 27.325);
      --border: oklch(0.92 0.004 286.32);
      --ring: oklch(0.705 0.015 286.067);
    }\
    """
  end

  defp dark_mode_code do
    """
    .dark {
      --background: oklch(0.141 0.005 285.823);
      --foreground: oklch(0.985 0 0);
      --primary: oklch(0.70 0.18 145);
      /* ... other dark mode colors ... */
    }\
    """
  end
end
