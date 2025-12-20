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
            <span class="btn">Open Popover</span>
          </:trigger>
          <div class="space-y-2">
            <h4 class="font-medium text-sm">Dimensions</h4>
            <p class="text-sm text-muted-foreground">
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
              <span class="btn btn-outline">Top</span>
            </:trigger>
            <p class="text-sm">Popover on top</p>
          </.popover>
          <.popover id="popover-bottom" side="bottom">
            <:trigger>
              <span class="btn btn-outline">Bottom</span>
            </:trigger>
            <p class="text-sm">Popover on bottom</p>
          </.popover>
          <.popover id="popover-left" side="left">
            <:trigger>
              <span class="btn btn-outline">Left</span>
            </:trigger>
            <p class="text-sm">Popover on left</p>
          </.popover>
          <.popover id="popover-right" side="right">
            <:trigger>
              <span class="btn btn-outline">Right</span>
            </:trigger>
            <p class="text-sm">Popover on right</p>
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
            <span class="btn">Update dimensions</span>
          </:trigger>
          <div class="w-72 space-y-4">
            <div class="space-y-2">
              <h4 class="font-medium text-sm">Dimensions</h4>
              <p class="text-sm text-muted-foreground">
                Set the dimensions for the layer.
              </p>
            </div>
            <div class="grid gap-3">
              <div class="grid grid-cols-3 items-center gap-4">
                <.label for="pop-width" class="text-right">Width</.label>
                <.input
                  type="text"
                  id="pop-width"
                  name="width"
                  value="100%"
                  class="col-span-2 h-8"
                />
              </div>
              <div class="grid grid-cols-3 items-center gap-4">
                <.label for="pop-height" class="text-right">Height</.label>
                <.input
                  type="text"
                  id="pop-height"
                  name="height"
                  value="25px"
                  class="col-span-2 h-8"
                />
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
            <span class="btn btn-secondary">
              {if open, do: "Close", else: "Open"} Popover
            </span>
          </:trigger>
          <p class="text-sm">
            The trigger text changes based on state.
          </p>
        </.popover>
      </.component_demo>

      <.section_heading id="user-profile">User Profile Example</.section_heading>
      <.prose>
        A common use case for popovers is displaying user profile information.
      </.prose>

      <.component_demo title="User Profile" code={profile_code()}>
        <.popover id="popover-profile">
          <:trigger>
            <.avatar src="https://github.com/shadcn.png" alt="User" size="md" />
          </:trigger>
          <div class="w-64">
            <div class="pb-4 border-b border-border">
              <div class="flex items-center gap-3">
                <.avatar src="https://github.com/shadcn.png" alt="User" size="lg" />
                <div>
                  <p class="font-medium text-sm">John Doe</p>
                  <p class="text-xs text-muted-foreground">john@example.com</p>
                </div>
              </div>
            </div>
            <div class="pt-2 -mx-4 -mb-4">
              <div class="w-full text-left px-4 py-2 text-sm hover:bg-muted rounded-none cursor-pointer">
                Profile
              </div>
              <div class="w-full text-left px-4 py-2 text-sm hover:bg-muted rounded-none cursor-pointer">
                Settings
              </div>
              <div class="w-full text-left px-4 py-2 text-sm text-destructive hover:bg-muted rounded-none cursor-pointer">
                Sign out
              </div>
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
        <span class="btn">Open Popover</span>
      </:trigger>
      <div>
        <p>Popover content goes here.</p>
      </div>
    </.popover>\
    """
  end

  defp positions_code do
    """
    <.popover id="top" side="top">
      <:trigger><span class="btn btn-outline">Top</span></:trigger>
      <p>Content</p>
    </.popover>
    <.popover id="bottom" side="bottom">
      <:trigger><span class="btn btn-outline">Bottom</span></:trigger>
      <p>Content</p>
    </.popover>\
    """
  end

  defp form_code do
    """
    <.popover id="form-popover">
      <:trigger><span class="btn">Update dimensions</span></:trigger>
      <div class="w-72">
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
      <:trigger :let={open}>
        <span class="btn btn-secondary">
          {if open, do: "Close", else: "Open"} Popover
        </span>
      </:trigger>
      <p>Content</p>
    </.popover>\
    """
  end

  defp profile_code do
    """
    <.popover id="profile">
      <:trigger>
        <.avatar src="/avatar.png" />
      </:trigger>
      <div class="w-64">
        <div class="flex items-center gap-3">
          <.avatar src="/avatar.png" size="lg" />
          <div>
            <p class="font-medium">John Doe</p>
            <p class="text-sm text-muted-foreground">john@example.com</p>
          </div>
        </div>
      </div>
    </.popover>\
    """
  end
end
