defmodule SutrauiDemoWeb.Docs.InstallationLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Installation")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/installation">
      <.docs_header
        title="Installation"
        description="Get up and running with Sutra UI in your Phoenix project."
      />

      <.callout variant="info">
        Sutra UI requires Phoenix 1.8+, LiveView 1.1+, and Tailwind CSS v4.
      </.callout>

      <.section_heading>Quick Install</.section_heading>

      <.prose>
        The fastest way to get started. Add the dependency and run the installer:
      </.prose>

      <.code_block language="elixir" code={quick_deps_code()} />

      <.prose>
        Then run:
      </.prose>

      <.code_block language="elixir" code={quick_install_code()} />

      <.prose>
        The installer will configure your CSS and web module automatically.
        No JavaScript configuration is required — Sutra UI uses Phoenix 1.8+ runtime
        colocated hooks that work out of the box.
      </.prose>

      <.section_heading>Manual Installation</.section_heading>

      <.prose>
        If you prefer to configure things manually, follow these steps:
      </.prose>

      <div class="space-y-8 mt-6">
        <.step number={1} title="Add the dependency">
          <.prose>
            Add
            <.inline_code>sutra_ui</.inline_code>
            to your dependencies in <.inline_code>mix.exs</.inline_code>:
          </.prose>
          <.code_block language="elixir" code={deps_code()} />
          <.prose>
            Then fetch the dependencies:
          </.prose>
          <.code_block language="elixir" code="mix deps.get" />
        </.step>

        <.step number={2} title="Delete core_components.ex">
          <.prose>
            Sutra UI replaces Phoenix's default <.inline_code>core_components.ex</.inline_code>.
            Delete it and remove its import:
          </.prose>
          <.code_block language="elixir" code="rm lib/my_app_web/components/core_components.ex" />
          <.prose>
            In your <.inline_code>my_app_web.ex</.inline_code>, remove the
            <.inline_code>import MyAppWeb.CoreComponents</.inline_code>
            line.
          </.prose>
        </.step>

        <.step number={3} title="Setup CSS">
          <.prose>
            In your <.inline_code>assets/css/app.css</.inline_code>, add the Sutra UI
            source path and import after the Tailwind import:
          </.prose>
          <.code_block language="elixir" code={css_code()} />
        </.step>

        <.step number={4} title="Import components">
          <.prose>
            In your <.inline_code>my_app_web.ex</.inline_code>, add
            <.inline_code>use SutraUI</.inline_code>
            to <.inline_code>html_helpers</.inline_code>:
          </.prose>
          <.code_block language="elixir" code={html_helpers_code()} />
          <.prose>
            This imports all components. You can also import selectively:
          </.prose>
          <.code_block language="elixir" code={selective_import_code()} />
        </.step>

        <.step number={5} title="Verify installation">
          <.prose>
            Start your Phoenix server and try a component:
          </.prose>
          <.code_block language="heex" code={~s|<.button>Hello Sutra UI!</.button>|} />
          <.prose>
            If everything is set up correctly, you should see a styled button.
          </.prose>
        </.step>
      </div>

      <.section_heading>Next Steps</.section_heading>

      <.prose>
        Now that you have Sutra UI installed:
      </.prose>

      <.list>
        <.list_item>
          <.link navigate="/docs/theming" class="text-accent hover:underline">
            Learn about theming
          </.link>
          to customize your components.
        </.list_item>
        <.list_item>
          <.link navigate="/docs/components/button" class="text-accent hover:underline">
            Explore the components
          </.link>
          to see what's available.
        </.list_item>
      </.list>

      <.section_heading>Icons</.section_heading>

      <.prose>
        Sutra UI does not include an icon component — you're free to use any icon library you prefer.
        We recommend
        <.link href="https://lucide.dev" class="text-accent hover:underline">Lucide</.link>
        as it pairs well with our design aesthetic. Add the dependency to your mix.exs,
        create a Tailwind plugin, and use icons as CSS classes:
      </.prose>

      <.code_block language="elixir" filename="mix.exs" code={lucide_deps_code()} />

      <.prose>
        Then use icons anywhere with Tailwind classes:
      </.prose>

      <.code_block language="heex" code={~s|<span class="lucide--check size-4" />|} />
    </Layouts.docs>
    """
  end

  defp quick_deps_code do
    """
    # mix.exs
    def deps do
      [
        {:sutra_ui, "~> 0.1"}
      ]
    end\
    """
  end

  defp quick_install_code do
    """
    mix deps.get
    mix sutra_ui.install\
    """
  end

  defp deps_code do
    """
    def deps do
      [
        {:sutra_ui, "~> 0.1"}
      ]
    end\
    """
  end

  defp css_code do
    """
    @import "tailwindcss";

    /* Sutra UI */
    @source "../../deps/sutra_ui/lib";
    @import "../../deps/sutra_ui/priv/static/sutra_ui.css";\
    """
  end

  defp html_helpers_code do
    """
    defp html_helpers do
      quote do
        use SutraUI
        # ... other imports
      end
    end\
    """
  end

  defp selective_import_code do
    """
    # Import only what you need
    import SutraUI.Button
    import SutraUI.Input\
    """
  end

  defp lucide_deps_code do
    """
    {:lucide_icons,
     github: "lucide-icons/lucide",
     sparse: "icons",
     app: false,
     compile: false,
     depth: 1}\
    """
  end
end
