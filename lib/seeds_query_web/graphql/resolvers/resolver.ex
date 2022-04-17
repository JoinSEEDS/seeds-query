defmodule SeedsQueryWeb.Resolver do
  @moduledoc """
  common resolver for graphql queries
  """
  alias SeedsQuery.QueryManager
  alias SeedsQuery.QueryManager.MongoQueryGenerator

  @spec resolve(map(), MongoQueryGenerator.mongo_collection()) :: {:ok, list()}
  def resolve(args, collection) do
    data = QueryManager.resolve(args, collection)
    {:ok, data}
  end
end
