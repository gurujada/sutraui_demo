defmodule SutrauiDemoWeb.Components.IndexLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Components")}
  end

  def render(assigns) do
    assigns = assign(assigns, :groups, component_groups())

    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components">
      <.docs_header
        title="Components"
        description="Browse the Sutra UI component set by category."
      />

      <div class="space-y-10">
        <section :for={group <- @groups}>
          <.section_heading id={slug(group.group)}>{group.group}</.section_heading>
          <div class="grid gap-2 sm:grid-cols-2">
            <.link
              :for={item <- group.items}
              navigate={item.href}
              class="group rounded-md border px-3 py-2 text-sm transition-colors hover:bg-muted/50"
              style="border-color: var(--border);"
            >
              <span class="flex min-w-0 items-center gap-2">
                <span class="truncate font-medium text-foreground group-hover:text-primary">
                  {item.label}
                </span>
                <span
                  :if={Layouts.component_marker_emoji(item.href)}
                  class="shrink-0 text-xs leading-none"
                  aria-hidden="true"
                >
                  {Layouts.component_marker_emoji(item.href)}
                </span>
                <span
                  :if={Layouts.new_component?(item.href)}
                  class="shrink-0 rounded-full bg-blue-500/10 px-1.5 py-0.5 text-[10px] font-medium leading-none text-blue-600 dark:text-blue-400"
                >
                  New
                </span>
              </span>
            </.link>
          </div>
        </section>
      </div>
    </Layouts.docs>
    """
  end

  defp component_groups do
    Layouts.nav_items()
    |> Enum.reject(&(&1.group == "Getting Started"))
  end

  defp slug(value) do
    value
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]+/, "-")
    |> String.trim("-")
  end
end
