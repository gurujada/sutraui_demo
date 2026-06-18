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
        description="A themed one-pixel rule for visually or semantically separating content."
      />

      <.component_demo title="Horizontal" code={horizontal_code()}>
        <div class="w-full max-w-sm">
          <div class="space-y-1">
            <h4 class="text-sm font-medium text-foreground">Sutra UI</h4>
            <p class="text-sm text-muted-foreground">
              Phoenix LiveView components inspired by shadcn/ui.
            </p>
          </div>
          <.separator class="my-4" />
          <div class="space-y-1">
            <h4 class="text-sm font-medium text-foreground">Installation</h4>
            <p class="text-sm text-muted-foreground">
              Add the dependency, run the installer, delete core_components.
            </p>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="vertical">Vertical</.section_heading>
      <.prose>
        Use
        <.inline_code>orientation="vertical"</.inline_code>
        inside a container with an explicit height. The separator stretches to
        fill its parent.
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

      <.section_heading id="with-content">With Content</.section_heading>
      <.prose>
        A common pattern: flank a label with two separators to create an "or"
        divider between alternative actions.
      </.prose>

      <.component_demo title="Or Divider" code={content_code()}>
        <div class="flex w-full max-w-sm items-center gap-4">
          <.separator class="flex-1" />
          <span class="text-xs text-muted-foreground">OR</span>
          <.separator class="flex-1" />
        </div>
      </.component_demo>

      <.section_heading id="list">List Dividers</.section_heading>
      <.prose>
        Drop separators between dense rows when each item needs a clear visual
        boundary. Composes naturally with cards and list items.
      </.prose>

      <.component_demo title="Settings List" code={list_code()}>
        <div class="w-full max-w-md overflow-hidden rounded-lg border bg-card">
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
        when the divider carries document structure — it then exposes
        <.inline_code>role="separator"</.inline_code>
        and announces itself to assistive technology.
      </.prose>

      <.component_demo title="Semantic" code={semantic_code()}>
        <div class="w-full max-w-sm space-y-4">
          <p class="text-sm text-foreground">Account preferences</p>
          <.separator decorative={false} aria-label="End of account section" />
          <p class="text-sm text-foreground">Team preferences</p>
        </div>
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          Separators render as a native
          <.inline_code>&lt;hr&gt;</.inline_code>
          element — semantically correct for horizontal dividers.
        </.list_item>
        <.list_item>
          Vertical separators need a parent with an explicit height (e.g. <.inline_code>flex h-10</.inline_code>) since they stretch to fill it.
        </.list_item>
        <.list_item>
          Decorative separators set
          <.inline_code>role="presentation"</.inline_code>
          and are hidden from screen readers. Use
          <.inline_code>decorative={false}</.inline_code>
          for structural breaks.
        </.list_item>
        <.list_item>
          Pass
          <.inline_code>aria-label</.inline_code>
          on semantic separators so assistive technology can announce their
          purpose.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp horizontal_code do
    """
    <div>
      <div class="space-y-1">
        <h4>Sutra UI</h4>
        <p>Phoenix LiveView components inspired by shadcn/ui.</p>
      </div>
      <.separator class="my-4" />
      <div class="space-y-1">
        <h4>Installation</h4>
        <p>Add the dependency, run the installer, delete core_components.</p>
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

  defp content_code do
    """
    <div class="flex items-center gap-4">
      <.separator class="flex-1" />
      <span>OR</span>
      <.separator class="flex-1" />
    </div>\
    """
  end

  defp list_code do
    """
    <div class="rounded-lg border">
      <div class="flex items-center gap-3 px-4 py-3">
        <.icon name="lucide-user" class="size-4" />
        <div>
          <p>Account</p>
          <p>Profile and security</p>
        </div>
      </div>
      <.separator />
      <div class="flex items-center gap-3 px-4 py-3">
        <.icon name="lucide-bell" class="size-4" />
        <div>
          <p>Notifications</p>
          <p>Email and workspace alerts</p>
        </div>
      </div>
      <.separator />
      <div class="flex items-center gap-3 px-4 py-3">
        <.icon name="lucide-credit-card" class="size-4" />
        <div>
          <p>Billing</p>
          <p>Plan and payment details</p>
        </div>
      </div>
    </div>\
    """
  end

  defp semantic_code do
    """
    <.separator decorative={false} aria-label="End of account section" />\
    """
  end
end
