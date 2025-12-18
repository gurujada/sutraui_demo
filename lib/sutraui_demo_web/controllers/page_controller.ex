defmodule SutrauiDemoWeb.PageController do
  use SutrauiDemoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
