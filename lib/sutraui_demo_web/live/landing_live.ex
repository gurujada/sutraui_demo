defmodule SutrauiDemoWeb.LandingLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <%!-- Hero - editorial, spacious --%>
      <section class="hero-section min-h-[90vh] flex items-center relative">
        <%!-- Decorative typography --%>
        <div class="hero-decoration -right-20 top-1/4">S</div>

        <div class="mx-auto max-w-6xl px-6 w-full relative z-10">
          <div class="max-w-2xl animate-fade-up">
            <p class="hero-eyebrow mb-6">Phoenix LiveView Components</p>
            <h1 class="hero-title">
              Build <em>beautiful</em> interfaces with pure Phoenix
            </h1>
            <p class="hero-subtitle mt-8">
              A carefully crafted collection of accessible, themeable components.
              No JavaScript dependencies. Just copy, paste, and make it yours.
            </p>
            <div class="flex flex-wrap gap-4 mt-10">
              <.button navigate="/docs">Get Started</.button>
              <.button variant="outline" navigate="/docs/components/button">
                Browse Components
              </.button>
            </div>
          </div>
        </div>
      </section>

      <%!-- Features - grid with numbers --%>
      <section class="py-0">
        <div class="mx-auto max-w-6xl">
          <div class="feature-grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4">
            <div class="feature-card animate-fade-up">
              <div class="feature-number">01</div>
              <h3 class="feature-title">Zero Dependencies</h3>
              <p class="feature-description">
                Pure LiveView with colocated hooks. No npm packages, no bundler headaches.
              </p>
            </div>
            <div class="feature-card animate-fade-up delay-1">
              <div class="feature-number">02</div>
              <h3 class="feature-title">Fully Accessible</h3>
              <p class="feature-description">
                WCAG 2.1 AA compliant. Keyboard navigation and screen readers built in.
              </p>
            </div>
            <div class="feature-card animate-fade-up delay-2">
              <div class="feature-number">03</div>
              <h3 class="feature-title">Themeable</h3>
              <p class="feature-description">
                CSS variables for complete control. Light and dark modes out of the box.
              </p>
            </div>
            <div class="feature-card animate-fade-up delay-3">
              <div class="feature-number">04</div>
              <h3 class="feature-title">Own Your Code</h3>
              <p class="feature-description">
                Copy components into your project. No runtime dependency, just source code.
              </p>
            </div>
          </div>
        </div>
      </section>

      <%!-- Installation - clean, focused --%>
      <section class="py-32">
        <div class="mx-auto max-w-6xl px-6">
          <div class="grid lg:grid-cols-2 gap-16 items-center">
            <div class="animate-fade-up">
              <p class="section-label">Quick Start</p>
              <h2 class="section-title mt-2">Add to your Phoenix project</h2>
              <p class="section-subtitle mt-4">
                One dependency. Run the installer. Start building.
                Components are copied to your project so you own every line.
              </p>
              <.button variant="outline" navigate="/docs/installation" class="mt-8">
                Read the full guide
              </.button>
            </div>
            <div class="animate-fade-up delay-2">
              <div class="install-code">
                <div class="install-code-header">mix.exs</div>
                <pre phx-no-curly-interpolation><code>defp deps do
    [
    {:sutra_ui, "~> 0.1"}
    ]
    end</code></pre>
              </div>
            </div>
          </div>
        </div>
      </section>

      <%!-- Component Showcase --%>
      <section class="py-32" style="background: var(--bg-subtle);">
        <div class="mx-auto max-w-6xl px-6">
          <div class="flex flex-col lg:flex-row lg:items-end lg:justify-between gap-6 mb-16">
            <div class="animate-fade-up">
              <p class="section-label">Components</p>
              <h2 class="section-title mt-2">Production-ready UI</h2>
              <p class="section-subtitle mt-4">
                Every component is designed for real applications.
                Accessible, composable, and beautifully crafted.
              </p>
            </div>
            <div class="animate-fade-up delay-1">
              <.button variant="outline" navigate="/docs/components/button">
                View all components
              </.button>
            </div>
          </div>

          <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            <%!-- Button --%>
            <div class="showcase-card animate-fade-up">
              <div class="showcase-preview">
                <div class="flex flex-wrap gap-3">
                  <.button>Primary</.button>
                  <.button variant="secondary">Secondary</.button>
                  <.button variant="outline">Outline</.button>
                </div>
              </div>
              <div class="showcase-footer">
                <span class="showcase-name">Button</span>
                <.link navigate="/docs/components/button" class="showcase-link">
                  View <span>→</span>
                </.link>
              </div>
            </div>

            <%!-- Badge --%>
            <div class="showcase-card animate-fade-up delay-1">
              <div class="showcase-preview">
                <div class="flex flex-wrap gap-2">
                  <.badge>Default</.badge>
                  <.badge variant="secondary">Secondary</.badge>
                  <.badge variant="success">Success</.badge>
                  <.badge variant="destructive">Error</.badge>
                </div>
              </div>
              <div class="showcase-footer">
                <span class="showcase-name">Badge</span>
                <.link navigate="/docs/components/badge" class="showcase-link">
                  View <span>→</span>
                </.link>
              </div>
            </div>

            <%!-- Input --%>
            <div class="showcase-card animate-fade-up delay-2">
              <div class="showcase-preview">
                <div class="w-full max-w-xs">
                  <.input type="email" placeholder="you@example.com" label="Email address" />
                </div>
              </div>
              <div class="showcase-footer">
                <span class="showcase-name">Input</span>
                <.link navigate="/docs/components/input" class="showcase-link">
                  View <span>→</span>
                </.link>
              </div>
            </div>

            <%!-- Tabs --%>
            <div class="showcase-card animate-fade-up delay-3">
              <div class="showcase-preview">
                <div class="w-full">
                  <.tabs id="landing-tabs" default_value="account">
                    <:tab value="account">Account</:tab>
                    <:tab value="settings">Settings</:tab>
                    <:panel value="account">
                      <p class="text-sm py-3" style="color: var(--fg-muted);">
                        Manage your account details and preferences.
                      </p>
                    </:panel>
                    <:panel value="settings">
                      <p class="text-sm py-3" style="color: var(--fg-muted);">
                        Configure application settings here.
                      </p>
                    </:panel>
                  </.tabs>
                </div>
              </div>
              <div class="showcase-footer">
                <span class="showcase-name">Tabs</span>
                <.link navigate="/docs/components/tabs" class="showcase-link">
                  View <span>→</span>
                </.link>
              </div>
            </div>

            <%!-- Card --%>
            <div class="showcase-card animate-fade-up delay-4">
              <div class="showcase-preview">
                <.card class="w-full max-w-xs">
                  <:header>
                    <p class="font-medium">Notifications</p>
                    <p class="text-sm" style="color: var(--fg-muted);">You have 3 unread messages</p>
                  </:header>
                  <:content>
                    <p class="text-sm" style="color: var(--fg-secondary);">
                      Configure how you receive notifications.
                    </p>
                  </:content>
                </.card>
              </div>
              <div class="showcase-footer">
                <span class="showcase-name">Card</span>
                <.link navigate="/docs/components/card" class="showcase-link">
                  View <span>→</span>
                </.link>
              </div>
            </div>

            <%!-- Dialog --%>
            <div class="showcase-card animate-fade-up delay-5">
              <div class="showcase-preview">
                <.button phx-click={SutraUI.Dialog.show_dialog("landing-dialog")} variant="outline">
                  Open Dialog
                </.button>
                <.dialog id="landing-dialog">
                  <:title>Confirm your action</:title>
                  <:description>
                    This action cannot be undone. Are you sure you want to continue?
                  </:description>
                  <:footer>
                    <.button
                      variant="outline"
                      phx-click={SutraUI.Dialog.hide_dialog("landing-dialog")}
                    >
                      Cancel
                    </.button>
                    <.button phx-click={SutraUI.Dialog.hide_dialog("landing-dialog")}>
                      Continue
                    </.button>
                  </:footer>
                </.dialog>
              </div>
              <div class="showcase-footer">
                <span class="showcase-name">Dialog</span>
                <.link navigate="/docs/components/dialog" class="showcase-link">
                  View <span>→</span>
                </.link>
              </div>
            </div>
          </div>
        </div>
      </section>

      <%!-- CTA --%>
      <section class="py-32">
        <div class="mx-auto max-w-3xl px-6 text-center">
          <h2 class="section-title animate-fade-up">Ready to build something beautiful?</h2>
          <p class="section-subtitle mx-auto mt-4 animate-fade-up delay-1">
            Get started with Sutra UI in minutes. Browse the documentation,
            explore components, and start building.
          </p>
          <div class="flex justify-center gap-4 mt-10 animate-fade-up delay-2">
            <.button navigate="/docs">Get Started</.button>
            <.button variant="outline" href="https://github.com/gurujada/sutra_ui">
              View on GitHub
            </.button>
          </div>
        </div>
      </section>

      <%!-- Footer --%>
      <footer class="site-footer py-12">
        <div class="mx-auto max-w-6xl px-6">
          <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-6">
            <div>
              <p class="site-logo mb-2">Sutra UI</p>
              <p class="text-sm" style="color: var(--fg-muted);">
                by
                <a
                  href="https://github.com/gurujada"
                  class="underline hover:no-underline"
                  style="color: var(--fg-muted);"
                >
                  Gurujada
                </a>
              </p>
            </div>
            <nav class="flex items-center gap-8">
              <.link navigate="/docs" class="footer-link">Documentation</.link>
              <.link navigate="/docs/components/button" class="footer-link">Components</.link>
              <a href="https://hex.pm/packages/sutra_ui" class="footer-link">Hex.pm</a>
              <a href="https://github.com/gurujada/sutra_ui" class="footer-link">GitHub</a>
            </nav>
          </div>
        </div>
      </footer>
    </Layouts.app>
    """
  end
end
