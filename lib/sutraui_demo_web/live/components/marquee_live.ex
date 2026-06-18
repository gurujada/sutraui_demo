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
        description="A CSS-only scrolling banner for announcements, logo strips, and repeating inline content."
      />

      <.component_demo title="Default" code={default_code()}>
        <div class="w-full rounded-lg border bg-card py-3">
          <.marquee>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <.icon name="lucide-sparkles" class="size-4 text-primary" />
                New components released weekly
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <.icon name="lucide-truck" class="size-4 text-primary" />
                Fast setup for Phoenix LiveView
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <.icon name="lucide-shield-check" class="size-4 text-primary" /> Accessible defaults
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <.icon name="lucide-palette" class="size-4 text-primary" /> CSS-first theming
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
        <div class="w-full border-y bg-background py-2.5">
          <.marquee speed="slow" gap="lg">
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <span class="inline-flex size-5 items-center justify-center rounded-full bg-primary text-primary-foreground">
                  <.icon name="lucide-package-check" class="size-3" />
                </span>
                Zero JavaScript dependencies
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <span class="inline-flex size-5 items-center justify-center rounded-full bg-primary text-primary-foreground">
                  <.icon name="lucide-moon" class="size-3" />
                </span>
                Dark mode included
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <span class="inline-flex size-5 items-center justify-center rounded-full bg-primary text-primary-foreground">
                  <.icon name="lucide-braces" class="size-3" />
                </span>
                Copy-paste friendly source
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <span class="inline-flex size-5 items-center justify-center rounded-full bg-primary text-primary-foreground">
                  <.icon name="lucide-circle-check" class="size-3" />
                </span>
                Phoenix 1.8 ready
              </span>
            </:item>
          </.marquee>
        </div>
      </.component_demo>

      <.section_heading id="logos">Logo Strip</.section_heading>
      <.prose>
        Logo marquees work well for compact social proof and partner lists.
      </.prose>

      <.component_demo title="Trusted By" code={logos_code()}>
        <div class="w-full rounded-lg border bg-card py-4">
          <.marquee speed="slow" gap="lg">
            <:item>
              <span class="inline-flex items-center gap-3 whitespace-nowrap px-2">
                <span class="inline-flex size-9 items-center justify-center rounded-md border bg-white">
                  <img src="/images/logos/stripe.svg" alt="" class="size-5 object-contain" />
                </span>
                <span class="text-sm font-medium text-foreground">Stripe</span>
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-3 whitespace-nowrap px-2">
                <span class="inline-flex size-9 items-center justify-center rounded-md border bg-white">
                  <img src="/images/logos/vercel.svg" alt="" class="size-5 object-contain" />
                </span>
                <span class="text-sm font-medium text-foreground">Vercel</span>
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-3 whitespace-nowrap px-2">
                <span class="inline-flex size-9 items-center justify-center rounded-md border bg-white">
                  <img src="/images/logos/notion.svg" alt="" class="size-5 object-contain" />
                </span>
                <span class="text-sm font-medium text-foreground">Notion</span>
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-3 whitespace-nowrap px-2">
                <span class="inline-flex size-9 items-center justify-center rounded-md border bg-white">
                  <img src="/images/logos/figma.svg" alt="" class="size-5 object-contain" />
                </span>
                <span class="text-sm font-medium text-foreground">Figma</span>
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-3 whitespace-nowrap px-2">
                <span class="inline-flex size-9 items-center justify-center rounded-md border bg-white">
                  <img src="/images/logos/linear.svg" alt="" class="size-5 object-contain" />
                </span>
                <span class="text-sm font-medium text-foreground">Linear</span>
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-3 whitespace-nowrap px-2">
                <span class="inline-flex size-9 items-center justify-center rounded-md border bg-white">
                  <img src="/images/logos/railway.svg" alt="" class="size-5 object-contain" />
                </span>
                <span class="text-sm font-medium text-foreground">Railway</span>
              </span>
            </:item>
          </.marquee>
        </div>
      </.component_demo>

      <.section_heading id="speed">Speed</.section_heading>
      <.prose>
        Choose from
        <.inline_code>fast</.inline_code>
        (8s),
        <.inline_code>default</.inline_code>
        (15s), or
        <.inline_code>slow</.inline_code>
        (27s) speed presets.
      </.prose>

      <.component_demo title="Speed Presets" code={speed_code()}>
        <div class="grid w-full gap-3">
          <div class="rounded-md border bg-card py-2">
            <.marquee speed="fast">
              <:item>
                <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                  <span class="size-1.5 rounded-full bg-destructive"></span> Fast cycle
                </span>
              </:item>
              <:item>
                <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                  <span class="size-1.5 rounded-full bg-destructive"></span> Urgent announcements
                </span>
              </:item>
              <:item>
                <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                  <span class="size-1.5 rounded-full bg-destructive"></span> Short copy only
                </span>
              </:item>
            </.marquee>
          </div>
          <div class="rounded-md border bg-card py-2">
            <.marquee speed="slow" fade_edges={false}>
              <:item>
                <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                  <span class="size-1.5 rounded-full bg-primary"></span> Slow cycle
                </span>
              </:item>
              <:item>
                <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                  <span class="size-1.5 rounded-full bg-primary"></span> Comfortable reading pace
                </span>
              </:item>
              <:item>
                <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                  <span class="size-1.5 rounded-full bg-primary"></span> Longer content works here
                </span>
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
        <div class="w-full rounded-lg border bg-card py-3">
          <.marquee direction="right">
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <span class="size-1.5 rounded-full bg-primary"></span> Right direction
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <span class="size-1.5 rounded-full bg-primary"></span> Reverse flow
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <span class="size-1.5 rounded-full bg-primary"></span> Same seamless loop
              </span>
            </:item>
          </.marquee>
        </div>
      </.component_demo>

      <.component_demo title="Without Edge Fade" code={no_fade_code()}>
        <div class="w-full rounded-lg border bg-card py-3">
          <.marquee fade_edges={false}>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <span class="size-1.5 rounded-full bg-primary"></span> No gradient mask
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <span class="size-1.5 rounded-full bg-primary"></span> Sharp container edges
              </span>
            </:item>
            <:item>
              <span class="inline-flex items-center gap-2 whitespace-nowrap text-sm text-foreground">
                <span class="size-1.5 rounded-full bg-primary"></span> Useful for clipped layouts
              </span>
            </:item>
          </.marquee>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.marquee>
      <:item>
        <.icon name="lucide-sparkles" class="size-4" /> New components released weekly
      </:item>
      <:item>
        <.icon name="lucide-truck" class="size-4" /> Fast setup for Phoenix LiveView
      </:item>
      <:item>
        <.icon name="lucide-shield-check" class="size-4" /> Accessible defaults
      </:item>
      <:item>
        <.icon name="lucide-palette" class="size-4" /> CSS-first theming
      </:item>
    </.marquee>\
    """
  end

  defp ticker_code do
    """
    <.marquee speed="slow" gap="lg">
      <:item>
        <.icon name="lucide-package-check" class="size-3" /> Zero JavaScript dependencies
      </:item>
      <:item>
        <.icon name="lucide-moon" class="size-3" /> Dark mode included
      </:item>
      <:item>
        <.icon name="lucide-braces" class="size-3" /> Copy-paste friendly source
      </:item>
      <:item>
        <.icon name="lucide-circle-check" class="size-3" /> Phoenix 1.8 ready
      </:item>
    </.marquee>\
    """
  end

  defp logos_code do
    """
    <.marquee speed="slow" gap="lg">
      <:item>
        <img src="/images/logos/stripe.svg" alt="Stripe" class="size-5" /> Stripe
      </:item>
      <:item>
        <img src="/images/logos/vercel.svg" alt="Vercel" class="size-5" /> Vercel
      </:item>
      <:item>
        <img src="/images/logos/notion.svg" alt="Notion" class="size-5" /> Notion
      </:item>
      <:item>
        <img src="/images/logos/figma.svg" alt="Figma" class="size-5" /> Figma
      </:item>
      <:item>
        <img src="/images/logos/linear.svg" alt="Linear" class="size-5" /> Linear
      </:item>
      <:item>
        <img src="/images/logos/railway.svg" alt="Railway" class="size-5" /> Railway
      </:item>
    </.marquee>\
    """
  end

  defp speed_code do
    """
    <.marquee speed="fast">
      <:item>Fast cycle</:item>
      <:item>Urgent announcements</:item>
      <:item>Short copy only</:item>
    </.marquee>
    <.marquee speed="slow" fade_edges={false}>
      <:item>Slow cycle</:item>
      <:item>Comfortable reading pace</:item>
      <:item>Longer content works here</:item>
    </.marquee>\
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
