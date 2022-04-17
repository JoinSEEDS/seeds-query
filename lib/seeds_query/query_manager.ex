defmodule SeedsQuery.QueryManager do
  @moduledoc """
  Context functions to handle mongo query
  """
  alias SeedsQuery.QueryManager.MongoQueryGenerator

  @spec resolve(map(), MongoQueryGenerator.mongo_collection()) :: list()
  def resolve(args, collection) do
    query = MongoQueryGenerator.get_mongo_query(args, collection)

    Mongo.aggregate(:mongo_db, collection, query)
    |> Enum.to_list()
  end
end
