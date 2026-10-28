defmodule SutrauiDemoWeb.Components.NavTabs.OverviewLive do
  use SutrauiDemoWeb, :live_view

  alias SutrauiDemoWeb.Components.NavTabs.Page

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Overview tab")}
  end

  def render(assigns) do
    ~H"""
    <Page.page flash={@flash} sutra_commands={@sutra_commands} value="overview" title="Overview">
      The overview is its own LiveView.
    </Page.page>
    """
  end
end
