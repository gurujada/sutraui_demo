defmodule SutrauiDemoWeb.Components.AIComponentsLiveTest do
  use SutrauiDemoWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "response docs render the streaming examples", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/docs/components/response")

    assert html =~ "Streaming Text"
    assert html =~ ~s(phx-hook="SutraUI.Response.Response")
    assert html =~ "response-word"
    refute html =~ "answer-word"
    assert html =~ "Markdown"
  end

  test "activity docs render with explicit hook state attrs", %{conn: conn} do
    {:ok, view, html} = live(conn, ~p"/docs/components/activity")

    assert html =~ ~s(id="agent-activity-demo")
    assert html =~ ~s(data-playing="false")
    assert html =~ ~s(data-complete="false")

    html = render_click(view, "start_activity_demo", %{})

    assert html =~ ~s(id="agent-activity-demo")
    assert html =~ ~s(data-playing="true")
    assert html =~ ~s(data-complete="false")
  end
end
