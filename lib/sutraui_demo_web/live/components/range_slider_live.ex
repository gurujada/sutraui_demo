defmodule SutrauiDemoWeb.Components.RangeSliderLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Range Slider",
       price_min: 200,
       price_max: 800
     )}
  end

  def handle_event("price_change", %{"price_min" => min, "price_max" => max}, socket) do
    {:noreply,
     assign(socket,
       price_min: String.to_integer(min),
       price_max: String.to_integer(max)
     )}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/range-slider">
      <.docs_header
        title="Range Slider"
        description="A dual-handle slider for selecting a range of values."
      />

      <.component_demo title="Default" code={~s|<.range_slider name="range" />|}>
        <div class="w-full max-w-sm">
          <.range_slider name="range" />
        </div>
      </.component_demo>

      <.section_heading id="with-labels">With Labels</.section_heading>
      <.prose>
        Display the selected range values alongside the slider.
      </.prose>

      <.component_demo title="With Labels" code={label_code()}>
        <div class="w-full max-w-sm space-y-2">
          <div class="flex justify-between items-center">
            <label class="text-sm font-medium" style="color: var(--fg);">Price Range</label>
            <span class="text-sm tabular-nums" style="color: var(--fg-muted);">
              ${@price_min} - ${@price_max}
            </span>
          </div>
          <.range_slider
            name="price"
            min={0}
            max={1000}
            step={10}
            value_min={@price_min}
            value_max={@price_max}
            phx-change="price_change"
          />
        </div>
      </.component_demo>

      <.section_heading id="tooltips">With Tooltips</.section_heading>
      <.prose>
        Enable tooltips to show values above the handles.
      </.prose>

      <.component_demo title="Tooltips" code={tooltip_code()}>
        <div class="w-full max-w-sm pt-6">
          <.range_slider name="with_tips" tooltips value_min={25} value_max={75} />
        </div>
      </.component_demo>

      <.section_heading id="pips">With Pips</.section_heading>
      <.prose>
        Add tick marks with the
        <.inline_code>pips</.inline_code>
        option.
      </.prose>

      <.component_demo title="Pips" code={pips_code()}>
        <div class="w-full max-w-sm pb-4">
          <.range_slider
            name="with_pips"
            pips
            min={0}
            max={100}
            step={10}
            value_min={20}
            value_max={80}
          />
        </div>
      </.component_demo>

      <.section_heading id="custom-format">Custom Format</.section_heading>
      <.prose>
        Use the
        <.inline_code>format</.inline_code>
        attribute to customize how values are displayed.
      </.prose>

      <.component_demo title="Custom Format" code={format_code()}>
        <div class="w-full max-w-sm pt-6">
          <.range_slider
            name="formatted"
            tooltips
            min={0}
            max={100}
            value_min={30}
            value_max={70}
            format={&"$#{&1}"}
          />
        </div>
      </.component_demo>

      <.section_heading id="disabled">Disabled</.section_heading>
      <.prose>
        Use the disabled attribute to prevent interaction.
      </.prose>

      <.component_demo
        title="Disabled"
        code={~s|<.range_slider name="disabled" value_min={25} value_max={75} disabled />|}
      >
        <div class="w-full max-w-sm">
          <.range_slider name="disabled" value_min={25} value_max={75} disabled />
        </div>
      </.component_demo>

      <.section_heading id="events">Events</.section_heading>
      <.prose>
        The range slider emits events with both min and max values.
        Use
        <.inline_code>on_slide</.inline_code>
        for real-time updates or
        <.inline_code>on_change</.inline_code>
        for final values.
      </.prose>

      <.code_block language="elixir" code={event_code()} />

      <.section_heading id="form-params">Form Parameters</.section_heading>
      <.prose>
        When used in forms, the range slider submits two parameters:
        <.inline_code>{"{name}_min"}</.inline_code>
        and <.inline_code>{"{name}_max"}</.inline_code>.
      </.prose>

      <.code_block language="elixir" code={params_code()} />
    </Layouts.docs>
    """
  end

  defp label_code do
    """
    <div class="flex justify-between items-center">
      <label>Price Range</label>
      <span>${@price_min} - ${@price_max}</span>
    </div>
    <.range_slider
      name="price"
      min={0}
      max={1000}
      step={10}
      value_min={@price_min}
      value_max={@price_max}
      phx-change="price_change"
    />\
    """
  end

  defp tooltip_code do
    ~s|<.range_slider name="with_tips" tooltips value_min={25} value_max={75} />|
  end

  defp pips_code do
    ~s|<.range_slider name="with_pips" pips min={0} max={100} step={10} value_min={20} value_max={80} />|
  end

  defp format_code do
    ~S"""
    <.range_slider
      name="formatted"
      tooltips
      min={0}
      max={100}
      value_min={30}
      value_max={70}
      format={&"$#{&1}"}
    />\
    """
  end

  defp event_code do
    """
    def handle_event("price_change", %{"price_min" => min, "price_max" => max}, socket) do
      {:noreply,
       assign(socket,
         price_min: String.to_integer(min),
         price_max: String.to_integer(max)
       )}
    end\
    """
  end

  defp params_code do
    """
    # For a range slider with name="price"
    # Form submission includes:
    %{"price_min" => "200", "price_max" => "800"}\
    """
  end
end
