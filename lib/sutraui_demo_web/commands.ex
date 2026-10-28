defmodule SutrauiDemoWeb.Commands do
  @moduledoc """
  The demo's command palette (`mod+k` on every page): navigation to every docs page, shortcuts,
  client actions (theme, copy), server actions with arguments and confirmation, and a server
  search source for components.
  """
  use SutraUI.Commands

  alias Phoenix.LiveView.JS
  alias SutraUI.Commands.Action
  alias SutraUI.Toast
  alias SutrauiDemoWeb.Layouts

  @themes [
    {"neutral", "Neutral"},
    {"blue", "Blue"},
    {"green", "Green"},
    {"rose", "Rose"},
    {"orange", "Orange"},
    {"violet", "Violet"}
  ]

  @impl true
  def actions(_socket), do: static_actions() ++ demo_actions()

  @doc "Actions that need no server (the 404 page uses these without a LiveView)."
  def static_actions do
    pages() ++
      [
        Action.new(
          id: "go.home",
          title: "Go to the home page",
          section: "Shortcuts",
          shortcut: "g h",
          icon: "lucide-house",
          navigate: "/"
        ),
        Action.new(
          id: "go.docs",
          title: "Go to the documentation",
          section: "Shortcuts",
          shortcut: "g d",
          icon: "lucide-book-open",
          navigate: "/docs"
        ),
        Action.new(
          id: "go.components",
          title: "Go to all components",
          section: "Shortcuts",
          shortcut: "g c",
          icon: "lucide-layout-grid",
          navigate: "/docs/components"
        ),
        Action.new(
          id: "theme.toggle",
          title: "Toggle dark mode",
          section: "Appearance",
          shortcut: "g t",
          keywords: ["light", "dark", "theme"],
          icon: "lucide-sun-moon",
          js: JS.dispatch("phx:toggle-theme")
        ),
        Action.new(
          id: "theme.color",
          title: "Change color theme",
          section: "Appearance",
          keywords: ["accent", "palette"],
          icon: "lucide-palette",
          children:
            for {id, label} <- @themes do
              Action.new(
                id: "theme.color.#{id}",
                title: label,
                js: JS.dispatch("phx:set-color-theme", detail: %{theme: id})
              )
            end
        ),
        Action.new(
          id: "copy.dep",
          title: "Copy the dependency line",
          section: "Install",
          keywords: ["mix.exs", "hex", "deps"],
          icon: "lucide-copy",
          copy: ~s|{:sutra_ui, "~> 0.5"}|
        )
      ]
  end

  # Server-side actions: they run in the LiveView, are looked up again by id and have their
  # arguments checked before they run.
  defp demo_actions do
    [
      Action.new(
        id: "demo.toast",
        title: "Send a test toast",
        section: "Server actions",
        keywords: ["notification", "message"],
        icon: "lucide-bell",
        args: [
          %{
            name: :kind,
            label: "Which kind?",
            type: :choice,
            choices: [
              {"info", "Info"},
              {"success", "Success"},
              {"warning", "Warning"},
              {"error", "Error"}
            ]
          },
          %{name: :message, label: "Message", type: :text, required: false, max_length: 80}
        ],
        run: fn socket, args ->
          kind = String.to_existing_atom(args.kind)

          message =
            if args[:message] in [nil, ""],
              do: "Sent from the command palette",
              else: args.message

          Toast.send(kind, message)
          {:ok, socket}
        end
      ),
      Action.new(
        id: "demo.compare",
        title: "Pick a component to look up",
        section: "Server actions",
        icon: "lucide-search",
        args: [%{name: :component, label: "Which component?", type: :search, source: :components}],
        run: fn socket, args ->
          Toast.send(:info, "You picked #{args.component}")
          {:ok, socket}
        end
      ),
      Action.new(
        id: "demo.reset",
        title: "Reset the demo",
        section: "Server actions",
        tone: :danger,
        icon: "lucide-rotate-ccw",
        confirm: "Reset every demo to its start?",
        confirm_label: "Reset",
        run: fn socket, _args ->
          Toast.send(:success, "Demo reset")
          {:ok, socket}
        end
      ),
      Action.new(
        id: "demo.locked",
        title: "Publish the docs",
        section: "Server actions",
        icon: "lucide-lock",
        disabled: "Needs the owner's sign-off",
        run: fn socket, _ -> {:ok, socket} end
      )
    ]
  end

  defp pages do
    for section <- Layouts.nav_items(), item <- section.items do
      Action.new(
        id: "page." <> item.href,
        title: item.label,
        section: section.group,
        keywords: item.keywords,
        badge: item[:marker],
        icon: "lucide-file-text",
        navigate: item.href
      )
    end
  end

  @impl true
  def sources, do: [components: "Components"]

  @impl true
  def search(:components, query, _socket) do
    query = String.downcase(query)

    for section <- Layouts.nav_items(),
        item <- section.items,
        String.starts_with?(item.href, "/docs/components/"),
        String.contains?(
          String.downcase(item.label <> " " <> Enum.join(item.keywords, " ")),
          query
        ) do
      Action.new(
        id: "component." <> item.href,
        title: item.label,
        value: item.label,
        navigate: item.href,
        children: [
          Action.new(
            id: "component.open." <> item.href,
            title: "Open the page",
            navigate: item.href
          ),
          Action.new(id: "component.copy." <> item.href, title: "Copy the link", copy: item.href)
        ]
      )
    end
  end
end
