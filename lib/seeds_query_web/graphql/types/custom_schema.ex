defmodule SeedsQueryWeb.Schema.DynamicSchemaTypes do
  @moduledoc """
  Add input object, object, and query runtime
  """

  import Absinthe.Resolution.Helpers

  alias Absinthe.Blueprint
  alias Absinthe.Blueprint.Schema
  alias Absinthe.Middleware
  alias Absinthe.Schema.Notation
  alias Absinthe.Utils
  alias SeedsQueryWeb.Graphql.Types.Dynamic.TypeResolver
  alias SeedsQueryWeb.Graphql.Response.ResponseParser

  def build_dynamic_input_objects(table_schema_list) do
    Enum.map(table_schema_list, &build_dynamic_input_object/1)
  end

  def build_dynamic_input_object(%{
        "table_name" => table_name,
        "fields" => fields
      }) do
    input_object_identifier = format_field_id(table_name <> "_bool_exp")

    %Schema.InputObjectTypeDefinition{
      name: format_field_name(table_name <> "_bool_exp"),
      identifier: format_field_id(table_name <> "_bool_exp"),
      module: __MODULE__,
      __reference__: Notation.build_reference(__ENV__),
      __private__: [collection_info: %{name: table_name}],
      fields:
        Enum.map(fields, &build_dynamic_input_field/1) ++
          get_logical_input_fields(input_object_identifier)
    }
  end

  def build_dynamic_input_field(%{"name" => field_name, "type" => type}) do
    %Schema.InputValueDefinition{
      name: field_name,
      identifier: String.to_atom(field_name),
      placement: :input_field_definition,
      module: __MODULE__,
      __reference__: Notation.build_reference(__ENV__),
      type: TypeResolver.resolve_input(type)
    }
  end

  defp get_logical_input_fields(input_object_identifier) do
    Enum.map(["_or", "_and"], fn field_name ->
      build_dynamic_input_field(%{
        "name" => field_name,
        "type" => %Blueprint.TypeReference.List{of_type: input_object_identifier}
      })
    end)
  end

  def build_dynamic_objects(schema_list) do
    Enum.map(schema_list, &build_dynamic_object/1)
  end

  def build_dynamic_object(%{"table_name" => table_name, "fields" => fields, "key" => key}) do
    %Schema.ObjectTypeDefinition{
      name: format_field_name(table_name),
      identifier: format_field_id(table_name),
      module: __MODULE__,
      fields: build_dynamic_object_fields(fields, key)
    }
  end

  def build_dynamic_object_fields(fields, key) do
    Enum.map(fields, &build_dynamic_object_field(&1, key))
  end

  def build_dynamic_object_field(
        %{
          "name" => field_name,
          "type" => type,
          "resolve" => "self"
        } = params,
        _key
      ) do
    resolved_type = TypeResolver.resolve(type)

    %Schema.FieldDefinition{
      name: Atom.to_string(format_field_id(field_name)),
      identifier: format_field_id(field_name),
      __private__: [resolve_key: params["local_field"] || field_name],
      arguments: [],
      type: resolved_type,
      middleware: [
        &__MODULE__.handle_self_field/2
      ]
    }
  end

  def build_dynamic_object_field(
        %{
          "name" => field_name,
          "type" => type,
          "resolve" => "external"
        } = field_params,
        _key
      ) do
    %Schema.FieldDefinition{
      name: Atom.to_string(format_field_id(field_name)),
      identifier: format_field_id(field_name),
      __private__: [
        name: field_name,
        type: type,
        parent_key: field_params["local_field"] || field_name,
        foreign_key: Map.get(field_params, "external_field")
      ],
      arguments: build_arguments(String.replace(type, "list:", "")),
      type: TypeResolver.resolve(type),
      middleware: [
        &__MODULE__.handle_dataloader/2
      ]
    }
  end

  def build_query(schema_list) do
    %Schema.ObjectTypeDefinition{
      name: "RootQueryType",
      identifier: :query,
      module: SeedsQueryWeb.Schema,
      fields: Enum.map(schema_list, &build_list_query_field/1)
    }
  end

  def build_list_query_field(%{"table_name" => table_name}) do
    %Schema.FieldDefinition{
      __private__: [collection: table_name],
      name: Atom.to_string(format_field_id("list_" <> table_name)),
      identifier: format_field_id("list_" <> table_name),
      type: TypeResolver.resolve("list:" <> table_name),
      arguments: build_arguments(table_name),
      middleware: [
        &__MODULE__.handle_query_field/2
      ]
    }
  end

  def build_arguments(table_name) do
    [
      %Schema.InputValueDefinition{
        name: "where",
        identifier: :where,
        module: __MODULE__,
        __reference__: Notation.build_reference(__ENV__),
        type: TypeResolver.resolve_input(table_name)
      },
      %Schema.InputValueDefinition{
        name: "limit",
        identifier: :limit,
        module: __MODULE__,
        __reference__: Notation.build_reference(__ENV__),
        type: :integer,
        default_value: 100
      },
      %Schema.InputValueDefinition{
        name: "skip",
        identifier: :skip,
        module: __MODULE__,
        __reference__: Notation.build_reference(__ENV__),
        type: :integer
      }
    ]
  end

  def handle_dataloader(resolution, _config) do
    loader = resolution.context.loader
    arg = resolution.definition.argument_data
    name = resolution.definition.name
    parent_name = resolution.definition.parent_type.name

    private_data = resolution.definition.schema_node.__private__

    loader_key = "#{parent_name}_#{name}"

    {_, _, {loader, callback}} =
      loader
      |> Dataloader.load(:load_lookup, {loader_key, arg, private_data}, resolution.source)
      |> on_load(fn loader ->
        {:ok,
         Dataloader.get(loader, :load_lookup, {loader_key, arg, private_data}, resolution.source)}
      end)

    Middleware.Dataloader.call(resolution, {loader, callback})
  end

  def handle_self_field(resolution, _) do
    node = resolution.definition.schema_node
    resolve_key = node.__private__[:resolve_key]

    value =
      resolution.source[resolve_key]
      |> ResponseParser.parse_response(node.type)

    Absinthe.Resolution.put_result(resolution, {:ok, value})
  end

  def handle_query_field(resolution, _) do
    args = resolution.definition.argument_data
    collection = resolution.definition.schema_node.__private__[:collection]

    Absinthe.Resolution.put_result(
      resolution,
      SeedsQueryWeb.Resolver.resolve(args, collection)
    )
  end

  def format_field_name(name),
    do: name |> String.replace(~r/[^a-zA-Z0-9 ]/, "_") |> Utils.camelize()

  def format_field_id(name),
    do: name |> String.replace(~r/[^a-zA-Z0-9 ]/, "_") |> String.to_atom()
end
