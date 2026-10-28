defmodule SutrauiDemoWeb.Components.UrlTabsLive do
  use SutrauiDemoWeb, :live_view

  @tabs ~w(overview members notes)

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "URL tabs", visited: [], draft: "")}
  end

  def handle_params(_params, _uri, socket) do
    tab = Atom.to_string(socket.assigns.live_action)

    {:noreply,
     assign(socket,
       tab: tab,
       visited: SutraUI.Tabs.visit(socket.assigns.visited, tab)
     )}
  end

  def handle_event("draft", %{"draft" => draft}, socket) do
    {:noreply, assign(socket, :draft, draft)}
  end

  def render(assigns) do
    assigns = assign(assigns, :base, "/docs/components/url-tabs")

    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/url-tabs"
    >
      <.docs_header
        title="URL tabs"
        description="Tabs with their own URL: instant to switch, and a reload or a shared link lands on the right tab."
      />

      <.section_heading id="patch">Patch tabs</.section_heading>
      <.prose>
        Give each tab a
        <.inline_code>patch</.inline_code>
        and the tabs are routes of one LiveView. A click switches the active tab and panel on the client at once,
        then patches the URL; the app sets
        <.inline_code>value</.inline_code>
        from <.inline_code>handle_params</.inline_code>.
        Only the active panel is rendered unless you pass <.inline_code>keep</.inline_code>, which leaves visited panels in the DOM, hidden.
      </.prose>

      <.component_demo title="Patch tabs with keep" code={patch_code()}>
        <div class="w-full max-w-xl space-y-3">
          <.tabs
            nonce={@csp_nonce}
            id="course-tabs"
            value={@tab}
            keep={@visited}
            label="Course sections"
            class="w-full"
          >
            <:tab value="overview" patch={@base}>Overview</:tab>
            <:tab value="members" patch={@base <> "/members"}>Members</:tab>
            <:tab value="notes" patch={@base <> "/notes"}>Notes</:tab>
            <:panel value="overview">
              <div class="space-y-2 p-4">
                <h3 class="font-medium">Overview</h3>
                <p class="text-sm text-muted-foreground">
                  Five weeks, forty learners, one cohort starting on Monday.
                </p>
              </div>
            </:panel>
            <:panel value="members">
              <div class="space-y-3 p-4">
                <h3 class="font-medium">Members</h3>
                <.avatar_group
                  id="course-members"
                  nonce={@csp_nonce}
                  label="Course members"
                  max={4}
                  people={[
                    %{name: "Asha Rao"},
                    %{name: "Vikram Nair"},
                    %{name: "Meera Iyer"},
                    %{name: "Rahul Shah"},
                    %{name: "Divya Menon"}
                  ]}
                />
              </div>
            </:panel>
            <:panel value="notes">
              <div class="space-y-2 p-4">
                <h3 class="font-medium">Notes</h3>
                <.input
                  id="course-note"
                  name="note"
                  label="Scratch note (survives switching because of keep)"
                  value=""
                />
              </div>
            </:panel>
          </.tabs>
          <p class="text-sm text-muted-foreground">
            URL:
            <code id="url-tabs-path" class="font-mono text-xs">{@base <>
              if(@tab == "overview", do: "", else: "/" <> @tab)}</code>
          </p>
        </div>
      </.component_demo>

      <.prose>
        Try it: type in the note, switch to Members and back, then reload the page. The note is kept while you stay on the page (hidden panels stay
        in the DOM), and the reload lands on the same tab.
      </.prose>

      <.section_heading id="navigate">Navigate tabs</.section_heading>
      <.prose>
        Tabs that lead to <em>separate LiveViews</em>
        use <.inline_code>navigate</.inline_code>.
        The bar is a navigation landmark of links with
        <.inline_code>aria-current="page"</.inline_code>
        and there are no panels. Open one of the
        pages below to see the bar in place.
      </.prose>

      <.component_demo title="Navigate tabs" code={navigate_code()}>
        <div class="w-full max-w-xl">
          <.tabs id="workbook-nav" value="people" label="Workbook" class="w-full">
            <:tab value="overview" navigate="/docs/components/url-tabs/pages/overview">Overview</:tab>
            <:tab value="people" navigate="/docs/components/url-tabs/pages/people">People</:tab>
            <:tab value="billing" navigate="/docs/components/url-tabs/pages/billing">Billing</:tab>
          </.tabs>
          <p class="mt-3 text-sm text-muted-foreground">
            Each link is a different LiveView. Choose one to navigate.
          </p>
        </div>
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          Patch tabs use the ARIA tabs pattern with manual activation: arrows move focus, Enter or Space activates.
        </.list_item>
        <.list_item>
          Each tab is a real link, so open-in-new-tab and copy-link work.
        </.list_item>
        <.list_item>
          <.inline_code>keep={true}</.inline_code>
          renders every panel; a list of visited values (see <.inline_code>SutraUI.Tabs.visit/2</.inline_code>) renders only those.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  def tabs, do: @tabs

  defp patch_code do
    """
    # router
    live "/courses/:id", CourseLive, :overview
    live "/courses/:id/members", CourseLive, :members

    # LiveView
    def handle_params(_params, _uri, socket) do
      tab = Atom.to_string(socket.assigns.live_action)
      {:noreply, assign(socket, tab: tab, visited: SutraUI.Tabs.visit(socket.assigns.visited, tab))}
    end

    <.tabs id="course" value={@tab} keep={@visited} label="Course sections">
      <:tab value="overview" patch={~p"/courses/\#{@id}"}>Overview</:tab>
      <:tab value="members" patch={~p"/courses/\#{@id}/members"}>Members</:tab>
      <:panel value="overview">...</:panel>
      <:panel value="members">...</:panel>
    </.tabs>\
    """
  end

  defp navigate_code do
    """
    <.tabs id="workbook-nav" value="people" label="Workbook">
      <:tab value="overview" navigate={~p"/w/\#{@id}"}>Overview</:tab>
      <:tab value="people" navigate={~p"/w/\#{@id}/people"}>People</:tab>
      <:tab value="billing" navigate={~p"/w/\#{@id}/billing"}>Billing</:tab>
    </.tabs>\
    """
  end
end
