defmodule SutrauiDemoWeb.Docs.IntroductionLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Introduction")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs">
      <.docs_header
        title="Introduction"
        description="A collection of beautiful, accessible components built entirely with Phoenix LiveView."
      />

      <.section_heading>What is Sutra UI?</.section_heading>

      <.prose>
        Sutra UI is a component library for Phoenix LiveView applications. Unlike traditional
        component libraries that rely on JavaScript frameworks, Sutra UI is built entirely
        with Phoenix LiveView and Elixir, using colocated hooks for client-side
        interactivity where needed.
      </.prose>

      <.prose>
        Components use semantic HTML, ARIA patterns where appropriate, and keyboard
        behavior for interactive controls. The styling is built on Tailwind CSS v4 with
        CSS variables, making it easy to customize themes.
      </.prose>

      <.section_heading>Key Features</.section_heading>

      <.list>
        <.list_item>
          <strong>Zero JavaScript Dependencies</strong> - All interactivity is powered by
          Phoenix LiveView colocated hooks. No npm packages required.
        </.list_item>
        <.list_item>
          <strong>Accessibility-minded</strong> - Semantic markup, visible focus states,
          screen reader support, and keyboard behavior where components need it.
        </.list_item>
        <.list_item>
          <strong>Dark Mode Built-in</strong> - Every component supports light and dark
          modes using CSS variables.
        </.list_item>
        <.list_item>
          <strong>Phoenix 1.8+ Ready</strong> - Built for modern Phoenix with LiveView 1.2+
          and Tailwind CSS v4.
        </.list_item>
        <.list_item>
          <strong>Customizable</strong> - Override styles with Tailwind classes or customize
          the CSS variables to match your brand.
        </.list_item>
      </.list>

      <.section_heading>Runtime Colocated Hooks</.section_heading>

      <.prose>
        Sutra UI uses Phoenix LiveView's colocated hooks feature (introduced in
        Phoenix 1.8). Most hooks are runtime hooks rendered by their component; extracted
        hooks are merged into your LiveSocket. Hook code is defined alongside HEEx templates
        using a special script tag syntax:
      </.prose>

      <.code_block
        language="heex"
        code={
          ~s'''
          <div id="my-component" phx-hook=".MyHook">
          <!-- Component content -->
          </div>

          <script :type={Phoenix.LiveView.ColocatedHook} name=".MyHook">
          export default {
          mounted() {
            // Hook logic here
          }
          }
          </script>
          '''
        }
      />

      <.prose>
        Note the
        <.inline_code>.MyHook</.inline_code>
        naming convention with the dot prefix.
        This is required for local colocated hooks. Runtime hooks are rendered by their
        components, while extracted hooks are bundled through Phoenix's generated
        <.inline_code>phoenix-colocated</.inline_code>
        module.
      </.prose>

      <.section_heading>Philosophy</.section_heading>

      <.prose>
        Sutra UI follows a "CSS-first" approach to theming. Instead of JavaScript-based
        theme providers, components use CSS custom properties (variables) that can be
        changed at the document level. This means themes work without any JavaScript
        and can be changed instantly.
      </.prose>

      <.prose>
        Components are designed to be composable. Complex UIs are built by combining
        simple, focused components rather than using monolithic "kitchen sink" components
        with dozens of props.
      </.prose>

      <.section_heading>Getting Started</.section_heading>

      <.prose>
        Ready to start using Sutra UI? Head over to the
        <.link navigate="/docs/installation" class="text-accent hover:underline">
          Installation Guide
        </.link>
        to add it to your Phoenix project.
      </.prose>
    </Layouts.docs>
    """
  end
end
