defmodule SeedsQueryWeb.Schema do
  @moduledoc """
   Graphql Schema
  """
  use Absinthe.Schema

  @pipeline_modifier __MODULE__
  alias Absinthe.{Blueprint, Pipeline}
  alias SeedsQueryWeb.Dataloader, as: SeedsDataloader
  alias SeedsQueryWeb.Schema.DynamicSchemaTypes 

  import_types(SeedsQueryWeb.Schema.CommonTypes)
 
  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(:load_lookup, SeedsDataloader.load_lookup())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end
   
  def pipeline(pipeline) do
    Pipeline.insert_after(pipeline, Absinthe.Phase.Schema.TypeImports, __MODULE__)
  end

  def run(%Blueprint{} = blueprint, _) do
    %{schema_definitions: [schema]} = blueprint

    config =
      case SeedsQuery.ConfigReader.get_db_config() do
        {:ok, config} -> config
        _ -> []
      end

    input_objects = DynamicSchemaTypes.build_dynamic_input_objects(config)

    objects = DynamicSchemaTypes.build_dynamic_objects(config)

    query = DynamicSchemaTypes.build_query(config)

    schema =
      Map.update!(schema, :type_definitions, fn type_definitions ->
        [query] ++ objects ++ input_objects ++ type_definitions
      end)

    {:ok, %{blueprint | schema_definitions: [schema]}}
  end
end
