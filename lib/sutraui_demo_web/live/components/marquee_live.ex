defmodule SutrauiDemoWeb.Components.MarqueeLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Marquee")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/marquee">
      <.docs_header
        title="Marquee"
        description="A CSS-only scrolling banner for announcements, logo strips, and repeated inline content."
      />

      <.component_demo title="Default" code={default_code()}>
        <div class="w-full rounded-lg border py-3 bg-card">
          <.marquee>
            <:item>
              <span class="inline-flex items-center gap-2 text-sm whitespace-nowrap text-foreground">
                <span class="text-primary">
                  <.icon name="lucide-sparkles" class="size-4" />
                </span>
                New components released weekly
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 text-sm whitespace-nowrap text-foreground">
                <span class="text-primary">
                  <.icon name="lucide-truck" class="size-4" />
                </span>
                Fast setup for Phoenix LiveView
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 text-sm whitespace-nowrap text-foreground">
                <span class="text-primary">
                  <.icon name="lucide-shield-check" class="size-4" />
                </span>
                Accessible defaults
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 text-sm whitespace-nowrap text-foreground">
                <span class="text-primary">
                  <.icon name="lucide-palette" class="size-4" />
                </span>
                CSS-first theming
              </span>
            </:item>
          </.marquee>
        </div>
      </.component_demo>

      <.section_heading id="ticker">Announcement Ticker</.section_heading>
      <.prose>
        Use a single-row marquee for concise messages. The content is duplicated
        internally so the loop stays continuous.
      </.prose>

      <.component_demo title="Ticker" code={ticker_code()}>
        <div class="w-full border-y py-2.5 bg-background">
          <.marquee speed="slow" gap="lg">
            <:item>
              <.ticker_item icon="lucide-package-check">Zero JavaScript dependencies</.ticker_item>
            </:item>
            <:item>
              <.ticker_item icon="lucide-moon">Dark mode included</.ticker_item>
            </:item>
            <:item>
              <.ticker_item icon="lucide-braces">Copy-paste friendly source</.ticker_item>
            </:item>
            <:item>
              <.ticker_item icon="lucide-circle-check">Phoenix 1.8 ready</.ticker_item>
            </:item>
          </.marquee>
        </div>
      </.component_demo>

      <.section_heading id="logos">Logo Strip</.section_heading>
      <.prose>
        Logo marquees work well for compact social proof and partner lists.
      </.prose>

      <.component_demo title="Trusted By" code={logos_code()}>
        <div class="w-full rounded-lg border py-4 bg-card">
          <.marquee speed="slow" gap="lg">
            <:item><.logo_item src="/images/logos/stripe.svg" name="Stripe" /></:item>
            <:item><.logo_item src="/images/logos/vercel.svg" name="Vercel" /></:item>
            <:item><.logo_item src="/images/logos/notion.svg" name="Notion" /></:item>
            <:item><.logo_item src="/images/logos/figma.svg" name="Figma" /></:item>
            <:item><.logo_item src="/images/logos/linear.svg" name="Linear" /></:item>
            <:item><.logo_item src="/images/logos/railway.svg" name="Railway" /></:item>
          </.marquee>
        </div>
      </.component_demo>

      <.section_heading id="speed">Speed</.section_heading>
      <.prose>
        Choose from <.inline_code>fast</.inline_code>, <.inline_code>default</.inline_code>, or
        <.inline_code>slow</.inline_code>
        speed presets.
      </.prose>

      <.component_demo title="Speed Presets" code={speed_code()}>
        <div class="grid w-full gap-3">
          <div class="rounded-md border py-2 bg-card">
            <.marquee speed="fast">
              <:item>
                <.plain_item tone="destructive">Fast cycle</.plain_item>
              </:item>
              <:item>
                <.plain_item tone="destructive">Urgent announcements</.plain_item>
              </:item>
              <:item>
                <.plain_item tone="destructive">Short copy only</.plain_item>
              </:item>
            </.marquee>
          </div>
          <div class="rounded-md border py-2 bg-card">
            <.marquee speed="slow" fade_edges={false}>
              <:item>
                <.plain_item>Slow cycle</.plain_item>
              </:item>
              <:item>
                <.plain_item>Comfortable reading pace</.plain_item>
              </:item>
              <:item>
                <.plain_item>Longer content works here</.plain_item>
              </:item>
            </.marquee>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="direction">Direction And Fade</.section_heading>
      <.prose>
        Reverse the animation with
        <.inline_code>direction="right"</.inline_code>
        or disable the edge mask with <.inline_code>fade_edges={false}</.inline_code>.
      </.prose>

      <.component_demo title="Reverse Direction" code={reverse_code()}>
        <div class="w-full rounded-lg border py-3 bg-card">
          <.marquee direction="right">
            <:item>
              <.plain_item>Right direction</.plain_item>
            </:item>
            <:item>
              <.plain_item>Reverse flow</.plain_item>
            </:item>
            <:item>
              <.plain_item>Same seamless loop</.plain_item>
            </:item>
          </.marquee>
        </div>
      </.component_demo>

      <.component_demo title="Without Edge Fade" code={no_fade_code()}>
        <div class="w-full rounded-lg border py-3 bg-card">
          <.marquee fade_edges={false}>
            <:item>
              <.plain_item>No gradient mask</.plain_item>
            </:item>
            <:item>
              <.plain_item>Sharp container edges</.plain_item>
            </:item>
            <:item>
              <.plain_item>Useful for clipped layouts</.plain_item>
            </:item>
          </.marquee>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  attr(:icon, :string, required: true)
  slot(:inner_block, required: true)

  defp ticker_item(assigns) do
    ~H"""
    <span class="inline-flex items-center gap-2 text-sm whitespace-nowrap text-foreground">
      <span class="inline-flex size-5 items-center justify-center rounded-full bg-primary text-primary-foreground">
        <.icon name={@icon} class="size-3" />
      </span>
      {render_slot(@inner_block)}
    </span>
    """
  end

  attr(:src, :string, required: true)
  attr(:name, :string, required: true)

  defp logo_item(assigns) do
    ~H"""
    <span class="inline-flex items-center gap-3 whitespace-nowrap px-2">
      <span class="inline-flex size-9 items-center justify-center rounded-md border bg-white">
        <img src={@src} alt="" class="size-5 object-contain" aria-hidden="true" />
      </span>
      <span class="text-sm font-medium text-foreground">{@name}</span>
    </span>
    """
  end

  attr(:tone, :string, default: "default")
  slot(:inner_block, required: true)

  defp plain_item(assigns) do
    assigns =
      assign(
        assigns,
        :dot_class,
        if(assigns.tone == "destructive", do: "bg-destructive", else: "bg-primary")
      )

    ~H"""
    <span class="inline-flex items-center gap-2 text-sm whitespace-nowrap text-foreground">
      <span class={["size-1.5 rounded-full", @dot_class]}></span>
      {render_slot(@inner_block)}
    </span>
    """
  end

  defp default_code do
    """
    <.marquee>
      <:item>New components released weekly</:item>
      <:item>Fast setup for Phoenix LiveView</:item>
      <:item>Accessible defaults</:item>
      <:item>CSS-first theming</:item>
    </.marquee>\
    """
  end

  defp ticker_code do
    """
    <.marquee speed="slow" gap="lg">
      <:item>Zero JavaScript dependencies</:item>
      <:item>Dark mode included</:item>
      <:item>Copy-paste friendly source</:item>
      <:item>Phoenix 1.8 ready</:item>
    </.marquee>\
    """
  end

  defp logos_code do
    """
    <.marquee speed="slow" gap="lg">
      <:item><img src="/images/logos/stripe.svg" alt="Stripe" /></:item>
      <:item><img src="/images/logos/vercel.svg" alt="Vercel" /></:item>
      <:item><img src="/images/logos/notion.svg" alt="Notion" /></:item>
      <:item><img src="/images/logos/figma.svg" alt="Figma" /></:item>
      <:item><img src="/images/logos/linear.svg" alt="Linear" /></:item>
      <:item><img src="/images/logos/railway.svg" alt="Railway" /></:item>
    </.marquee>\
    """
  end

  defp speed_code do
    """
    <.marquee speed="fast">...</.marquee>
    <.marquee speed="slow">...</.marquee>\
    """
  end

  defp reverse_code do
    """
    <.marquee direction="right">
      <:item>Right direction</:item>
      <:item>Reverse flow</:item>
      <:item>Same seamless loop</:item>
    </.marquee>\
    """
  end

  defp no_fade_code do
    """
    <.marquee fade_edges={false}>
      <:item>No gradient mask</:item>
      <:item>Sharp container edges</:item>
      <:item>Useful for clipped layouts</:item>
    </.marquee>\
    """
  end
end
