defmodule SutrauiDemoWeb.Components.CarouselLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Carousel")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/carousel">
      <.docs_header
        title="Carousel"
        description="A carousel component using native CSS scroll-snap for smooth, performant navigation."
      />

      <.component_demo title="Basic" code={basic_code()}>
        <.carousel id="basic-carousel" class="max-w-md">
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: var(--bg-muted);"
            >
              <span class="text-2xl font-semibold">Slide 1</span>
            </div>
          </:item>
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: var(--bg-muted);"
            >
              <span class="text-2xl font-semibold">Slide 2</span>
            </div>
          </:item>
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: var(--bg-muted);"
            >
              <span class="text-2xl font-semibold">Slide 3</span>
            </div>
          </:item>
        </.carousel>
      </.component_demo>

      <.section_heading id="with-images">With Images</.section_heading>
      <.prose>
        Display images in the carousel with consistent sizing.
      </.prose>

      <.component_demo title="Image Carousel" code={images_code()}>
        <.carousel id="image-carousel" class="max-w-lg">
          <:item>
            <img
              src="https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&h=400&fit=crop"
              alt="Mountain landscape"
              class="w-full rounded-lg object-cover aspect-video"
            />
          </:item>
          <:item>
            <img
              src="https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=600&h=400&fit=crop"
              alt="Nature scene"
              class="w-full rounded-lg object-cover aspect-video"
            />
          </:item>
          <:item>
            <img
              src="https://images.unsplash.com/photo-1426604966848-d7adac402bff?w=600&h=400&fit=crop"
              alt="Forest path"
              class="w-full rounded-lg object-cover aspect-video"
            />
          </:item>
        </.carousel>
      </.component_demo>

      <.section_heading id="looping">Looping</.section_heading>
      <.prose>
        Enable infinite looping with the
        <.inline_code>loop</.inline_code>
        prop.
      </.prose>

      <.component_demo title="Looping Carousel" code={loop_code()}>
        <.carousel id="loop-carousel" loop class="max-w-md">
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);"
            >
              <span class="text-2xl font-semibold text-white">First</span>
            </div>
          </:item>
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);"
            >
              <span class="text-2xl font-semibold text-white">Second</span>
            </div>
          </:item>
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);"
            >
              <span class="text-2xl font-semibold text-white">Third</span>
            </div>
          </:item>
        </.carousel>
      </.component_demo>

      <.section_heading id="without-controls">Without Controls</.section_heading>
      <.prose>
        Hide arrows or indicators with
        <.inline_code>show_arrows={false}</.inline_code>
        and <.inline_code>show_indicators={false}</.inline_code>.
      </.prose>

      <.component_demo title="Minimal Carousel" code={minimal_code()}>
        <.carousel id="minimal-carousel" show_arrows={false} class="max-w-md">
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: var(--bg-muted);"
            >
              <span class="text-lg">Swipe or use indicators</span>
            </div>
          </:item>
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: var(--bg-muted);"
            >
              <span class="text-lg">No arrow buttons</span>
            </div>
          </:item>
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: var(--bg-muted);"
            >
              <span class="text-lg">Clean and minimal</span>
            </div>
          </:item>
        </.carousel>
      </.component_demo>

      <.section_heading id="custom-sizing">Custom Sizing</.section_heading>
      <.prose>
        Control dimensions with
        <.inline_code>width</.inline_code>
        and
        <.inline_code>height</.inline_code>
        props.
      </.prose>

      <.component_demo title="Fixed Size" code={sizing_code()}>
        <.carousel id="sized-carousel" width="300px" height="200px">
          <:item>
            <div
              class="flex h-full w-full items-center justify-center rounded-lg"
              style="background: var(--bg-muted);"
            >
              <span>300 x 200</span>
            </div>
          </:item>
          <:item>
            <div
              class="flex h-full w-full items-center justify-center rounded-lg"
              style="background: var(--bg-muted);"
            >
              <span>Fixed size</span>
            </div>
          </:item>
        </.carousel>
      </.component_demo>

      <.section_heading id="with-gap">With Gap</.section_heading>
      <.prose>
        Add spacing between items with the
        <.inline_code>gap</.inline_code>
        prop.
      </.prose>

      <.component_demo title="Gap Between Items" code={gap_code()}>
        <.carousel id="gap-carousel" gap="1rem" class="max-w-lg">
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: var(--bg-muted);"
            >
              <span>Item 1</span>
            </div>
          </:item>
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: var(--bg-muted);"
            >
              <span>Item 2</span>
            </div>
          </:item>
          <:item>
            <div
              class="flex aspect-video items-center justify-center rounded-lg"
              style="background: var(--bg-muted);"
            >
              <span>Item 3</span>
            </div>
          </:item>
        </.carousel>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp basic_code do
    ~s"""
    <.carousel id="my-carousel">
      <:item>
        <div class="flex aspect-video items-center justify-center rounded-lg bg-muted">
          <span>Slide 1</span>
        </div>
      </:item>
      <:item>
        <div class="...">Slide 2</div>
      </:item>
      <:item>
        <div class="...">Slide 3</div>
      </:item>
    </.carousel>\
    """
  end

  defp images_code do
    ~s"""
    <.carousel id="image-carousel">
      <:item>
        <img src="/images/slide1.jpg" alt="Slide 1" class="w-full rounded-lg object-cover" />
      </:item>
      <:item>
        <img src="/images/slide2.jpg" alt="Slide 2" class="..." />
      </:item>
    </.carousel>\
    """
  end

  defp loop_code do
    ~s"""
    <.carousel id="loop-carousel" loop>
      <:item>First</:item>
      <:item>Second</:item>
      <:item>Third</:item>
    </.carousel>\
    """
  end

  defp minimal_code do
    ~s"""
    <.carousel id="minimal" show_arrows={false}>
      <:item>Slide 1</:item>
      <:item>Slide 2</:item>
    </.carousel>\
    """
  end

  defp sizing_code do
    ~s"""
    <.carousel id="sized" width="300px" height="200px">
      <:item>Content</:item>
    </.carousel>\
    """
  end

  defp gap_code do
    ~s"""
    <.carousel id="gap-carousel" gap="1rem">
      <:item>Item 1</:item>
      <:item>Item 2</:item>
      <:item>Item 3</:item>
    </.carousel>\
    """
  end
end
