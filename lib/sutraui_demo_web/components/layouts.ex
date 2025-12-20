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
      <.command_palette />
      <.toast_container flash={@flash} />
    </div>
    """
  end

  def search_button(assigns) do
    ~H"""
    <button
      type="button"
      class="search-trigger hidden sm:flex items-center gap-2 px-3 py-1.5 rounded-lg border text-sm transition-colors"
      style="background: var(--bg-subtle); border-color: var(--border); color: var(--fg-muted);"
      phx-click={JS.dispatch("phx:open-command-palette")}
    >
      <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
        <circle cx="11" cy="11" r="8" /><path d="m21 21-4.3-4.3" />
      </svg>
      <span class="hidden md:inline">Search...</span>
      <kbd
        class="hidden md:inline-flex items-center gap-0.5 px-1.5 py-0.5 rounded text-xs font-mono"
        style="background: var(--bg-muted); color: var(--fg-muted);"
      >
        <span class="text-xs">⌘</span>K
      </kbd>
    </button>
    """
  end

  attr :flash, :map, required: true
  attr :current_scope, :map, default: nil
  attr :current_path, :string, default: "/"
  slot :inner_block, required: true

  def docs(assigns) do
    ~H"""
    <div class="min-h-screen" style="background: var(--bg); color: var(--fg);">
      <.site_header show_menu_button={true} current_path={@current_path} />

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

      <.mobile_sidebar current_path={@current_path} />
      <.command_palette />
      <.toast_container flash={@flash} />
    </div>
    """
  end

  attr :show_menu_button, :boolean, default: false
  attr :current_path, :string, default: "/"

  def site_header(assigns) do
    ~H"""
    <header class="site-header sticky top-0 z-50">
      <div class="mx-auto max-w-6xl flex h-16 items-center justify-between px-6">
        <div class="flex items-center gap-4">
          <button
            :if={@show_menu_button}
            type="button"
            class="lg:hidden nav-link -ml-2 p-2"
            aria-label="Open menu"
            phx-click={JS.dispatch("phx:open-mobile-menu")}
          >
            <svg
              class="w-5 h-5"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="1.5"
            >
              <path d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>
          <a href="/" class="site-logo">Sutra UI</a>
        </div>

        <nav class="flex items-center gap-6">
          <.link navigate="/docs" class="nav-link hidden sm:block">Documentation</.link>
          <.link navigate="/docs/components/button" class="nav-link hidden sm:block">
            Components
          </.link>
          <.search_button />
          <.color_theme_picker />
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

  attr :current_path, :string, default: "/"

  def mobile_sidebar(assigns) do
    ~H"""
    <div
      id="mobile-sidebar"
      class="mobile-sidebar-overlay fixed inset-0 z-50 hidden lg:hidden"
      phx-hook=".MobileSidebar"
    >
      <div
        class="mobile-sidebar-backdrop absolute inset-0 opacity-0 transition-opacity duration-300"
        style="background: rgba(0, 0, 0, 0.5);"
        data-sidebar-backdrop
      >
      </div>

      <div
        class="mobile-sidebar-panel absolute left-0 top-0 h-full w-72 -translate-x-full transition-transform duration-300"
        style="background: var(--bg); border-right: 1px solid var(--border);"
        data-sidebar-panel
      >
        <div
          class="flex h-16 items-center justify-between px-6 border-b"
          style="border-color: var(--border);"
        >
          <span class="site-logo">Sutra UI</span>
          <button
            type="button"
            class="nav-link p-2 -mr-2"
            aria-label="Close menu"
            data-sidebar-close
          >
            <svg
              class="w-5 h-5"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="1.5"
            >
              <path d="M18 6L6 18M6 6l12 12" />
            </svg>
          </button>
        </div>

        <div class="px-6 py-8 overflow-y-auto" style="height: calc(100% - 4rem);">
          <.docs_sidebar current_path={@current_path} />
        </div>
      </div>
    </div>

    <script :type={Phoenix.LiveView.ColocatedHook} name=".MobileSidebar">
      export default {
        mounted() {
          const container = this.el;
          const backdrop = container.querySelector('[data-sidebar-backdrop]');
          const panel = container.querySelector('[data-sidebar-panel]');
          const closeBtn = container.querySelector('[data-sidebar-close]');
          let isOpen = false;

          const open = () => {
            if (isOpen) return;
            isOpen = true;
            container.classList.remove('hidden');
            // Trigger animation after display change
            requestAnimationFrame(() => {
              backdrop.classList.add('opacity-100');
              backdrop.classList.remove('opacity-0');
              panel.classList.remove('-translate-x-full');
            });
            document.body.style.overflow = 'hidden';
          };

          const close = () => {
            if (!isOpen) return;
            isOpen = false;
            backdrop.classList.remove('opacity-100');
            backdrop.classList.add('opacity-0');
            panel.classList.add('-translate-x-full');
            document.body.style.overflow = '';
            setTimeout(() => {
              container.classList.add('hidden');
            }, 300);
          };

          // Immediate close for navigation (no animation delay)
          const closeImmediate = () => {
            if (!isOpen) return;
            isOpen = false;
            document.body.style.overflow = '';
            container.classList.add('hidden');
            backdrop.classList.remove('opacity-100');
            backdrop.classList.add('opacity-0');
            panel.classList.add('-translate-x-full');
          };

          // Listen for open/close events
          window.addEventListener('phx:open-mobile-menu', open);
          window.addEventListener('phx:close-mobile-menu', closeImmediate);

          // Close handlers
          closeBtn.addEventListener('click', close);
          backdrop.addEventListener('click', close);

          const handleKeydown = (e) => {
            if (e.key === 'Escape' && isOpen) {
              close();
            }
          };
          document.addEventListener('keydown', handleKeydown);
          
          // Clean up
          this.destroy = () => {
            // Always restore body overflow on destroy
            document.body.style.overflow = '';
            window.removeEventListener('phx:open-mobile-menu', open);
            window.removeEventListener('phx:close-mobile-menu', closeImmediate);
            document.removeEventListener('keydown', handleKeydown);
          };
        },
        destroyed() {
          if (this.destroy) this.destroy();
        }
      }
    </script>
    """
  end

  @themes [
    %{id: "neutral", label: "Neutral", color: "#737373"},
    %{id: "blue", label: "Blue", color: "#3b82f6"},
    %{id: "green", label: "Green", color: "#22c55e"},
    %{id: "rose", label: "Rose", color: "#f43f5e"},
    %{id: "orange", label: "Orange", color: "#f97316"},
    %{id: "violet", label: "Violet", color: "#8b5cf6"}
  ]

  def color_theme_picker(assigns) do
    assigns = assign(assigns, :themes, @themes)

    ~H"""
    <div id="theme-switcher" phx-hook=".ThemeSwitcher" class="relative">
      <button
        type="button"
        class="nav-link flex items-center gap-1.5"
        aria-label="Change color theme"
        aria-haspopup="true"
        data-theme-trigger
      >
        <svg
          class="w-4 h-4"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="1.5"
        >
          <circle cx="12" cy="12" r="10" />
          <path d="M12 2a10 10 0 0 1 0 20" fill="currentColor" />
        </svg>
        <svg class="w-3 h-3 opacity-60" viewBox="0 0 12 12" fill="currentColor">
          <path d="M2.5 4.5L6 8l3.5-3.5" fill="none" stroke="currentColor" stroke-width="1.5" />
        </svg>
      </button>

      <div
        class="theme-dropdown absolute right-0 top-full mt-2 p-1.5 rounded-lg border hidden"
        style="background: var(--bg-elevated); border-color: var(--border); min-width: 140px; box-shadow: 0 10px 40px rgba(0,0,0,0.1);"
        data-theme-dropdown
      >
        <div
          class="px-2 py-1.5 text-xs font-medium mb-1"
          style="color: var(--fg-muted); font-family: var(--font-mono);"
        >
          Color Theme
        </div>
        <button
          :for={theme <- @themes}
          type="button"
          class="theme-option w-full flex items-center gap-2.5 px-2 py-1.5 rounded text-sm text-left transition-colors"
          style="color: var(--fg-secondary);"
          data-theme-value={theme.id}
        >
          <span
            class="w-3.5 h-3.5 rounded-full border"
            style={"background: #{theme.color}; border-color: color-mix(in srgb, #{theme.color} 70%, black);"}
          >
          </span>
          {theme.label}
          <svg
            class="theme-check ml-auto w-4 h-4 hidden"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
          >
            <path d="M5 12l5 5L20 7" />
          </svg>
        </button>
      </div>
    </div>

    <script :type={Phoenix.LiveView.ColocatedHook} name=".ThemeSwitcher">
      export default {
        mounted() {
          const container = this.el;
          const trigger = container.querySelector('[data-theme-trigger]');
          const dropdown = container.querySelector('[data-theme-dropdown]');
          const options = container.querySelectorAll('.theme-option');

          // Update checkmark for current theme
          const updateCheck = () => {
            const current = localStorage.getItem('phx:color-theme') || 'neutral';
            options.forEach(opt => {
              const check = opt.querySelector('.theme-check');
              if (opt.dataset.themeValue === current) {
                check.classList.remove('hidden');
                opt.style.color = 'var(--fg)';
                opt.style.background = 'var(--bg-subtle)';
              } else {
                check.classList.add('hidden');
                opt.style.color = 'var(--fg-secondary)';
                opt.style.background = 'transparent';
              }
            });
          };

          updateCheck();

          // Toggle dropdown
          trigger.addEventListener('click', (e) => {
            e.stopPropagation();
            dropdown.classList.toggle('hidden');
            updateCheck();
          });

          // Select theme
          options.forEach(opt => {
            opt.addEventListener('click', () => {
              const theme = opt.dataset.themeValue;
              window.dispatchEvent(new CustomEvent('phx:set-color-theme', { detail: { theme } }));
              dropdown.classList.add('hidden');
              updateCheck();
            });

            // Hover state
            opt.addEventListener('mouseenter', () => {
              if (!opt.querySelector('.theme-check').classList.contains('hidden')) return;
              opt.style.background = 'var(--bg-subtle)';
            });
            opt.addEventListener('mouseleave', () => {
              if (!opt.querySelector('.theme-check').classList.contains('hidden')) return;
              opt.style.background = 'transparent';
            });
          });

          // Close on outside click
          document.addEventListener('click', (e) => {
            if (!container.contains(e.target)) {
              dropdown.classList.add('hidden');
            }
          });

          // Close on escape
          document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
              dropdown.classList.add('hidden');
            }
          });
        }
      }
    </script>
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
    <.link
      navigate={@href}
      class={["sidebar-link", @active && "active"]}
      phx-click={JS.dispatch("phx:close-mobile-menu")}
    >
      {@label}
    </.link>
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

  @nav_items [
    %{
      group: "Getting Started",
      items: [
        %{
          label: "Introduction",
          href: "/docs",
          keywords: ["intro", "overview", "about", "start"]
        },
        %{
          label: "Installation",
          href: "/docs/installation",
          keywords: ["setup", "install", "config", "getting started"]
        },
        %{
          label: "Theming",
          href: "/docs/theming",
          keywords: ["theme", "colors", "dark mode", "light mode", "customize"]
        }
      ]
    },
    %{
      group: "Components",
      items: [
        %{
          label: "Button",
          href: "/docs/components/button",
          keywords: ["btn", "click", "action", "submit"]
        },
        %{
          label: "Badge",
          href: "/docs/components/badge",
          keywords: ["tag", "label", "status", "indicator"]
        },
        %{label: "Card", href: "/docs/components/card", keywords: ["container", "box", "panel"]},
        %{
          label: "Input",
          href: "/docs/components/input",
          keywords: ["text", "field", "form", "textbox"]
        },
        %{
          label: "Select",
          href: "/docs/components/select",
          keywords: ["dropdown", "picker", "choice", "option"]
        },
        %{
          label: "Dialog",
          href: "/docs/components/dialog",
          keywords: ["modal", "popup", "overlay", "alert"]
        },
        %{
          label: "Toast",
          href: "/docs/components/toast",
          keywords: ["notification", "message", "alert", "snackbar"]
        },
        %{
          label: "Tabs",
          href: "/docs/components/tabs",
          keywords: ["tab", "panel", "switch", "navigation"]
        },
        %{
          label: "Table",
          href: "/docs/components/table",
          keywords: ["data", "grid", "list", "rows"]
        },
        %{
          label: "Dropdown Menu",
          href: "/docs/components/dropdown-menu",
          keywords: ["menu", "context", "actions", "popover"]
        }
      ]
    }
  ]

  def command_palette(assigns) do
    assigns = assign(assigns, :nav_items, @nav_items)

    ~H"""
    <.command_dialog id="cmd-palette" placeholder="Search documentation...">
      <.command_group :for={section <- @nav_items} heading={section.group}>
        <.command_item
          :for={item <- section.items}
          id={"cmd-#{item.label |> String.downcase() |> String.replace(" ", "-")}"}
          keywords={item.keywords}
          phx-click={JS.navigate(item.href)}
        >
          <svg
            class="w-4 h-4 opacity-60"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="1.5"
          >
            <path d="M9 12h6M12 9v6M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0z" />
          </svg>
          {item.label}
        </.command_item>
      </.command_group>
    </.command_dialog>

    <div id="cmd-k-listener" phx-hook=".CommandPalette"></div>

    <script :type={Phoenix.LiveView.ColocatedHook} name=".CommandPalette">
      export default {
        mounted() {
          const openPalette = () => {
            const dialog = document.getElementById('cmd-palette');
            if (dialog) {
              dialog.showModal();
              const input = dialog.querySelector('input');
              if (input) {
                input.focus();
                input.value = '';
              }
            }
          };

          const handleKeydown = (e) => {
            // Cmd+K (Mac) or Ctrl+K (Windows/Linux)
            if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
              e.preventDefault();
              openPalette();
            }
          };

          document.addEventListener('keydown', handleKeydown);
          window.addEventListener('phx:open-command-palette', openPalette);

          // Close dialog on item selection (navigation)
          const dialog = document.getElementById('cmd-palette');
          if (dialog) {
            dialog.addEventListener('click', (e) => {
              const item = e.target.closest('[role="menuitem"]');
              if (item) {
                dialog.close();
              }
            });

            // Close on backdrop click
            dialog.addEventListener('click', (e) => {
              if (e.target === dialog) {
                dialog.close();
              }
            });

            // Close on Escape
            dialog.addEventListener('keydown', (e) => {
              if (e.key === 'Escape') {
                dialog.close();
              }
            });
          }

          this.destroy = () => {
            document.removeEventListener('keydown', handleKeydown);
            window.removeEventListener('phx:open-command-palette', openPalette);
          };
        },
        destroyed() {
          if (this.destroy) this.destroy();
        }
      }
    </script>
    """
  end
end
