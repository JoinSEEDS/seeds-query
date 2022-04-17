defmodule SeedsQuery.SeedsHelpers do
  defp read_json(filename) do
    path = Path.absname(filename <> ".json", "priv/db/data")

    case File.read(path) do
      {:ok, contents} -> Jason.decode!(contents)
      _ -> []
    end
  end

  @spec insert :: :ok
  def insert do
    collections = read_json("collections")

    Enum.each(collections, fn collection_name ->
      docs = read_json(collection_name)
      Mongo.insert_many(:mongo_db, collection_name, docs)
    end)
  end

  @spec remove :: :ok
  def remove do
    collections = read_json("collections")

    Enum.each(collections, fn collection_name ->
      Mongo.drop_collection(:mongo_db, collection_name)
    end)
  end
end
