defmodule SutrauiDemoWeb.Layouts do
  @moduledoc """
  Layout components for Sutra UI documentation site.
  Refined editorial aesthetic.
  """
  use SutrauiDemoWeb, :html

  embed_templates("layouts/*")

  defp sutra_version, do: "0.5"

  attr(:flash, :map, required: true)
  attr(:current_scope, :map, default: nil)
  attr(:sutra_commands, :map, default: nil)
  slot(:inner_block, required: true)

  def app(assigns) do
    ~H"""
    <div class="min-h-screen sx-919e9bd">
      <.site_header />
      <main>
        {render_slot(@inner_block)}
      </main>
      <.site_footer_widgets flash={@flash} sutra_commands={@sutra_commands} />
    </div>
    """
  end

  def search_button(assigns) do
    ~H"""
    <button
      type="button"
      class="search-trigger hidden sm:flex items-center gap-2 px-3 py-1.5 rounded-lg border text-sm transition-colors sx-8b32ffe"
      phx-click={SutraUI.Commands.Palette.show_palette("command-palette")}
    >
      <.icon name="lucide-search" class="size-4" />
      <span class="hidden md:inline">Search...</span>
      <kbd class="hidden md:inline-flex items-center gap-0.5 px-1.5 py-0.5 rounded text-xs font-mono sx-ad3ac6e">
        <span class="text-xs">⌘</span>K
      </kbd>
    </button>
    """
  end

  attr(:flash, :map, required: true)
  attr(:current_scope, :map, default: nil)
  attr(:current_path, :string, default: "/")
  attr(:sutra_commands, :map, default: nil)
  slot(:inner_block, required: true)

  def docs(assigns) do
    ~H"""
    <div class="min-h-screen sx-919e9bd">
      <.site_header show_menu_button={true} current_path={@current_path} />

      <div class="mx-auto max-w-6xl px-6">
        <div class="flex gap-16">
          <aside class="hidden lg:block w-56 shrink-0 py-12">
            <div class="sticky top-24 max-h-[calc(100vh-6rem)] overflow-y-auto scrollbar-hide">
              <.docs_drawer current_path={@current_path} />
            </div>
          </aside>

          <main class="flex-1 min-w-0 py-12 lg:border-l sx-635c873">
            <article class="max-w-2xl lg:pl-12">
              {render_slot(@inner_block)}
            </article>
          </main>
        </div>
      </div>

      <.mobile_drawer current_path={@current_path} />
      <.site_footer_widgets flash={@flash} sutra_commands={@sutra_commands} />
    </div>
    """
  end

  # Once per page: the command palette (mod+k), the toast stack and the data-confirm host.
  attr(:flash, :map, required: true)
  attr(:sutra_commands, :map, default: nil)

  def site_footer_widgets(assigns) do
    ~H"""
    <.command_palette
      id="command-palette"
      commands={@sutra_commands}
      actions={if is_nil(@sutra_commands), do: SutrauiDemoWeb.Commands.static_actions(), else: []}
      placeholder="Search the docs, or type a command..."
    />
    <.toast_group flash={@flash} live={not is_nil(@sutra_commands)} />
    <.confirm_host />
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
          <span class="hidden sm:inline-flex items-center rounded-md border border-border bg-muted/40 px-2 py-0.5 text-xs font-medium text-muted-foreground">
            v{sutra_version()}
          </span>
        </div>

        <nav class="flex items-center gap-6">
          <.link navigate="/docs" class="nav-link hidden sm:block">Documentation</.link>
          <.link navigate="/docs/components" class="nav-link hidden sm:block">
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

  def mobile_drawer(assigns) do
    ~H"""
    <div
      id="mobile-drawer"
      class="mobile-drawer-overlay fixed inset-0 z-50 hidden lg:hidden"
      phx-hook=".MobileDrawer"
    >
      <div
        class="mobile-drawer-backdrop absolute inset-0 opacity-0 transition-opacity duration-300 sx-9b3e851"
        data-drawer-backdrop
      >
      </div>

      <div
        class="mobile-drawer-panel absolute left-0 top-0 h-full w-72 -translate-x-full transition-transform duration-300 sx-a9d5122"
        data-drawer-panel
      >
        <div class="flex h-16 items-center justify-between px-6 border-b sx-635c873">
          <div class="flex items-center gap-2">
            <span class="site-logo">Sutra UI</span>
            <span class="inline-flex items-center rounded-md border border-border bg-muted/40 px-2 py-0.5 text-xs font-medium text-muted-foreground">
              v{sutra_version()}
            </span>
          </div>
          <button
            type="button"
            class="nav-link p-2 -mr-2"
            aria-label="Close menu"
            data-drawer-close
          >
            <.icon name="lucide-x" class="size-5" />
          </button>
        </div>

        <div class="px-6 py-8 overflow-y-auto sx-83b5951">
          <.docs_drawer current_path={@current_path} />
        </div>
      </div>
    </div>

    <script :type={Phoenix.LiveView.ColocatedHook} name=".MobileDrawer">
      export default {
        mounted() {
          const container = this.el;
          const backdrop = container.querySelector('[data-drawer-backdrop]');
          const panel = container.querySelector('[data-drawer-panel]');
          const closeBtn = container.querySelector('[data-drawer-close]');
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
        class="theme-dropdown absolute right-0 top-full mt-2 p-1.5 rounded-lg border hidden sx-8ebaeac"
        data-theme-dropdown
      >
        <div class="px-2 py-1.5 text-xs font-medium mb-1 sx-df5655f">
          Color Theme
        </div>
        <button
          :for={theme <- @themes}
          type="button"
          class="theme-option w-full flex items-center gap-2.5 px-2 py-1.5 rounded text-sm text-left transition-colors sx-69cf8f3"
          data-theme-value={theme.id}
        >
          <span class={["theme-dot w-3.5 h-3.5 rounded-full border", "theme-dot-#{theme.id}"]}></span>
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

  def docs_drawer(assigns) do
    assigns = assign(assigns, :nav_items, nav_items())

    ~H"""
    <nav class="space-y-10">
      <div :for={section <- @nav_items}>
        <h4 class="drawer-title">{section.group}</h4>
        <div class="space-y-1">
          <.drawer_link
            :for={item <- section.items}
            href={item.href}
            label={item.label}
            marker={item[:marker]}
            marker_emoji={item[:marker_emoji]}
            current_path={@current_path}
          />
        </div>
      </div>
    </nav>
    """
  end

  attr(:href, :string, required: true)
  attr(:label, :string, required: true)
  attr(:current_path, :string, required: true)
  attr(:marker, :string, default: nil)
  attr(:marker_emoji, :string, default: nil)

  defp drawer_link(assigns) do
    active = assigns.current_path == assigns.href
    assigns = assign(assigns, :active, active)

    ~H"""
    <.link
      navigate={@href}
      class={["drawer-link", @active && "active"]}
      phx-click={JS.dispatch("phx:close-mobile-menu")}
    >
      {@label}
      <span :if={@marker_emoji} class="ml-1 text-xs leading-none" aria-hidden="true">
        {@marker_emoji}
      </span>
      <span
        :if={@marker}
        class="ml-2 rounded-full bg-blue-500/10 px-1.5 py-0.5 text-[10px] font-medium leading-none text-blue-600 dark:text-blue-400"
      >
        {@marker}
      </span>
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
          label: "Date & Time Pickers",
          href: "/docs/components/date-picker",
          keywords: ["date", "calendar", "time", "datetime", "range", "zone", "picker"],
          marker: "New"
        },
        %{
          label: "Input",
          href: "/docs/components/input",
          keywords: ["text", "field", "form", "textbox"]
        },
        %{
          label: "Input OTP",
          href: "/docs/components/input-otp",
          keywords: ["otp", "pin", "mfa", "verification", "code"],
          marker: "New"
        },
        %{
          label: "File Upload",
          href: "/docs/components/file-upload",
          keywords: ["upload", "file", "dropzone", "phoenix", "allow_upload"],
          marker: "New"
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
          label: "Context Menu",
          href: "/docs/components/context-menu",
          keywords: ["right click", "context", "menu", "actions"],
          marker: "New"
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
        %{
          label: "URL Tabs",
          href: "/docs/components/url-tabs",
          keywords: ["tabs", "routes", "patch", "navigate", "live_action", "keep"],
          marker: "New"
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
          label: "Stepper",
          href: "/docs/components/stepper",
          keywords: ["steps", "wizard", "form", "checkout", "onboarding"],
          marker: "New"
        },
        %{
          label: "Tabs",
          href: "/docs/components/tabs",
          keywords: ["tab", "panel", "switch", "navigation"]
        },
        %{
          label: "Tree View",
          href: "/docs/components/tree-view",
          keywords: ["tree", "files", "hierarchy", "nested", "folders"],
          marker: "New"
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
          label: "Pagination",
          href: "/docs/components/pagination",
          keywords: ["pages", "page", "next", "previous", "navigation"]
        },
        %{
          label: "Drawer",
          href: "/docs/components/drawer",
          keywords: ["navigation", "menu", "drawer", "panel", "collapsible"]
        },
        %{
          label: "Tab Nav",
          href: "/docs/components/tab-nav",
          keywords: [
            "tabs",
            "navigation",
            "routed",
            "server-side",
            "pills",
            "responsive",
            "mobile"
          ]
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
          label: "Confirm",
          href: "/docs/components/confirm",
          keywords: ["confirmation", "data-confirm", "alert dialog", "are you sure", "delete"],
          marker: "New"
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
          label: "Command Palette",
          href: "/docs/components/command-palette",
          keywords: ["mod+k", "search", "actions", "shortcuts", "server", "spotlight"],
          marker: "New"
        },
        %{
          label: "Dialog",
          href: "/docs/components/dialog",
          keywords: ["modal", "popup", "overlay", "alert"]
        },
        %{
          label: "Hover Card",
          href: "/docs/components/hover-card",
          keywords: ["hover", "preview", "card", "tooltip"],
          marker: "New"
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
          label: "Calendar",
          href: "/docs/components/calendar",
          keywords: ["calendar", "date", "month", "day"],
          marker: "New"
        },
        %{
          label: "Marquee",
          href: "/docs/components/marquee",
          keywords: [
            "marquee",
            "scroll",
            "ticker",
            "animation",
            "banner",
            "announcement",
            "logos"
          ],
          marker: "New"
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
        },
        %{
          label: "Time",
          href: "/docs/components/time",
          keywords: ["relative", "ago", "local time", "zone", "clock", "date"],
          marker: "New"
        },
        %{
          label: "Timeline",
          href: "/docs/components/timeline",
          keywords: ["timeline", "activity", "events", "history"],
          marker: "New"
        }
      ]
    },
    %{
      group: "AI",
      items: [
        %{
          label: "Response",
          href: "/docs/components/response",
          keywords: ["ai", "markdown", "streaming", "response", "assistant"],
          marker: "New",
          marker_emoji: "🔥"
        },
        %{
          label: "Activity",
          href: "/docs/components/activity",
          keywords: ["ai", "activity", "agent", "progress", "status"],
          marker: "New",
          marker_emoji: "🔥"
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
          label: "Separator",
          href: "/docs/components/separator",
          keywords: ["divider", "hr", "line", "separator", "split"],
          marker: "New"
        },
        %{
          label: "Theme Switcher",
          href: "/docs/components/theme-switcher",
          keywords: ["theme", "dark", "light", "toggle", "mode"]
        }
      ]
    }
  ]

  def nav_items, do: @nav_items
end
