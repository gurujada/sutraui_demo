defmodule SutrauiDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SutrauiDemoWeb.Telemetry,
      SutrauiDemo.Repo,
      {DNSCluster, query: Application.get_env(:sutraui_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SutrauiDemo.PubSub},
      # Start a worker by calling: SutrauiDemo.Worker.start_link(arg)
      # {SutrauiDemo.Worker, arg},
      # Start to serve requests, typically the last entry
      SutrauiDemoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SutrauiDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SutrauiDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
