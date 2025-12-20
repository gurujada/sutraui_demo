defmodule SutrauiDemoWeb.Components.PopoverLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Popover")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/popover">
      <.docs_header
        title="Popover"
        description="A floating content panel that appears on click, supporting rich interactive content."
      />

      <.component_demo title="Default" code={default_code()}>
        <.popover id="popover-default">
          <:trigger>
            <.button variant="outline">Open Popover</.button>
          </:trigger>
          <div class="p-4 space-y-2">
            <h4 class="font-medium text-sm" style="color: var(--fg);">Dimensions</h4>
            <p class="text-sm" style="color: var(--fg-muted);">
              Set the dimensions for the layer.
            </p>
          </div>
        </.popover>
      </.component_demo>

      <.section_heading id="positions">Positions</.section_heading>
      <.prose>
        Use the
        <.inline_code>side</.inline_code>
        prop to control where the popover appears.
      </.prose>

      <.component_demo title="Positions" code={positions_code()}>
        <div class="flex flex-wrap items-center gap-4">
          <.popover id="popover-top" side="top">
            <:trigger>
              <.button variant="outline">Top</.button>
            </:trigger>
            <div class="p-4">
              <p class="text-sm" style="color: var(--fg);">Popover on top</p>
            </div>
          </.popover>
          <.popover id="popover-bottom" side="bottom">
            <:trigger>
              <.button variant="outline">Bottom</.button>
            </:trigger>
            <div class="p-4">
              <p class="text-sm" style="color: var(--fg);">Popover on bottom</p>
            </div>
          </.popover>
          <.popover id="popover-left" side="left">
            <:trigger>
              <.button variant="outline">Left</.button>
            </:trigger>
            <div class="p-4">
              <p class="text-sm" style="color: var(--fg);">Popover on left</p>
            </div>
          </.popover>
          <.popover id="popover-right" side="right">
            <:trigger>
              <.button variant="outline">Right</.button>
            </:trigger>
            <div class="p-4">
              <p class="text-sm" style="color: var(--fg);">Popover on right</p>
            </div>
          </.popover>
        </div>
      </.component_demo>

      <.section_heading id="with-form">With Form</.section_heading>
      <.prose>
        Popovers can contain interactive content like forms.
      </.prose>

      <.component_demo title="With Form" code={form_code()}>
        <.popover id="popover-form">
          <:trigger>
            <.button variant="outline">Update dimensions</.button>
          </:trigger>
          <div class="p-4 w-72 space-y-4">
            <div class="space-y-2">
              <h4 class="font-medium text-sm" style="color: var(--fg);">Dimensions</h4>
              <p class="text-sm" style="color: var(--fg-muted);">
                Set the dimensions for the layer.
              </p>
            </div>
            <div class="grid gap-3">
              <div class="grid grid-cols-3 items-center gap-4">
                <.label for="width" class="text-right">Width</.label>
                <.input type="text" id="width" name="width" value="100%" class="col-span-2 h-8" />
              </div>
              <div class="grid grid-cols-3 items-center gap-4">
                <.label for="height" class="text-right">Height</.label>
                <.input type="text" id="height" name="height" value="25px" class="col-span-2 h-8" />
              </div>
            </div>
          </div>
        </.popover>
      </.component_demo>

      <.section_heading id="dynamic-trigger">Dynamic Trigger Text</.section_heading>
      <.prose>
        The trigger slot receives an
        <.inline_code>open</.inline_code>
        boolean for dynamic content.
      </.prose>

      <.component_demo title="Dynamic Trigger" code={dynamic_code()}>
        <.popover id="popover-dynamic">
          <:trigger :let={open}>
            <.button variant="outline">
              {if open, do: "Close", else: "Open"} Popover
            </.button>
          </:trigger>
          <div class="p-4">
            <p class="text-sm" style="color: var(--fg);">
              The trigger text changes based on state.
            </p>
          </div>
        </.popover>
      </.component_demo>

      <.section_heading id="user-profile">User Profile Example</.section_heading>
      <.prose>
        A common use case for popovers is displaying user profile information.
      </.prose>

      <.component_demo title="User Profile" code={profile_code()}>
        <.popover id="popover-profile">
          <:trigger>
            <.button variant="ghost" class="p-0">
              <.avatar src="https://github.com/shadcn.png" alt="User" size="md" />
            </.button>
          </:trigger>
          <div class="w-64">
            <div class="p-4 border-b" style="border-color: var(--border);">
              <div class="flex items-center gap-3">
                <.avatar src="https://github.com/shadcn.png" alt="User" size="lg" />
                <div>
                  <p class="font-medium text-sm" style="color: var(--fg);">John Doe</p>
                  <p class="text-xs" style="color: var(--fg-muted);">john@example.com</p>
                </div>
              </div>
            </div>
            <div class="p-2">
              <button
                class="w-full text-left px-3 py-2 text-sm rounded-md transition-colors"
                style="color: var(--fg);"
                onmouseover="this.style.background='var(--bg-subtle)'"
                onmouseout="this.style.background='transparent'"
              >
                Profile
              </button>
              <button
                class="w-full text-left px-3 py-2 text-sm rounded-md transition-colors"
                style="color: var(--fg);"
                onmouseover="this.style.background='var(--bg-subtle)'"
                onmouseout="this.style.background='transparent'"
              >
                Settings
              </button>
              <button
                class="w-full text-left px-3 py-2 text-sm rounded-md transition-colors"
                style="color: var(--destructive);"
                onmouseover="this.style.background='var(--bg-subtle)'"
                onmouseout="this.style.background='transparent'"
              >
                Sign out
              </button>
            </div>
          </div>
        </.popover>
      </.component_demo>

      <.section_heading id="accessibility">Accessibility</.section_heading>
      <.prose>
        The popover component includes proper ARIA attributes:
      </.prose>
      <ul class="list-disc list-inside space-y-1 text-sm" style="color: var(--fg-secondary);">
        <li>
          <.inline_code>aria-expanded</.inline_code>
          on the trigger button
        </li>
        <li>
          <.inline_code>aria-controls</.inline_code>
          linking trigger to content
        </li>
        <li>
          <.inline_code>role="dialog"</.inline_code>
          on the popover content
        </li>
        <li>Escape key closes the popover</li>
        <li>Click outside closes the popover</li>
      </ul>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.popover id="my-popover">
      <:trigger>
        <.button variant="outline">Open Popover</.button>
      </:trigger>
      <div class="p-4">
        <p>Popover content goes here.</p>
      </div>
    </.popover>\
    """
  end

  defp positions_code do
    """
    <.popover id="top" side="top">
      <:trigger><.button>Top</.button></:trigger>
      <div class="p-4">Content</div>
    </.popover>
    <.popover id="bottom" side="bottom">
      <:trigger><.button>Bottom</.button></:trigger>
      <div class="p-4">Content</div>
    </.popover>\
    """
  end

  defp form_code do
    """
    <.popover id="form-popover">
      <:trigger>
        <.button>Update dimensions</.button>
      </:trigger>
      <div class="p-4 w-72">
        <div class="grid gap-3">
          <div class="grid grid-cols-3 items-center gap-4">
            <.label for="width">Width</.label>
            <.input id="width" value="100%" class="col-span-2" />
          </div>
        </div>
      </div>
    </.popover>\
    """
  end

  defp dynamic_code do
    """
    <.popover id="dynamic">
      <:trigger let={open}>
        <.button>{if open, do: "Close", else: "Open"}</.button>
      </:trigger>
      <div class="p-4">Content</div>
    </.popover>\
    """
  end

  defp profile_code do
    """
    <.popover id="profile">
      <:trigger>
        <.avatar src="/avatar.png" />
      </:trigger>
      <div class="w-64 p-4">
        <div class="flex items-center gap-3">
          <.avatar src="/avatar.png" size="lg" />
          <div>
            <p class="font-medium">John Doe</p>
            <p class="text-sm text-muted">john@example.com</p>
          </div>
        </div>
      </div>
    </.popover>\
    """
  end
end
