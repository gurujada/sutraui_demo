defmodule SutrauiDemoWeb.Layouts do
  @moduledoc """
  Layout components for Sutra UI documentation site.
  Refined editorial aesthetic.
  """
  use SutrauiDemoWeb, :html

  embed_templates("layouts/*")

  attr(:flash, :map, required: true)
  attr(:current_scope, :map, default: nil)
  slot(:inner_block, required: true)

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
      <.icon name="lucide-search" class="size-4" />
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

  attr(:flash, :map, required: true)
  attr(:current_scope, :map, default: nil)
  attr(:current_path, :string, default: "/")
  slot(:inner_block, required: true)

  def docs(assigns) do
    ~H"""
    <div class="min-h-screen" style="background: var(--bg); color: var(--fg);">
      <.site_header show_menu_button={true} current_path={@current_path} />

      <div class="mx-auto max-w-6xl px-6">
        <div class="flex gap-16">
          <aside class="hidden lg:block w-56 shrink-0 py-12">
            <div class="sticky top-24 max-h-[calc(100vh-6rem)] overflow-y-auto scrollbar-hide">
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

  attr(:show_menu_button, :boolean, default: false)
  attr(:current_path, :string, default: "/")

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
            <.icon name="lucide-menu" class="size-5" />
          </button>
          <a href="/" class="site-logo">Sutra UI</a>
        </div>

        <nav class="flex items-center gap-6">
          <.link navigate="/docs" class="nav-link hidden sm:block">Documentation</.link>
          <.link navigate="/docs/components/checkbox" class="nav-link hidden sm:block">
            Components
          </.link>
          <.search_button />
          <.color_theme_picker />
          <.theme_toggle />
          <a
            href="https://github.com/gurujada/sutra_ui"
            target="_blank"
            class="nav-link"
            aria-label="GitHub"
          >
            <.icon name="lucide-github" class="size-5" />
          </a>
        </nav>
      </div>
    </header>
    """
  end

  attr(:current_path, :string, default: "/")

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
            <.icon name="lucide-x" class="size-5" />
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
    <div id="color-theme-picker" phx-hook=".ColorThemePicker" class="relative">
      <button
        type="button"
        class="nav-link flex items-center gap-1.5"
        aria-label="Change color theme"
        aria-haspopup="true"
        data-theme-trigger
      >
        <.icon name="lucide-palette" class="size-4" />
        <.icon name="lucide-chevron-down" class="size-3 opacity-60" />
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
          <.icon name="lucide-check" class="theme-check ml-auto size-4 hidden" />
        </button>
      </div>
    </div>

    <script :type={Phoenix.LiveView.ColocatedHook} name=".ColorThemePicker">
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
      <.icon name="lucide-sun" class="size-5 block dark:hidden" />
      <.icon name="lucide-moon" class="size-5 hidden dark:block" />
    </button>
    """
  end

  attr(:current_path, :string, default: "/")

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

      <%!-- Form Inputs --%>
      <div>
        <h4 class="sidebar-title">Form Inputs</h4>
        <div class="space-y-1">
          <.sidebar_link
            href="/docs/components/checkbox"
            label="Checkbox"
            current_path={@current_path}
          />
          <.sidebar_link href="/docs/components/input" label="Input" current_path={@current_path} />
          <.sidebar_link
            href="/docs/components/input-group"
            label="Input Group"
            current_path={@current_path}
          />
          <.sidebar_link href="/docs/components/label" label="Label" current_path={@current_path} />
          <.sidebar_link
            href="/docs/components/live-select"
            label="Live Select"
            current_path={@current_path}
          />
          <.sidebar_link
            href="/docs/components/radio-group"
            label="Radio Group"
            current_path={@current_path}
          />
          <.sidebar_link
            href="/docs/components/range-slider"
            label="Range Slider"
            current_path={@current_path}
          />
          <.sidebar_link href="/docs/components/select" label="Select" current_path={@current_path} />
          <.sidebar_link href="/docs/components/slider" label="Slider" current_path={@current_path} />
          <.sidebar_link href="/docs/components/switch" label="Switch" current_path={@current_path} />
          <.sidebar_link
            href="/docs/components/textarea"
            label="Textarea"
            current_path={@current_path}
          />
        </div>
      </div>

      <%!-- Buttons & Actions --%>
      <div>
        <h4 class="sidebar-title">Buttons & Actions</h4>
        <div class="space-y-1">
          <.sidebar_link href="/docs/components/button" label="Button" current_path={@current_path} />
          <.sidebar_link
            href="/docs/components/dropdown-menu"
            label="Dropdown Menu"
            current_path={@current_path}
          />
        </div>
      </div>

      <%!-- Layout --%>
      <div>
        <h4 class="sidebar-title">Layout</h4>
        <div class="space-y-1">
          <.sidebar_link
            href="/docs/components/accordion"
            label="Accordion"
            current_path={@current_path}
          />
          <.sidebar_link href="/docs/components/card" label="Card" current_path={@current_path} />
          <.sidebar_link
            href="/docs/components/filter-bar"
            label="Filter Bar"
            current_path={@current_path}
          />
          <.sidebar_link href="/docs/components/header" label="Header" current_path={@current_path} />
          <.sidebar_link
            href="/docs/components/simple-form"
            label="Simple Form"
            current_path={@current_path}
          />
          <.sidebar_link href="/docs/components/tabs" label="Tabs" current_path={@current_path} />
        </div>
      </div>

      <%!-- Navigation --%>
      <div>
        <h4 class="sidebar-title">Navigation</h4>
        <div class="space-y-1">
          <.sidebar_link
            href="/docs/components/breadcrumb"
            label="Breadcrumb"
            current_path={@current_path}
          />
          <.sidebar_link
            href="/docs/components/nav-pills"
            label="Nav Pills"
            current_path={@current_path}
          />
          <.sidebar_link
            href="/docs/components/pagination"
            label="Pagination"
            current_path={@current_path}
          />
          <.sidebar_link href="/docs/components/sidebar" label="Sidebar" current_path={@current_path} />
          <.sidebar_link href="/docs/components/tab-nav" label="Tab Nav" current_path={@current_path} />
        </div>
      </div>

      <%!-- Feedback --%>
      <div>
        <h4 class="sidebar-title">Feedback</h4>
        <div class="space-y-1">
          <.sidebar_link href="/docs/components/alert" label="Alert" current_path={@current_path} />
          <.sidebar_link href="/docs/components/empty" label="Empty" current_path={@current_path} />
          <.sidebar_link href="/docs/components/flash" label="Flash" current_path={@current_path} />
          <.sidebar_link
            href="/docs/components/loading-state"
            label="Loading State"
            current_path={@current_path}
          />
          <.sidebar_link
            href="/docs/components/progress"
            label="Progress"
            current_path={@current_path}
          />
          <.sidebar_link
            href="/docs/components/skeleton"
            label="Skeleton"
            current_path={@current_path}
          />
          <.sidebar_link href="/docs/components/spinner" label="Spinner" current_path={@current_path} />
          <.sidebar_link href="/docs/components/toast" label="Toast" current_path={@current_path} />
        </div>
      </div>

      <%!-- Overlays --%>
      <div>
        <h4 class="sidebar-title">Overlays</h4>
        <div class="space-y-1">
          <.sidebar_link href="/docs/components/command" label="Command" current_path={@current_path} />
          <.sidebar_link href="/docs/components/dialog" label="Dialog" current_path={@current_path} />
          <.sidebar_link href="/docs/components/popover" label="Popover" current_path={@current_path} />
          <.sidebar_link href="/docs/components/tooltip" label="Tooltip" current_path={@current_path} />
        </div>
      </div>

      <%!-- Data Display --%>
      <div>
        <h4 class="sidebar-title">Data Display</h4>
        <div class="space-y-1">
          <.sidebar_link href="/docs/components/avatar" label="Avatar" current_path={@current_path} />
          <.sidebar_link href="/docs/components/badge" label="Badge" current_path={@current_path} />
          <.sidebar_link
            href="/docs/components/carousel"
            label="Carousel"
            current_path={@current_path}
          />
          <.sidebar_link href="/docs/components/item" label="Item" current_path={@current_path} />
          <.sidebar_link href="/docs/components/table" label="Table" current_path={@current_path} />
        </div>
      </div>

      <%!-- Utilities --%>
      <div>
        <h4 class="sidebar-title">Utilities</h4>
        <div class="space-y-1">
          <.sidebar_link href="/docs/components/kbd" label="Kbd" current_path={@current_path} />
          <.sidebar_link
            href="/docs/components/theme-switcher"
            label="Theme Switcher"
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

  attr(:flash, :map, required: true)
  attr(:id, :string, default: "flash-group")

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
        <.icon name="lucide-loader-2" class="ml-1 size-3 inline animate-spin" />
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
        <.icon name="lucide-loader-2" class="ml-1 size-3 inline animate-spin" />
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
      group: "Form Inputs",
      items: [
        %{
          label: "Checkbox",
          href: "/docs/components/checkbox",
          keywords: ["check", "tick", "toggle", "boolean"]
        },
        %{
          label: "Input",
          href: "/docs/components/input",
          keywords: ["text", "field", "form", "textbox"]
        },
        %{
          label: "Input Group",
          href: "/docs/components/input-group",
          keywords: ["prefix", "suffix", "addon", "icon"]
        },
        %{
          label: "Label",
          href: "/docs/components/label",
          keywords: ["form", "input", "text", "accessibility"]
        },
        %{
          label: "Live Select",
          href: "/docs/components/live-select",
          keywords: ["search", "autocomplete", "tags", "multi-select", "combobox"]
        },
        %{
          label: "Radio Group",
          href: "/docs/components/radio-group",
          keywords: ["radio", "option", "choice", "single"]
        },
        %{
          label: "Range Slider",
          href: "/docs/components/range-slider",
          keywords: ["range", "dual", "min", "max", "filter"]
        },
        %{
          label: "Select",
          href: "/docs/components/select",
          keywords: ["dropdown", "picker", "choice", "option"]
        },
        %{
          label: "Slider",
          href: "/docs/components/slider",
          keywords: ["range", "value", "number", "adjust"]
        },
        %{
          label: "Switch",
          href: "/docs/components/switch",
          keywords: ["toggle", "on", "off", "boolean"]
        },
        %{
          label: "Textarea",
          href: "/docs/components/textarea",
          keywords: ["text", "multiline", "paragraph", "long"]
        }
      ]
    },
    %{
      group: "Buttons & Actions",
      items: [
        %{
          label: "Button",
          href: "/docs/components/button",
          keywords: ["btn", "click", "action", "submit"]
        },
        %{
          label: "Dropdown Menu",
          href: "/docs/components/dropdown-menu",
          keywords: ["menu", "context", "actions", "popover"]
        }
      ]
    },
    %{
      group: "Layout",
      items: [
        %{
          label: "Accordion",
          href: "/docs/components/accordion",
          keywords: ["collapse", "expand", "faq", "sections", "disclosure"]
        },
        %{label: "Card", href: "/docs/components/card", keywords: ["container", "box", "panel"]},
        %{
          label: "Filter Bar",
          href: "/docs/components/filter-bar",
          keywords: ["filter", "search", "form", "index", "list"]
        },
        %{
          label: "Header",
          href: "/docs/components/header",
          keywords: ["page", "title", "subtitle", "actions"]
        },
        %{
          label: "Simple Form",
          href: "/docs/components/simple-form",
          keywords: ["form", "auto", "styling", "wrapper"]
        },
        %{
          label: "Tabs",
          href: "/docs/components/tabs",
          keywords: ["tab", "panel", "switch", "navigation"]
        }
      ]
    },
    %{
      group: "Navigation",
      items: [
        %{
          label: "Breadcrumb",
          href: "/docs/components/breadcrumb",
          keywords: ["navigation", "path", "hierarchy", "trail", "links"]
        },
        %{
          label: "Nav Pills",
          href: "/docs/components/nav-pills",
          keywords: ["navigation", "pills", "tabs", "responsive", "mobile"]
        },
        %{
          label: "Pagination",
          href: "/docs/components/pagination",
          keywords: ["pages", "page", "next", "previous", "navigation"]
        },
        %{
          label: "Sidebar",
          href: "/docs/components/sidebar",
          keywords: ["navigation", "menu", "drawer", "panel", "collapsible"]
        },
        %{
          label: "Tab Nav",
          href: "/docs/components/tab-nav",
          keywords: ["tabs", "navigation", "routed", "server-side"]
        }
      ]
    },
    %{
      group: "Feedback",
      items: [
        %{
          label: "Alert",
          href: "/docs/components/alert",
          keywords: ["warning", "error", "info", "message", "banner"]
        },
        %{
          label: "Empty",
          href: "/docs/components/empty",
          keywords: ["empty state", "placeholder", "no data", "blank"]
        },
        %{
          label: "Flash",
          href: "/docs/components/flash",
          keywords: ["notification", "message", "alert", "feedback"]
        },
        %{
          label: "Loading State",
          href: "/docs/components/loading-state",
          keywords: ["loading", "spinner", "wait", "fetch"]
        },
        %{
          label: "Progress",
          href: "/docs/components/progress",
          keywords: ["progress bar", "loading", "percentage", "completion"]
        },
        %{
          label: "Skeleton",
          href: "/docs/components/skeleton",
          keywords: ["loading", "placeholder", "shimmer", "content loader"]
        },
        %{
          label: "Spinner",
          href: "/docs/components/spinner",
          keywords: ["loading", "loader", "spin", "waiting"]
        },
        %{
          label: "Toast",
          href: "/docs/components/toast",
          keywords: ["notification", "message", "alert", "snackbar"]
        }
      ]
    },
    %{
      group: "Overlays",
      items: [
        %{
          label: "Command",
          href: "/docs/components/command",
          keywords: ["palette", "search", "cmdk", "spotlight", "keyboard"]
        },
        %{
          label: "Dialog",
          href: "/docs/components/dialog",
          keywords: ["modal", "popup", "overlay", "alert"]
        },
        %{
          label: "Popover",
          href: "/docs/components/popover",
          keywords: ["popup", "dropdown", "floating", "overlay"]
        },
        %{
          label: "Tooltip",
          href: "/docs/components/tooltip",
          keywords: ["hint", "hover", "info", "help"]
        }
      ]
    },
    %{
      group: "Data Display",
      items: [
        %{
          label: "Avatar",
          href: "/docs/components/avatar",
          keywords: ["user", "profile", "image", "initials", "picture"]
        },
        %{
          label: "Badge",
          href: "/docs/components/badge",
          keywords: ["tag", "label", "status", "indicator"]
        },
        %{
          label: "Carousel",
          href: "/docs/components/carousel",
          keywords: ["slider", "slideshow", "gallery", "scroll", "snap"]
        },
        %{
          label: "Item",
          href: "/docs/components/item",
          keywords: ["list", "row", "card", "leading", "trailing"]
        },
        %{
          label: "Table",
          href: "/docs/components/table",
          keywords: ["data", "grid", "list", "rows"]
        }
      ]
    },
    %{
      group: "Utilities",
      items: [
        %{
          label: "Kbd",
          href: "/docs/components/kbd",
          keywords: ["keyboard", "shortcut", "key", "hotkey", "keybinding"]
        },
        %{
          label: "Theme Switcher",
          href: "/docs/components/theme-switcher",
          keywords: ["theme", "dark", "light", "toggle", "mode"]
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
          <.icon name="lucide-file-text" class="size-4 opacity-60" />
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
