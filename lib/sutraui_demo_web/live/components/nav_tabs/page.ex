defmodule SutrauiDemoWeb.Components.NavTabs.Page do
  @moduledoc "Shared markup of the three navigate-tabs demo LiveViews."
  use SutrauiDemoWeb, :html

  attr(:flash, :map, required: true)
  attr(:sutra_commands, :map, default: nil)
  attr(:value, :string, required: true)
  attr(:title, :string, required: true)
  slot(:inner_block, required: true)

  def page(assigns) do
    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/url-tabs"
    >
      <.docs_header
        title={@title}
        description="One of three separate LiveViews of the same live_session, joined by navigate tabs."
      />

      <div id="nav-tabs-page" class="space-y-6">
        <.tabs id="workbook-nav" value={@value} label="Workbook" class="w-full">
          <:tab value="overview" navigate="/docs/components/url-tabs/pages/overview">Overview</:tab>
          <:tab value="people" navigate="/docs/components/url-tabs/pages/people">People</:tab>
          <:tab value="billing" navigate="/docs/components/url-tabs/pages/billing">Billing</:tab>
        </.tabs>

        <div class="rounded-lg border p-4 text-sm">
          {render_slot(@inner_block)}
        </div>

        <.link navigate="/docs/components/url-tabs" class="text-sm underline">Back to URL tabs</.link>
      </div>
    </Layouts.docs>
    """
  end
end
