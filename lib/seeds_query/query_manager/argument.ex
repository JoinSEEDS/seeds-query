defmodule SeedsQuery.QueryManager.Argument do
  @moduledoc """
    argument struct for mapping graphql arg to mongo fields
  """
  alias SeedsQuery.QueryManager.MongoQueryGenerator

  @enforce_keys [:name, :type, :resolve]
  defstruct [:name, :local_field, :foreign_field, :type, :resolve]

  @type t() :: %__MODULE__{
          name: String.t(),
          local_field: String.t(),
          foreign_field: String.t(),
          type: String.t(),
          resolve: String.t()
        }

  @type lookup() :: %{
          from: MongoQueryGenerator.mongo_collection(),
          local_field: String.t(),
          foreign_field: String.t(),
          as: String.t()
        }
  def cast(params) when is_map(params) do
    %__MODULE__{
      name: params["name"],
      local_field: params["local_field"] || params["name"],
      foreign_field: params["external_field"],
      type: params["type"],
      resolve: params["resolve"] || "self"
    }
  end

  def get_argument_mapping(params) when is_list(params) do
    Enum.reduce(params, %{}, fn table_params, acc ->
      get_argument_mapping(table_params)
      |> Map.merge(acc)
    end)
  end

  def get_argument_mapping(%{"table_name" => table_name, "fields" => fields}) do
    Enum.reduce(fields, %{}, fn field_params, acc ->
      {key, argument} = get_argument_mapping(field_params, table_name)
      Map.put(acc, key, argument)
    end)
  end

  def get_argument_mapping(field_params, table_name) when is_map(field_params) do
    %__MODULE__{name: name} = argument = cast(field_params)
    key = table_name <> "_" <> name
    {key, argument}
  end
end
