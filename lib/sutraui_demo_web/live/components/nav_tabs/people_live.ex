defmodule SutrauiDemoWeb.Components.NavTabs.PeopleLive do
  use SutrauiDemoWeb, :live_view

  alias SutrauiDemoWeb.Components.NavTabs.Page

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "People tab")}
  end

  def render(assigns) do
    ~H"""
    <Page.page flash={@flash} sutra_commands={@sutra_commands} value="people" title="People">
      People are listed here, also a separate LiveView.
    </Page.page>
    """
  end
end
