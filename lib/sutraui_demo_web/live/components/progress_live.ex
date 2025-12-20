defmodule SutrauiDemoWeb.Components.ProgressLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Progress", progress: 45)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/progress">
      <.docs_header
        title="Progress"
        description="Displays an indicator showing the completion progress of a task."
      />

      <.component_demo title="Default" code={~s|<.progress value={45} />|}>
        <.progress value={45} />
      </.component_demo>

      <.section_heading id="values">Different Values</.section_heading>
      <.prose>
        The
        <.inline_code>value</.inline_code>
        prop accepts a number from 0 to 100.
      </.prose>

      <.component_demo title="Values" code={values_code()}>
        <div class="space-y-4">
          <div class="space-y-2">
            <div class="flex justify-between text-sm" style="color: var(--fg-muted);">
              <span>0%</span>
            </div>
            <.progress value={0} />
          </div>
          <div class="space-y-2">
            <div class="flex justify-between text-sm" style="color: var(--fg-muted);">
              <span>25%</span>
            </div>
            <.progress value={25} />
          </div>
          <div class="space-y-2">
            <div class="flex justify-between text-sm" style="color: var(--fg-muted);">
              <span>50%</span>
            </div>
            <.progress value={50} />
          </div>
          <div class="space-y-2">
            <div class="flex justify-between text-sm" style="color: var(--fg-muted);">
              <span>75%</span>
            </div>
            <.progress value={75} />
          </div>
          <div class="space-y-2">
            <div class="flex justify-between text-sm" style="color: var(--fg-muted);">
              <span>100%</span>
            </div>
            <.progress value={100} />
          </div>
        </div>
      </.component_demo>

      <.section_heading id="sizes">Sizes</.section_heading>
      <.prose>
        Use the
        <.inline_code>size</.inline_code>
        prop to change the height of the progress bar.
      </.prose>

      <.component_demo title="Sizes" code={sizes_code()}>
        <div class="space-y-4">
          <div class="space-y-2">
            <span class="text-sm" style="color: var(--fg-muted);">Small</span>
            <.progress value={60} size="sm" />
          </div>
          <div class="space-y-2">
            <span class="text-sm" style="color: var(--fg-muted);">Default</span>
            <.progress value={60} />
          </div>
          <div class="space-y-2">
            <span class="text-sm" style="color: var(--fg-muted);">Large</span>
            <.progress value={60} size="lg" />
          </div>
          <div class="space-y-2">
            <span class="text-sm" style="color: var(--fg-muted);">Extra Large</span>
            <.progress value={60} size="xl" />
          </div>
        </div>
      </.component_demo>

      <.section_heading id="with-label">With Label</.section_heading>
      <.prose>
        Combine with a label to show the current progress value.
      </.prose>

      <.component_demo title="With Label" code={label_code()}>
        <div class="space-y-2">
          <div class="flex justify-between text-sm">
            <span style="color: var(--fg);">Uploading...</span>
            <span style="color: var(--fg-muted);">{@progress}%</span>
          </div>
          <.progress value={@progress} aria_label="Upload progress" />
        </div>
      </.component_demo>

      <.section_heading id="interactive">Interactive Example</.section_heading>
      <.prose>
        Try adjusting the progress value.
      </.prose>

      <.component_demo title="Interactive" code={interactive_code()}>
        <div class="space-y-4">
          <.progress value={@progress} />
          <div class="flex gap-2">
            <.button variant="outline" size="sm" phx-click="decrease">-10</.button>
            <.button variant="outline" size="sm" phx-click="increase">+10</.button>
            <.button variant="outline" size="sm" phx-click="reset">Reset</.button>
          </div>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  def handle_event("increase", _params, socket) do
    {:noreply, update(socket, :progress, &min(&1 + 10, 100))}
  end

  def handle_event("decrease", _params, socket) do
    {:noreply, update(socket, :progress, &max(&1 - 10, 0))}
  end

  def handle_event("reset", _params, socket) do
    {:noreply, assign(socket, :progress, 45)}
  end

  defp values_code do
    """
    <.progress value={0} />
    <.progress value={25} />
    <.progress value={50} />
    <.progress value={75} />
    <.progress value={100} />\
    """
  end

  defp sizes_code do
    """
    <.progress value={60} size="sm" />
    <.progress value={60} />
    <.progress value={60} size="lg" />
    <.progress value={60} size="xl" />\
    """
  end

  defp label_code do
    """
    <div class="space-y-2">
      <div class="flex justify-between text-sm">
        <span>Uploading...</span>
        <span>45%</span>
      </div>
      <.progress value={45} aria_label="Upload progress" />
    </div>\
    """
  end

  defp interactive_code do
    """
    <.progress value={@progress} />
    <.button phx-click="increase">+10</.button>
    <.button phx-click="decrease">-10</.button>\
    """
  end
end
