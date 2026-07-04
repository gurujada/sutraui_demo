defmodule SutrauiDemoWeb.NotFoundHTML do
  use SutrauiDemoWeb, :html

  def not_found(assigns) do
    assigns = Map.merge(%{flash: %{}, path: nil}, assigns)

    ~H"""
    <Layouts.app flash={@flash}>
      <section class="min-h-[calc(100vh-4rem)] px-6 py-24">
        <div class="mx-auto max-w-2xl">
          <p class="section-label">404</p>
          <h1 class="section-title mt-3">This route wandered out of the docs.</h1>
          <p class="section-subtitle mt-4">
            We looked for <span class="font-mono text-sm">{@path}</span>, but Sutra UI does not have a page there.
          </p>
          <div class="mt-8 flex flex-col gap-3 sm:flex-row">
            <.button navigate="/docs/components">Browse components</.button>
            <.button variant="outline" navigate="/docs">Back to docs</.button>
          </div>
        </div>
      </section>
    </Layouts.app>
    """
  end
end
