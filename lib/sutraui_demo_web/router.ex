defmodule SutrauiDemoWeb.Router do
  use SutrauiDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SutrauiDemoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SutrauiDemoWeb do
    pipe_through :browser

    live "/", LandingLive, :index

    # Documentation pages
    live "/docs", Docs.IntroductionLive, :index
    live "/docs/installation", Docs.InstallationLive, :index
    live "/docs/theming", Docs.ThemingLive, :index

    # Component pages
    live "/docs/components/button", Components.ButtonLive, :index
    live "/docs/components/badge", Components.BadgeLive, :index
    live "/docs/components/card", Components.CardLive, :index
    live "/docs/components/input", Components.InputLive, :index
    live "/docs/components/select", Components.SelectLive, :index
    live "/docs/components/dialog", Components.DialogLive, :index
    live "/docs/components/toast", Components.ToastLive, :index
    live "/docs/components/tabs", Components.TabsLive, :index
    live "/docs/components/table", Components.TableLive, :index
    live "/docs/components/dropdown-menu", Components.DropdownMenuLive, :index
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:sutraui_demo, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SutrauiDemoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
