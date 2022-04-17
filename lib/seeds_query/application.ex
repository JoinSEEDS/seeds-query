defmodule SeedsQuery.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    mongo_url =
      case Application.get_env(:seeds_query, :mongo_blockchain_db)[:url] do
        {:system, var} -> System.get_env(var)
        url -> url
      end

    children = [
      # Start the Telemetry supervisor
      SeedsQueryWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SeedsQuery.PubSub},
      # Start the Endpoint (http/https)
      SeedsQueryWeb.Endpoint,
      # Start a worker by calling: SeedsQuery.Worker.start_link(arg)
      # {SeedsQuery.Worker, arg}
      %{
        id: Mongo,
        start: {Mongo, :start_link, [[name: :mongo_db, url: mongo_url, pool_size: 10]]}
      },
      # Config Manager
      SeedsQuery.ConfigManager
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SeedsQuery.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SeedsQueryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
