defmodule SutrauiDemoWeb.Components.TreeViewLiveTest do
  use SutrauiDemoWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "selecting a tree node updates the rendered selected item", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs/components/tree-view")

    html = render_click(view, "select_node", %{"node" => "billing"})

    assert html =~ "Selected: <strong class=\"text-foreground\">billing</strong>"

    assert tree_item(html, "billing") =~ ~s(aria-selected="true")
    refute tree_item(html, "general") =~ ~s(aria-selected="true")
  end

  defp tree_item(html, value) do
    html
    |> String.split(~s(data-value="#{value}"), parts: 2)
    |> List.first()
    |> String.split("<div", trim: true)
    |> List.last()
  end
end
