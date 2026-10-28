defmodule SutrauiDemoWeb.Components.NavTabs.BillingLive do
  use SutrauiDemoWeb, :live_view

  alias SutrauiDemoWeb.Components.NavTabs.Page

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Billing tab")}
  end

  def render(assigns) do
    ~H"""
    <Page.page flash={@flash} sutra_commands={@sutra_commands} value="billing" title="Billing">
      Billing lives in a third LiveView.
    </Page.page>
    """
  end
end
