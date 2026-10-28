defmodule SutrauiDemoWeb.Components.CommandPaletteLive do
  use SutrauiDemoWeb, :live_view

  alias SutraUI.Commands.Action

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(page_title: "Command palette", count: 0)
      |> SutraUI.Commands.put_page_actions([
        Action.new(
          id: "page.increment",
          title: "Add one to the counter on this page",
          section: "This page",
          icon: "lucide-plus",
          shortcut: "g i",
          event: "increment",
          payload: %{by: 1}
        )
      ])

    {:ok, socket}
  end

  def handle_event("increment", params, socket) do
    by = params["by"] || 1
    {:noreply, assign(socket, :count, socket.assigns.count + by)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/command-palette"
    >
      <.docs_header
        title="Command palette"
        description="Search, shortcuts and server actions in one box. Press mod+k on any page of this site."
      />

      <.callout>
        <strong>Try it now.</strong>
        Press
        <.kbd>Ctrl</.kbd>
        +
        <.kbd>K</.kbd>
        (<.kbd>Cmd</.kbd>
        +
        <.kbd>K</.kbd>
        on a Mac) or use the button below. This site's palette has every docs page, shortcuts
        (<.inline_code>g h</.inline_code>, <.inline_code>g c</.inline_code>), a server search of components, server actions with arguments and a confirmation.
      </.callout>

      <.component_demo title="Open the palette" code={layout_code()}>
        <div class="flex flex-wrap items-center gap-4">
          <.button
            id="open-palette-button"
            variant="outline"
            phx-click={SutraUI.Commands.Palette.show_palette("command-palette")}
          >
            <.icon name="lucide-search" class="mr-2 size-4" /> Open the palette
          </.button>
          <span class="text-sm text-muted-foreground">
            Page action counter: <strong id="palette-counter">{@count}</strong>
          </span>
        </div>
      </.component_demo>

      <.section_heading id="module">One module per app</.section_heading>
      <.prose>
        <.inline_code>use SutraUI.Commands</.inline_code>
        and return what this person may do now from <.inline_code>actions/1</.inline_code>.
        It is read per socket on mount and on every <.inline_code>handle_params</.inline_code>.
      </.prose>
      <.code_block language="elixir" code={module_code()} />

      <.section_heading id="kinds">What an action does</.section_heading>
      <.prose>
        An action does exactly one of these when chosen.
      </.prose>

      <div id="action-kinds" class="my-4 overflow-hidden rounded-lg border text-sm">
        <div
          :for={{kind, desc, try_it} <- kinds()}
          class="grid grid-cols-[8rem_1fr] gap-3 border-b px-4 py-2 last:border-b-0"
        >
          <code class="font-mono text-xs">{kind}</code>
          <span>{desc} <span class="text-muted-foreground">{try_it}</span></span>
        </div>
      </div>

      <.section_heading id="try">Try these in the palette</.section_heading>
      <.list>
        <.list_item>
          <strong>Navigate:</strong>
          type "tool" and Enter to open Tooltip; type "dialg" (a typo in a five-letter word) to see it still find Dialog.
        </.list_item>
        <.list_item>
          <strong>Children:</strong>
          "Change color theme" opens a page of themes; Backspace on an empty box goes back one step.
        </.list_item>
        <.list_item>
          <strong>Args and a server action:</strong>
          "Send a test toast" asks for a kind, then a message, then runs on the server.
        </.list_item>
        <.list_item>
          <strong>Server search source:</strong>
          "Pick a component to look up" searches the Components source on the server. A result's own actions open with the right arrow.
        </.list_item>
        <.list_item>
          <strong>Confirm and danger:</strong>
          "Reset the demo" asks first, with a Reset button and Cancel.
        </.list_item>
        <.list_item>
          <strong>Disabled with a reason:</strong> "Publish the docs" says why it cannot run.
        </.list_item>
        <.list_item>
          <strong>Page action:</strong>
          "Add one to the counter on this page" exists only here, and leaves when you navigate away. Its shortcut is <.inline_code>g i</.inline_code>.
        </.list_item>
        <.list_item>
          <strong>Shortcuts:</strong>
          press
          <.kbd>?</.kbd>
          in the palette's page (not while typing) to list them. Recent actions are kept in this browser.
        </.list_item>
      </.list>

      <.section_heading id="keys">Keys</.section_heading>
      <.list>
        <.list_item>
          Arrow up and down move; Enter runs; Escape goes back one step, then closes.
        </.list_item>
        <.list_item>
          Search runs in the browser for actions (words in order, starts of words first, one typo in a word of five letters or more, accents and case ignored) and in Elixir for server sources; an older answer never covers a newer one.
        </.list_item>
        <.list_item>
          Server actions are looked up again by id;
          <.inline_code>allow</.inline_code>
          is checked again and arguments are validated before they run.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp kinds do
    [
      {"navigate", "live_redirect to a path.", "Every docs page."},
      {"patch", "live_patch to a path of the same LiveView.", ""},
      {"href", "Browser navigation (http, https or mailto).", ""},
      {"event", "Pushes an event to the page's LiveView.", "The counter on this page."},
      {"js", "Runs a JS command.", "Toggle dark mode."},
      {"copy", "Copies a text.", "Copy the dependency line."},
      {"run", "A server function, with optional args and confirm.", "Send a test toast."}
    ]
  end

  defp layout_code do
    """
    # router: every LiveView in the session gets the palette's events and actions
    live_session :default, on_mount: [{SutraUI.Commands.Live, MyAppWeb.Commands}] do
      ...
    end

    # layout, once
    <.command_palette id="command-palette" commands={@sutra_commands} />
    <.button phx-click={SutraUI.Commands.Palette.show_palette("command-palette")}>Search</.button>\
    """
  end

  defp module_code do
    """
    defmodule MyAppWeb.Commands do
      use SutraUI.Commands
      alias SutraUI.Commands.Action

      @impl true
      def actions(_socket) do
        [
          Action.new(id: "go.home", title: "Go to the home page", section: "Shortcuts",
                     shortcut: "g h", navigate: "/"),
          Action.new(id: "theme.toggle", title: "Toggle dark mode",
                     js: Phoenix.LiveView.JS.dispatch("phx:toggle-theme")),
          Action.new(
            id: "demo.toast",
            title: "Send a test toast",
            args: [
              %{name: :kind, label: "Which kind?", type: :choice,
                choices: [{"info", "Info"}, {"error", "Error"}]},
              %{name: :message, label: "Message", type: :text, required: false}
            ],
            run: fn socket, args ->
              SutraUI.Toast.send(String.to_existing_atom(args.kind), args[:message] || "Hello")
              {:ok, socket}
            end
          ),
          Action.new(id: "demo.reset", title: "Reset the demo", tone: :danger,
                     confirm: "Reset every demo?", confirm_label: "Reset",
                     run: fn socket, _args -> {:ok, socket} end)
        ]
      end

      @impl true
      def sources, do: [components: "Components"]

      @impl true
      def search(:components, query, _socket) do
        for item <- MyApp.Catalog.search(query) do
          Action.new(id: "component:\#{item.slug}", title: item.name, navigate: item.path,
                     children: [Action.new(id: "component:\#{item.slug}:copy",
                                           title: "Copy the link", copy: item.path)])
        end
      end
    end

    # one page's own actions; they leave with the page
    SutraUI.Commands.put_page_actions(socket, [Action.new(...)])\
    """
  end
end
