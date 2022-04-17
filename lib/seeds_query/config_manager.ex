defmodule SeedsQuery.ConfigManager do
  @moduledoc """
  Config Manager for seeds query
  """

  use GenServer

  alias SeedsQuery.ConfigReader
  alias SeedsQuery.QueryManager.Argument

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    case ConfigReader.get_db_config() do
      {:ok, config} ->
        argument_mapping = Argument.get_argument_mapping(config)
        {:ok, argument_mapping}

      _ ->
        {:ok, %{}}
    end
  end

  def handle_call(:fetch, _from, state) do
    {:reply, state, state}
  end

  def get_argument(collection, key) do
    GenServer.call(__MODULE__, :fetch)
    |> Map.get(collection <> "_" <> key)
  end
end
