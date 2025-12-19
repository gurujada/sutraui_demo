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

      <div class="space-y-8 mt-8">
        <.step number={1} title="Add the dependency">
          <.prose>
            Add
            <.inline_code>sutra_ui</.inline_code>
            to your list of dependencies in <.inline_code>mix.exs</.inline_code>:
          </.prose>
          <.code_block language="elixir" code={deps_code()} />
          <.prose>
            Then fetch the dependencies:
          </.prose>
          <.code_block language="elixir" code="mix deps.get" />
        </.step>

        <.step number={2} title="Remove core_components.ex">
          <.prose>
            Sutra UI replaces the default Phoenix core components. Delete or comment out
            the contents of <.inline_code>lib/my_app_web/components/core_components.ex</.inline_code>.
          </.prose>
          <.prose>
            You can keep the
            <.inline_code>icon/1</.inline_code>
            component if you want to
            continue using Heroicons:
          </.prose>
          <.code_block language="elixir" code={icon_code()} />
        </.step>

        <.step number={3} title="Configure your application">
          <.prose>
            Update your
            <.inline_code>lib/my_app_web.ex</.inline_code>
            file to use Sutra UI.
            Add
            <.inline_code>use SutraUI</.inline_code>
            to the
            <.inline_code>html_helpers/0</.inline_code>
            function:
          </.prose>
          <.code_block language="elixir" code={html_helpers_code()} />
        </.step>

        <.step number={4} title="Configure Tailwind CSS v4">
          <.prose>
            Update your
            <.inline_code>assets/css/app.css</.inline_code>
            to include Sutra UI's
            styles and source paths:
          </.prose>
          <.code_block language="elixir" code={css_code()} />
        </.step>

        <.step number={5} title="Configure JavaScript hooks">
          <.prose>
            Sutra UI uses Phoenix's runtime colocated hooks. Update your
            <.inline_code>assets/js/app.js</.inline_code>
            to include them:
          </.prose>
          <.code_block language="elixir" code={js_code()} />
          <.callout variant="info">
            Replace
            <.inline_code>my_app</.inline_code>
            with your actual application name
            in the import path.
          </.callout>
        </.step>

        <.step number={6} title="Verify installation">
          <.prose>
            Start your Phoenix server and try using a Sutra UI component:
          </.prose>
          <.code_block language="heex" code={~s|<.button>Hello Sutra UI!</.button>|} />
          <.prose>
            If everything is set up correctly, you should see a styled button.
          </.prose>
        </.step>
      </div>

      <.section_heading>Next Steps</.section_heading>

      <.prose>
        Now that you have Sutra UI installed, you can:
      </.prose>

      <.list>
        <.list_item>
          <a href="/docs/theming" class="text-primary hover:underline">Learn about theming</a>
          and customize the look of your components.
        </.list_item>
        <.list_item>
          <a href="/docs/components/button" class="text-primary hover:underline">
            Explore the components
          </a>
          and see what's available.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp deps_code do
    """
    defp deps do
      [
        {:sutra_ui, "~> 0.1"}
      ]
    end\
    """
  end

  defp icon_code do
    """
    defmodule MyAppWeb.CoreComponents do
      use Phoenix.Component

      attr :name, :string, required: true
      attr :class, :any, default: "size-4"

      def icon(%{name: "hero-" <> _} = assigns) do
        ~H\"\"\"
        <span class={[@name, @class]} />
        \"\"\"
      end
    end\
    """
  end

  defp html_helpers_code do
    """
    defp html_helpers do
      quote do
        # ... existing code ...

        # Add Sutra UI components
        use SutraUI

        # ... rest of existing code ...
      end
    end\
    """
  end

  defp css_code do
    """
    @import "tailwindcss" source(none);

    /* Add Sutra UI source path for Tailwind to scan */
    @source "../../deps/sutra_ui/lib";

    /* Import Sutra UI component styles */
    @import "../../deps/sutra_ui/priv/static/sutra_ui.css";

    /* Your existing sources */
    @source "../css";
    @source "../js";
    @source "../../lib/my_app_web";

    /* ... rest of your CSS ... */\
    """
  end

  defp js_code do
    """
    import {Socket} from "phoenix"
    import {LiveSocket} from "phoenix_live_view"
    import {hooks as colocatedHooks} from "phoenix-colocated/my_app"

    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
    const liveSocket = new LiveSocket("/live", Socket, {
      longPollFallbackMs: 2500,
      params: {_csrf_token: csrfToken},
      hooks: {...colocatedHooks}
    })

    liveSocket.connect()\
    """
  end
end
