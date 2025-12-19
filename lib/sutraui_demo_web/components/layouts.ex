defmodule SutrauiDemoWeb.Layouts do
  @moduledoc """
  Layout components for Sutra UI documentation site.
  Refined editorial aesthetic.
  """
  use SutrauiDemoWeb, :html

  embed_templates "layouts/*"

  attr :flash, :map, required: true
  attr :current_scope, :map, default: nil
  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="min-h-screen" style="background: var(--bg); color: var(--fg);">
      <.site_header />
      <main>
        {render_slot(@inner_block)}
      </main>
      <.toast_container flash={@flash} />
    </div>
    """
  end

  attr :flash, :map, required: true
  attr :current_scope, :map, default: nil
  attr :current_path, :string, default: "/"
  slot :inner_block, required: true

  def docs(assigns) do
    ~H"""
    <div class="min-h-screen" style="background: var(--bg); color: var(--fg);">
      <.site_header />

      <div class="mx-auto max-w-6xl px-6">
        <div class="flex gap-16">
          <aside class="hidden lg:block w-56 shrink-0 py-12">
            <div class="sticky top-24">
              <.docs_sidebar current_path={@current_path} />
            </div>
          </aside>

          <main class="flex-1 min-w-0 py-12 lg:border-l" style="border-color: var(--border);">
            <article class="max-w-2xl lg:pl-12">
              {render_slot(@inner_block)}
            </article>
          </main>
        </div>
      </div>

      <.toast_container flash={@flash} />
    </div>
    """
  end

  def site_header(assigns) do
    ~H"""
    <header class="site-header sticky top-0 z-50">
      <div class="mx-auto max-w-6xl flex h-16 items-center justify-between px-6">
        <a href="/" class="site-logo">Sutra</a>

        <nav class="flex items-center gap-8">
          <a href="/docs" class="nav-link">Documentation</a>
          <a href="/docs/components/button" class="nav-link">Components</a>
          <.theme_toggle />
          <a
            href="https://github.com/sutra-ui/sutra_ui"
            target="_blank"
            class="nav-link"
            aria-label="GitHub"
          >
            <svg viewBox="0 0 24 24" class="w-5 h-5" fill="currentColor">
              <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z" />
            </svg>
          </a>
        </nav>
      </div>
    </header>
    """
  end

  def theme_toggle(assigns) do
    ~H"""
    <button
      type="button"
      phx-click={JS.dispatch("phx:toggle-theme")}
      class="nav-link"
      aria-label="Toggle theme"
    >
      <svg
        class="w-5 h-5 block dark:hidden"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="1.5"
      >
        <circle cx="12" cy="12" r="4" />
        <path d="M12 2v2M12 20v2M4.93 4.93l1.41 1.41M17.66 17.66l1.41 1.41M2 12h2M20 12h2M6.34 17.66l-1.41 1.41M19.07 4.93l-1.41 1.41" />
      </svg>
      <svg
        class="w-5 h-5 hidden dark:block"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="1.5"
      >
        <path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z" />
      </svg>
    </button>
    """
  end

  attr :current_path, :string, default: "/"

  def docs_sidebar(assigns) do
    ~H"""
    <nav class="space-y-10">
      <div>
        <h4 class="sidebar-title">Getting Started</h4>
        <div class="space-y-1">
          <.sidebar_link href="/docs" label="Introduction" current_path={@current_path} />
          <.sidebar_link href="/docs/installation" label="Installation" current_path={@current_path} />
          <.sidebar_link href="/docs/theming" label="Theming" current_path={@current_path} />
        </div>
      </div>

      <div>
        <h4 class="sidebar-title">Components</h4>
        <div class="space-y-1">
          <.sidebar_link href="/docs/components/button" label="Button" current_path={@current_path} />
          <.sidebar_link href="/docs/components/badge" label="Badge" current_path={@current_path} />
          <.sidebar_link href="/docs/components/card" label="Card" current_path={@current_path} />
          <.sidebar_link href="/docs/components/input" label="Input" current_path={@current_path} />
          <.sidebar_link href="/docs/components/select" label="Select" current_path={@current_path} />
          <.sidebar_link href="/docs/components/dialog" label="Dialog" current_path={@current_path} />
          <.sidebar_link href="/docs/components/toast" label="Toast" current_path={@current_path} />
          <.sidebar_link href="/docs/components/tabs" label="Tabs" current_path={@current_path} />
          <.sidebar_link href="/docs/components/table" label="Table" current_path={@current_path} />
          <.sidebar_link
            href="/docs/components/dropdown-menu"
            label="Dropdown Menu"
            current_path={@current_path}
          />
        </div>
      </div>
    </nav>
    """
  end

  defp sidebar_link(assigns) do
    active = assigns.current_path == assigns.href
    assigns = assign(assigns, :active, active)

    ~H"""
    <a href={@href} class={["sidebar-link", @active && "active"]}>
      {@label}
    </a>
    """
  end

  attr :flash, :map, required: true
  attr :id, :string, default: "flash-group"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <svg
          class="ml-1 w-3 h-3 inline animate-spin"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
        >
          <path d="M21 12a9 9 0 1 1-6.219-8.56" />
        </svg>
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <svg
          class="ml-1 w-3 h-3 inline animate-spin"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
        >
          <path d="M21 12a9 9 0 1 1-6.219-8.56" />
        </svg>
      </.flash>
    </div>
    """
  end
end
