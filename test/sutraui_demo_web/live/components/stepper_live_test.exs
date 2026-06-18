defmodule SutrauiDemoWeb.Components.StepperLiveTest do
  use SutrauiDemoWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "typing in the wizard does not immediately mark the step as error", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs/components/stepper")

    html =
      render_change(view, "validate", %{
        "wizard" => %{"full_name" => "Maya Chen", "email" => "", "_unused_email" => ""}
      })

    wizard_nav =
      html
      |> String.split(~s(id="workspace-wizard"), parts: 2)
      |> List.last()
      |> String.split(~s(id="workspace-wizard-panel"), parts: 2)
      |> List.first()

    refute wizard_nav =~ ~s(data-state="error")

    wizard_panel = wizard_panel(html)

    refute wizard_panel =~ "can&#39;t be blank"
    refute wizard_panel =~ "Complete required fields"
  end

  test "submitting an incomplete wizard step marks only the current step as error", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs/components/stepper")

    html =
      view
      |> form("form", wizard: %{})
      |> render_submit()

    wizard_nav =
      html
      |> String.split(~s(id="workspace-wizard"), parts: 2)
      |> List.last()
      |> String.split(~s(id="workspace-wizard-panel"), parts: 2)
      |> List.first()

    assert wizard_nav =~ ~s(data-state="error")
    assert wizard_panel(html) =~ "can&#39;t be blank"
  end

  test "submitting a valid step advances without validating future fields", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs/components/stepper")

    html =
      view
      |> form("form", wizard: %{full_name: "Maya Chen", email: "maya@example.com"})
      |> render_submit()

    panel = wizard_panel(html)

    assert panel =~ "Company"
    refute panel =~ "can&#39;t be blank"
    refute panel =~ "Complete required fields"
  end

  defp wizard_panel(html) do
    html
    |> String.split(~s(id="workspace-wizard-panel"), parts: 2)
    |> List.last()
    |> String.split("stepper-wizard-actions", parts: 2)
    |> List.first()
  end
end
