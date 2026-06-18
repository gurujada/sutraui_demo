defmodule SutrauiDemoWeb.Components.SeparatorLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Separator")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/separator">
      <.docs_header
        title="Separator"
        description="Visually or semantically separates content with a themed one-pixel rule."
      />

      <.component_demo title="Default" code={default_code()}>
        <div class="w-full max-w-sm">
          <div class="space-y-1">
            <h4 class="text-sm font-medium text-foreground">Sutra UI</h4>
            <p class="text-sm text-muted-foreground">
              Phoenix LiveView components inspired by shadcn/ui.
            </p>
          </div>
          <.separator class="my-4" />
          <div class="flex h-5 items-center gap-4 text-sm text-foreground">
            <span>Blog</span>
            <.separator orientation="vertical" />
            <span>Docs</span>
            <.separator orientation="vertical" />
            <span>Source</span>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="orientation">Orientation</.section_heading>
      <.prose>
        The default separator is horizontal. Use
        <.inline_code>orientation="vertical"</.inline_code>
        inside a container with an explicit height.
      </.prose>

      <.component_demo title="Vertical" code={vertical_code()}>
        <div class="flex h-10 items-center gap-4 text-sm text-foreground">
          <span>Overview</span>
          <.separator orientation="vertical" />
          <span>Activity</span>
          <.separator orientation="vertical" />
          <span>Settings</span>
        </div>
      </.component_demo>

      <.section_heading id="list">List Dividers</.section_heading>
      <.prose>
        Use separators between dense rows when each item needs a clear visual boundary.
      </.prose>

      <.component_demo title="Settings List" code={list_code()}>
        <div class="w-full max-w-md rounded-lg border bg-card">
          <div class="flex items-center gap-3 px-4 py-3">
            <span class="text-muted-foreground">
              <.icon name="lucide-user" class="size-4" />
            </span>
            <div class="min-w-0">
              <p class="text-sm font-medium text-foreground">Account</p>
              <p class="text-xs text-muted-foreground">Profile and security</p>
            </div>
          </div>
          <.separator />
          <div class="flex items-center gap-3 px-4 py-3">
            <span class="text-muted-foreground">
              <.icon name="lucide-bell" class="size-4" />
            </span>
            <div class="min-w-0">
              <p class="text-sm font-medium text-foreground">Notifications</p>
              <p class="text-xs text-muted-foreground">Email and workspace alerts</p>
            </div>
          </div>
          <.separator />
          <div class="flex items-center gap-3 px-4 py-3">
            <span class="text-muted-foreground">
              <.icon name="lucide-credit-card" class="size-4" />
            </span>
            <div class="min-w-0">
              <p class="text-sm font-medium text-foreground">Billing</p>
              <p class="text-xs text-muted-foreground">Plan and payment details</p>
            </div>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="semantic">Semantic Separators</.section_heading>
      <.prose>
        Separators are decorative by default, matching shadcn/ui. Set
        <.inline_code>decorative={false}</.inline_code>
        when the divider carries document structure.
      </.prose>

      <.component_demo title="Semantic" code={semantic_code()}>
        <div class="w-full max-w-sm space-y-4">
          <p class="text-sm text-foreground">Account preferences</p>
          <.separator decorative={false} aria-label="Account settings boundary" />
          <p class="text-sm text-foreground">Team preferences</p>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <div>
      <div class="space-y-1">
        <h4>Sutra UI</h4>
        <p>Phoenix LiveView components inspired by shadcn/ui.</p>
      </div>
      <.separator class="my-4" />
      <div class="flex h-5 items-center gap-4">
        <span>Blog</span>
        <.separator orientation="vertical" />
        <span>Docs</span>
        <.separator orientation="vertical" />
        <span>Source</span>
      </div>
    </div>\
    """
  end

  defp vertical_code do
    """
    <div class="flex h-10 items-center gap-4">
      <span>Overview</span>
      <.separator orientation="vertical" />
      <span>Activity</span>
      <.separator orientation="vertical" />
      <span>Settings</span>
    </div>\
    """
  end

  defp list_code do
    """
    <div class="rounded-lg border">
      <div>Account</div>
      <.separator />
      <div>Notifications</div>
      <.separator />
      <div>Billing</div>
    </div>\
    """
  end

  defp semantic_code do
    """
    <.separator decorative={false} aria-label="Account settings boundary" />\
    """
  end
end
