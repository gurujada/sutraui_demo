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
        Sutra UI components use semantic color variables. Here are the main variables
        you can customize:
      </.prose>

      <.code_block language="elixir" code={css_variables_code()} />

      <.callout variant="info">
        Color values use the HSL format without the
        <.inline_code>hsl()</.inline_code>
        wrapper. This allows Tailwind to apply opacity modifiers.
      </.callout>

      <.section_heading>Dark Mode</.section_heading>

      <.prose>
        Dark mode is implemented by overriding the CSS variables when a
        <.inline_code>data-theme="dark"</.inline_code>
        attribute is present on the
        <.inline_code>&lt;html&gt;</.inline_code>
        element:
      </.prose>

      <.code_block language="elixir" code={dark_mode_code()} />

      <.prose>
        The theme toggle in the header sets this attribute and persists the preference
        to localStorage.
      </.prose>

      <.section_heading>Creating Custom Themes</.section_heading>

      <.prose>
        To create a custom theme, override the CSS variables in your
        <.inline_code>app.css</.inline_code>
        file. Here's an example of a blue-focused theme:
      </.prose>

      <.code_block language="elixir" code={custom_theme_code()} />

      <.section_heading>Using Theme Colors</.section_heading>

      <.prose>
        You can use the theme colors in your own components with Tailwind's arbitrary
        value syntax:
      </.prose>

      <.code_block language="heex" code={usage_code()} />
    </Layouts.docs>
    """
  end

  defp css_variables_code do
    """
    :root {
      --background: 0 0% 100%;
      --foreground: 240 10% 3.9%;

      --card: 0 0% 100%;
      --card-foreground: 240 10% 3.9%;

      --popover: 0 0% 100%;
      --popover-foreground: 240 10% 3.9%;

      --primary: 240 5.9% 10%;
      --primary-foreground: 0 0% 98%;

      --secondary: 240 4.8% 95.9%;
      --secondary-foreground: 240 5.9% 10%;

      --muted: 240 4.8% 95.9%;
      --muted-foreground: 240 3.8% 46.1%;

      --accent: 240 4.8% 95.9%;
      --accent-foreground: 240 5.9% 10%;

      --destructive: 0 84.2% 60.2%;
      --destructive-foreground: 0 0% 98%;

      --border: 240 5.9% 90%;
      --input: 240 5.9% 90%;
      --ring: 240 5.9% 10%;

      --radius: 0.5rem;
    }\
    """
  end

  defp dark_mode_code do
    """
    [data-theme="dark"] {
      --background: 240 10% 3.9%;
      --foreground: 0 0% 98%;

      --card: 240 10% 3.9%;
      --card-foreground: 0 0% 98%;

      /* ... other dark mode colors ... */
    }\
    """
  end

  defp custom_theme_code do
    """
    :root {
      --primary: 221 83% 53%;        /* Blue */
      --primary-foreground: 0 0% 100%;
      --ring: 221 83% 53%;
    }

    [data-theme="dark"] {
      --primary: 217 91% 60%;        /* Lighter blue for dark mode */
      --primary-foreground: 0 0% 100%;
      --ring: 217 91% 60%;
    }\
    """
  end

  defp usage_code do
    """
    <div class="bg-background text-foreground">
      <p class="text-muted-foreground">Muted text</p>
      <button class="bg-primary text-primary-foreground">
        Primary button
      </button>
    </div>\
    """
  end
end
