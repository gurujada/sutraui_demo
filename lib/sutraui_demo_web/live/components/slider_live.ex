defmodule SutrauiDemoWeb.Components.SliderLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Slider", volume: 50, opacity: 0.75)}
  end

  def handle_event("volume_change", %{"volume" => volume}, socket) do
    {:noreply, assign(socket, volume: String.to_integer(volume))}
  end

  def handle_event("opacity_change", %{"opacity" => opacity}, socket) do
    {:noreply, assign(socket, opacity: String.to_float(opacity))}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/slider">
      <.docs_header
        title="Slider"
        description="An input that allows selecting a value from a range by dragging a handle."
      />

      <.component_demo title="Default" code={~s|<.slider id="default-slider" />|}>
        <div class="w-full max-w-sm">
          <.slider id="default-slider" />
        </div>
      </.component_demo>

      <.section_heading id="with-label">With Label</.section_heading>
      <.prose>
        Combine with a label and display the current value.
      </.prose>

      <.component_demo title="With Label" code={label_code()}>
        <div class="w-full max-w-sm space-y-2">
          <div class="flex justify-between items-center">
            <label for="volume-slider" class="text-sm font-medium" style="color: var(--fg);">
              Volume
            </label>
            <span class="text-sm tabular-nums" style="color: var(--fg-muted);">{@volume}%</span>
          </div>
          <.slider
            id="volume-slider"
            name="volume"
            value={@volume}
            min={0}
            max={100}
            phx-change="volume_change"
          />
        </div>
      </.component_demo>

      <.section_heading id="range">Custom Range</.section_heading>
      <.prose>
        Configure the range with <.inline_code>min</.inline_code>, <.inline_code>max</.inline_code>, and <.inline_code>step</.inline_code>.
      </.prose>

      <.component_demo title="Custom Range" code={range_code()}>
        <div class="w-full max-w-sm space-y-4">
          <div>
            <label class="text-sm font-medium block mb-2" style="color: var(--fg);">
              Temperature (0-40°C)
            </label>
            <.slider id="temp-slider" min={0} max={40} step={1} value={22} />
          </div>
          <div>
            <label class="text-sm font-medium block mb-2" style="color: var(--fg);">
              Rating (1-5)
            </label>
            <.slider id="rating-slider" min={1} max={5} step={1} value={3} />
          </div>
        </div>
      </.component_demo>

      <.section_heading id="float">Float Mode</.section_heading>
      <.prose>
        Use a decimal
        <.inline_code>step</.inline_code>
        value for floating-point precision.
      </.prose>

      <.component_demo title="Float Mode" code={float_code()}>
        <div class="w-full max-w-sm space-y-2">
          <div class="flex justify-between items-center">
            <label for="opacity-slider" class="text-sm font-medium" style="color: var(--fg);">
              Opacity
            </label>
            <span class="text-sm tabular-nums" style="color: var(--fg-muted);">{@opacity}</span>
          </div>
          <.slider
            id="opacity-slider"
            name="opacity"
            value={@opacity}
            min={0.0}
            max={1.0}
            step={0.01}
            phx-change="opacity_change"
          />
        </div>
      </.component_demo>

      <.section_heading id="disabled">Disabled</.section_heading>
      <.prose>
        Use the disabled attribute to prevent interaction.
      </.prose>

      <.component_demo
        title="Disabled"
        code={~s|<.slider id="disabled-slider" value={30} disabled />|}
      >
        <div class="w-full max-w-sm">
          <.slider id="disabled-slider" value={30} disabled />
        </div>
      </.component_demo>

      <.section_heading id="events">Events</.section_heading>
      <.prose>
        The slider emits
        <.inline_code>phx-change</.inline_code>
        events as the user drags the handle.
      </.prose>

      <.code_block language="elixir" code={event_code()} />
    </Layouts.docs>
    """
  end

  defp label_code do
    """
    <div class="flex justify-between items-center">
      <label for="volume-slider">Volume</label>
      <span>{@volume}%</span>
    </div>
    <.slider
      id="volume-slider"
      name="volume"
      value={@volume}
      min={0}
      max={100}
      phx-change="volume_change"
    />\
    """
  end

  defp range_code do
    """
    <.slider id="temp-slider" min={0} max={40} step={1} value={22} />
    <.slider id="rating-slider" min={1} max={5} step={1} value={3} />\
    """
  end

  defp float_code do
    """
    <.slider
      id="opacity-slider"
      name="opacity"
      value={@opacity}
      min={0.0}
      max={1.0}
      step={0.01}
      phx-change="opacity_change"
    />\
    """
  end

  defp event_code do
    """
    def handle_event("volume_change", %{"volume" => volume}, socket) do
      {:noreply, assign(socket, volume: String.to_integer(volume))}
    end\
    """
  end
end
