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
    live "/docs/components/textarea", Components.TextareaLive, :index
    live "/docs/components/checkbox", Components.CheckboxLive, :index
    live "/docs/components/switch", Components.SwitchLive, :index
    live "/docs/components/radio-group", Components.RadioGroupLive, :index
    live "/docs/components/field", Components.FieldLive, :index
    live "/docs/components/slider", Components.SliderLive, :index
    live "/docs/components/range-slider", Components.RangeSliderLive, :index
    live "/docs/components/live-select", Components.LiveSelectLive, :index
    live "/docs/components/alert", Components.AlertLive, :index
    live "/docs/components/progress", Components.ProgressLive, :index
    live "/docs/components/spinner", Components.SpinnerLive, :index
    live "/docs/components/skeleton", Components.SkeletonLive, :index
    live "/docs/components/empty", Components.EmptyLive, :index
    live "/docs/components/avatar", Components.AvatarLive, :index
    live "/docs/components/kbd", Components.KbdLive, :index
    live "/docs/components/label", Components.LabelLive, :index
    live "/docs/components/tooltip", Components.TooltipLive, :index
    live "/docs/components/popover", Components.PopoverLive, :index
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
