defmodule SutrauiDemoWeb.Components.IndexLiveTest do
  use SutrauiDemoWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "components index renders grouped component links", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/docs/components")

    assert html =~ "Components"
    assert html =~ "Form Inputs"
    assert html =~ ~s(href="/docs/components/button")
    assert html =~ ~s(href="/docs/components/response")
    assert html =~ "New"
    assert html =~ "🔥"
    assert html =~ "bg-blue-500/10"
  end

  test "registered docs navigation links resolve to real routes" do
    paths =
      ["/docs/components"] ++
        for section <- SutrauiDemoWeb.Layouts.nav_items(),
            item <- section.items,
            do: item.href

    for path <- paths do
      route_info =
        Phoenix.Router.route_info(SutrauiDemoWeb.Router, "GET", path, "www.example.com")

      refute route_info.plug == SutrauiDemoWeb.NotFoundController
    end
  end

  test "breadcrumb docs use valid demo routes", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/docs/components/breadcrumb")

    assert html =~ ~s(href="/docs/components")
    refute html =~ ~s(navigate="/products")
    refute html =~ ~s(href="/products")
    refute html =~ "github.com/sutra-ui"
  end

  test "unknown routes render the custom 404 page", %{conn: conn} do
    conn = get(conn, "/docs/components/not-real")

    assert html_response(conn, 404) =~ "This route wandered out of the docs."
    assert conn.resp_body =~ "/docs/components/not-real"
  end
end
