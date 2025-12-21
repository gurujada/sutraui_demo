defmodule SutrauiDemoWeb.Components.NavPillsLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Nav Pills", active_tab: "Overview")}
  end

  def handle_params(params, _uri, socket) do
    tab = params["tab"] || "Overview"
    {:noreply, assign(socket, active_tab: tab)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/nav-pills">
      <.docs_header
        title="Nav Pills"
        description="A responsive navigation pills component that displays pills on desktop and converts to a dropdown on mobile."
      />

      <.component_demo title="Default" code={default_code()}>
        <.nav_pills id="demo-nav" active_label={@active_tab}>
          <:item label="Overview" patch="/docs/components/nav-pills?tab=Overview" />
          <:item label="Analytics" patch="/docs/components/nav-pills?tab=Analytics" />
          <:item label="Settings" patch="/docs/components/nav-pills?tab=Settings" />
        </.nav_pills>
      </.component_demo>

      <.section_heading id="responsive">Responsive Behavior</.section_heading>
      <.prose>
        Nav Pills automatically adapts to screen size:
      </.prose>
      <ul class="list-disc list-inside space-y-1 text-sm" style="color: var(--fg-secondary);">
        <li>
          <span class="font-medium" style="color: var(--fg);">Desktop:</span>
          Shows all items as horizontal pill buttons
        </li>
        <li>
          <span class="font-medium" style="color: var(--fg);">Mobile:</span>
          Converts to a dropdown menu showing the active item
        </li>
      </ul>

      <.section_heading id="usage">Usage</.section_heading>
      <.prose>
        Nav Pills requires an <.inline_code>id</.inline_code>, the
        <.inline_code>active_label</.inline_code>
        of the current item, and
        <.inline_code>:item</.inline_code>
        slots with
        <.inline_code>label</.inline_code>
        and
        <.inline_code>patch</.inline_code>
        attributes.
      </.prose>

      <.code_block code={usage_code()} language="elixir" filename="Usage" />

      <.section_heading id="with-icons">With Icons</.section_heading>
      <.prose>
        Use the inner block of each item slot to add icons before the label.
      </.prose>

      <.code_block code={icons_code()} language="elixir" filename="With Icons" />

      <.section_heading id="accessibility">Accessibility</.section_heading>
      <.prose>
        The nav pills component includes proper ARIA attributes:
      </.prose>
      <ul class="list-disc list-inside space-y-1 text-sm" style="color: var(--fg-secondary);">
        <li>
          Desktop pills use
          <.inline_code>role="navigation"</.inline_code>
          with
          <.inline_code>aria-label</.inline_code>
        </li>
        <li>Mobile dropdown uses proper ARIA popup attributes</li>
        <li>Active item is clearly indicated visually and semantically</li>
      </ul>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.nav_pills id="content-nav" active_label="Overview">
      <:item label="Overview" patch={~p"/content"} />
      <:item label="Analytics" patch={~p"/content/analytics"} />
      <:item label="Settings" patch={~p"/content/settings"} />
    </.nav_pills>\
    """
  end

  defp usage_code do
    """
    <.nav_pills id="content-nav" active_label={@active_tab}>
      <:item label="Overview" patch={~p"/content"} />
      <:item label="Analytics" patch={~p"/content/analytics"} />
      <:item label="Settings" patch={~p"/content/settings"} />
    </.nav_pills>\
    """
  end

  defp icons_code do
    """
    <.nav_pills id="nav" active_label="Dashboard">
      <:item label="Dashboard" patch={~p"/dashboard"}>
        <.icon name="lucide-layout-grid" class="size-4" />
      </:item>
      <:item label="Projects" patch={~p"/projects"}>
        <.icon name="lucide-folder" class="size-4" />
      </:item>
      <:item label="Team" patch={~p"/team"}>
        <.icon name="lucide-users" class="size-4" />
      </:item>
    </.nav_pills>\
    """
  end
end
