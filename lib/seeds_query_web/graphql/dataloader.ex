defmodule SeedsQueryWeb.Dataloader do
  @moduledoc """
  Dataloader for seeds query
  """
  alias SeedsQuery.ConfigManager
  alias SeedsQuery.QueryManager

  @type dataloader_option() :: [
          collection: String.t(),
          primary_key: String.t(),
          foreign_key: String.t()
        ]

  @spec load_lookup :: Dataloader.Source.t()
  def load_lookup do
    Dataloader.KV.new(&__MODULE__.fetch_lookup_data/2)
  end

  def fetch_lookup_data({_field, args, private_data}, data) do
    primary_key = private_data[:parent_key]
    collection = private_data[:type]
    foreign_key = private_data[:foreign_key]

    resolve(args, data,
      primary_key: primary_key,
      collection: collection,
      foreign_key: foreign_key
    )
  end

  @spec resolve(map(), list(), dataloader_option()) :: map()
  def resolve(args, parent_data, opts) do
    primary_key = opts[:primary_key]
    collection = opts[:collection]
    foreign_key = opts[:foreign_key]
    key_details = ConfigManager.get_argument(String.replace(collection, "list:", ""), foreign_key)
    key = key_details.local_field || key_details.name
    local_values = Enum.map(parent_data, & &1[primary_key]) |> Enum.uniq()

    where =
      Map.get(args, :where, %{})
      |> Map.put(foreign_key, %{_in: local_values})

    data =
      Map.put(args, :where, where)
      |> QueryManager.resolve(String.replace(collection, "list:", ""))
      |> Enum.group_by(& &1[key])

    parent_data
    |> Stream.map(fn p ->
      data = Map.get(data, p[primary_key], [])
      {p, extract_data(data, String.contains?(collection, "list:"))}
    end)
    |> Map.new()
  end

  defp extract_data(data, is_list?) when is_list(data) do
    if is_list? do
      data
    else
      List.first(data)
    end
  end
end
