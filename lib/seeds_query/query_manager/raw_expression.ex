defmodule SeedsQuery.QueryManager.RawExpression do
  @moduledoc """
  Converts map of arguments into raw expression
  Handles lookup and match values
  """

  # alias SeedsQuery.QueryManager.ArgResolver
  alias SeedsQuery.ConfigManager
  alias SeedsQuery.QueryManager.Argument
  alias SeedsQuery.QueryManager.MongoQueryGenerator
  alias SeedsQuery.QueryManager.RawExpression
  defstruct [:lookup_info, :match_value]

  @type t() :: %RawExpression{
          match_value: map(),
          lookup_info: list()
        }
  @doc """
  Receives map of args and collection name

  Handles lookup and match for the keys

  Returns list of RawExpressions

  ## Examples
    iex> resolve(%{name: %{_eq: "some_user"}}, "users")
    [%RawExpression{lookup_info: [], match_value: %{name: %{_eq: "some_user"}}}]

    iex> resolve(%{profile: %{address: %{_eq: "melbourne"}}}, "users")
    [%RawExpression{
      lookup_info: [%{
        from: "user_profile",
        local_field: "id",
        foreign_field: "user_id",
        as: "profile"
      }],
      match_value: %{"profile.address" => %{_eq: "melbourne"}}
    }]

    iex> resolve(
    %{_and:
      [
        %{name: %{_eq: "some_user"}},
        %{profile: %{address: %{_eq: "melbourne"}}}
      ]
    }, "users")
    [%RawExpression{
      lookup_info: [%{
        from: "user_profile",
        local_field: "id",
        foreign_field: "user_id",
        as: "profile"
      }],
      match_value: %{_and: [%{name: %{_eq: "some_user"}}, %{"profile.address" => %{_eq: "melbourne"}}]}
    }]
  """
  @spec resolve(map(), MongoQueryGenerator.mongo_collection()) :: [RawExpression.t()]
  def resolve(args, collection) do
    Enum.map(args, &prepare_raw_expression(&1, collection))
  end

  defp prepare_raw_expression(expr, collection),
    do: prepare_raw_expression(expr, collection, nil)

  defp prepare_raw_expression({key, expr}, collection, parent_key) do
    case ConfigManager.get_argument(collection, convert_to_string(key)) do
      %Argument{
        resolve: "external",
        type: type,
        local_field: local_field,
        foreign_field: foreign_field,
        name: name
      } ->
        from = get_collection_name(type)
        foreign_field_argument = ConfigManager.get_argument(from, foreign_field)
        foreign_field = foreign_field_argument.local_field || foreign_field_argument.name

        %RawExpression{lookup_info: lookup_info} =
          raw_expr = prepare_raw_expression(expr, from, name)

        lookup_info = [
          %{local_field: local_field, foreign_field: foreign_field, as: name, from: from}
          | lookup_info
        ]

        Map.put(raw_expr, :lookup_info, lookup_info)

      argument ->
        argument = argument || %{}
        key = Map.get(argument, :local_field) || key

        key = get_key(key, parent_key)

        %RawExpression{match_value: match_value} =
          raw_expr = prepare_raw_expression(expr, collection)

        match_value = Map.put(%{}, key, match_value)
        Map.put(raw_expr, :match_value, match_value)
    end
  end

  defp prepare_raw_expression(expr, collection, parent_key) when is_list(expr) do
    result = %RawExpression{lookup_info: [], match_value: []}

    Enum.reduce(expr, result, fn arg,
                                 %RawExpression{
                                   lookup_info: lookup_info,
                                   match_value: match_value
                                 } ->
      %RawExpression{lookup_info: new_lookup_info, match_value: new_match_value} =
        prepare_raw_expression(arg, collection, parent_key)

      %RawExpression{
        lookup_info: lookup_info ++ new_lookup_info,
        match_value: [new_match_value | match_value]
      }
    end)
  end

  defp prepare_raw_expression(expr, collection, parent_key) when is_map(expr) do
    result = %RawExpression{lookup_info: [], match_value: %{}}

    Enum.reduce(expr, result, fn arg,
                                 %RawExpression{
                                   lookup_info: lookup_info,
                                   match_value: match_value
                                 } ->
      %RawExpression{lookup_info: new_lookup_info, match_value: new_match_value} =
        prepare_raw_expression(arg, collection, parent_key)

      %RawExpression{
        lookup_info: lookup_info ++ new_lookup_info,
        match_value: Map.merge(match_value, new_match_value)
      }
    end)
  end

  defp prepare_raw_expression(expr, _, _),
    do: %RawExpression{lookup_info: [], match_value: expr}

  defp get_collection_name("list:" <> collection_name), do: collection_name
  defp get_collection_name(collection_name), do: collection_name

  defp get_key(key, parent_key) when is_nil(parent_key), do: key

  defp get_key(key, parent_key),
    do: convert_to_string(parent_key) <> "." <> convert_to_string(key)

  defp convert_to_string(term) when is_binary(term), do: term
  defp convert_to_string(term) when is_atom(term), do: Atom.to_string(term)
end
