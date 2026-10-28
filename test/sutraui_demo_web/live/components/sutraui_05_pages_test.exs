defmodule SutrauiDemoWeb.Components.SutraUi05PagesTest do
  use SutrauiDemoWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias SutraUI.Commands.Test, as: CommandsTest

  # path, a selector that must be on the page, text that must be on the page
  @pages [
    {"/docs/components/time", "#rel-hours", "Relative time"},
    {"/docs/components/badge", "#badge-appearances", "Appearances"},
    {"/docs/components/avatar", "#team-group", "Avatar Group"},
    {"/docs/components/empty", "#empty-inline-demos", "Inline"},
    {"/docs/components/dialog", "#placement-buttons", "Placement"},
    {"/docs/components/tabs", "#view-mode", "Filter tabs"},
    {"/docs/components/url-tabs", "#course-tabs", "Patch tabs"},
    {"/docs/components/url-tabs/members", "#course-tabs", "Members"},
    {"/docs/components/url-tabs/pages/people", "#workbook-nav", "People"},
    {"/docs/components/toast", "#toast-kinds", "Update in place"},
    {"/docs/components/confirm", "#send-form", "data-confirm"},
    {"/docs/components/select", "#invite-form", "In a form, with errors"},
    {"/docs/components/date-picker", "#booking-form", "Booking form"},
    {"/docs/components/command-palette", "#open-palette-button", "One module per app"},
    {"/docs/components/command", "#open-command-dialog", "Command dialog"},
    {"/docs/components/input", "#country-input", "Select"}
  ]

  for {path, selector, text} <- @pages do
    test "#{path} mounts", %{conn: conn} do
      {:ok, view, html} = live(conn, unquote(path))
      assert has_element?(view, unquote(selector))
      assert html =~ unquote(text)
      assert has_element?(view, "#command-palette")
      assert has_element?(view, "#toast-group")
    end
  end

  test "pages carry the strict content security policy", %{conn: conn} do
    conn = get(conn, ~p"/docs/components/tooltip")
    [policy] = get_resp_header(conn, "content-security-policy")
    assert policy =~ "style-src 'self';"
    assert policy =~ "img-src 'self' data:"
    [_, nonce] = Regex.run(~r/script-src 'self' 'nonce-([\w-]+)'/, policy)
    assert html_response(conn, 200) =~ ~s(nonce="#{nonce}")
    refute html_response(conn, 200) =~ ~r/\sstyle="/
  end

  test "the palette lists every docs page and the demo's server actions", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs")
    actions = CommandsTest.actions(view)
    titles = CommandsTest.titles(actions)

    assert "Toast" in titles
    assert "Date & Time Pickers" in titles
    assert "Send a test toast" in titles
    assert "Toggle dark mode" in titles
  end

  test "the palette runs a server action and searches a server source", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs")

    assert :ok = CommandsTest.run(view, "demo.toast", %{kind: "success", message: "Hello"})
    assert {:error, _} = CommandsTest.run(view, "demo.toast", %{kind: "mauve"})
    assert {:error, _} = CommandsTest.run(view, "demo.locked", %{})

    assert [%{"title" => "Toast"} | _] = CommandsTest.search(view, :components, "toast")
  end

  test "the command palette page adds a page action that increments", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs/components/command-palette")

    assert "Add one to the counter on this page" in CommandsTest.titles(
             CommandsTest.actions(view)
           )

    render_hook(view, "increment", %{"by" => 1})
    assert has_element?(view, "#palette-counter", "1")
  end

  test "toast kinds, update in place and undo", %{conn: conn} do
    import SutraUI.Toast.Test

    {:ok, view, _html} = live(conn, ~p"/docs/components/toast")

    view |> element("#toast-kinds button", "Success") |> render_click()
    assert_toast(view, :success, "Changes saved.")

    view |> element("#toast-kinds button", "Error") |> render_click()
    assert_toast(view, :error, "Could not reach the server.")

    view |> element("#start-upload") |> render_click()
    assert_toast(view, :info, "Uploading lesson.mp4")
    send(view.pid, :upload_done)
    assert_toast(view, :success, "Uploaded lesson.mp4")

    view |> element("#delete-lesson") |> render_click()
    assert_toast(view, :info, "Lesson deleted")
  end

  test "a LiveComponent can send a toast", %{conn: conn} do
    import SutraUI.Toast.Test

    {:ok, view, _html} = live(conn, ~p"/docs/components/toast")
    view |> element("#component-toast-button") |> render_click()
    assert_toast(view, :info, "Sent from a LiveComponent (1)")
  end

  test "put_toast survives a push_navigate", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs/components/toast")
    view |> element("#save-redirect") |> render_click()
    {path, _flash} = assert_redirect(view)
    assert path == "/docs/components/toast"
  end

  test "the confirm dialog runs its verb", %{conn: conn} do
    import SutraUI.Confirm.Test
    import SutraUI.Toast.Test

    {:ok, view, _html} = live(conn, ~p"/docs/components/confirm")
    confirm(view, "#retire-confirm")
    assert_toast(view, :success, "Retired course physics-101")
  end

  test "the select form shows errors for a used field", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs/components/select")

    html =
      view
      |> form("#invite-form", invite: %{email: "a@b.in", role: ""})
      |> render_submit()

    assert html =~ "Choose a role"
  end

  test "url tabs follow the URL", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs/components/url-tabs")
    assert has_element?(view, "#course-tabs [role=tab][aria-selected=true]", "Overview")

    {:ok, view, _html} = live(conn, ~p"/docs/components/url-tabs/notes")
    assert has_element?(view, "#course-tabs [role=tab][aria-selected=true]", "Notes")
  end

  test "the date range keeps its posted values", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs/components/date-picker")

    html =
      view
      |> form("#period-form", period: %{start: "2026-11-02", end: "2026-12-30"})
      |> render_change()

    assert html =~ "Pick at most 14 days."
  end

  test "the New York picker names an ambiguous hour", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/docs/components/date-picker")
    assert render(view) =~ "Ambiguous"
  end
end
