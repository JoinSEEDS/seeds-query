defmodule SeedsQuery.QueryManager.MongoQueryGenerator do
  @moduledoc """
  Mongo query equivalent of query expression
  """
  alias SeedsQuery.QueryManager.QueryExpression
  alias SeedsQuery.QueryManager.RawExpression

  @type t() :: %{
          where: map(),
          skip: integer(),
          limit: integer()
        }
  @type mongo_collection() :: String.t()
  @match_expr_mapping %{
    _and: "$and",
    _or: "$or",
    _not: "$not",
    _eq: "$eq",
    _ne: "$ne",
    _gt: "$gt",
    _gte: "$gte",
    _lt: "$lt",
    _lte: "$lte",
    _in: "$in",
    _nin: "$nin"
  }

  @lookup_expr_mapping %{
    from: "from",
    local_field: "localField",
    foreign_field: "foreignField",
    as: "as"
  }

  @doc """
  Recieves list of mongo query and collection

  Returns list of match and lookup query for mongodb

  ## Examples
    iex> get_mongo_query([%QueryExpression{match: %{name: %{_eq: "some_user"}, lookup: nil}])
    [%{"$match" => %{"name" => %{"$eq" => "some_user}}}]

    iex> get_mongo_query([%QueryExpression{
      lookup: %{
        from: "user_profile",
        local_field: "id",
        foreign_field: "user_id",
        as: "profile"
      },
      match: %{"profile.address" => %{_eq: "melbourne"}}
    }])
    [
      %{"$lookup" => %{
          "from" => "user_profile",
          "localField" => "id",
          "foreignField" => "user_id",
          "as" => "profile"
        }},
        %{"$match" => %{"profile.address" => %{"$eq" => "some_user"}}}
      ]


    iex> get_mongo_query([%QueryExpression{
      lookup: %{
        from: "user_profile",
        local_field: "id",
        foreign_field: "user_id",
        as: "profile"
      },
      match: %{_and: [%{name: %{_eq: "some_user"}}, %{"profile.address" => %{_eq: "melbourne"}}]}
    }])
    [
      %{"$lookup" => %{
          "from" => "user_profile",
          "localField" => "id",
          "foreignField" => "user_id",
          "as" => "profile"
        }},
        %{"$match" => %{"$and" => [%{"name" => %{"$eq" => "some_user"}}, %{"profile.address" => %{"$eq": "melbourne"}}]}}
    ]

    iex> get_mongo_query([
        %QueryExpression{match: %{name: %{_eq: "some_user"}}, lookup: nil},
        %QueryExpression{lookup: %{
            from: "user_profile",
            local_field: "id",
            foreign_field: "user_id",
            as: "profile"
          },
          match: nil
          },
        %QueryExpression{match: %{"profile.address" => %{_eq: "melbourne"}}, lookup: nil}
      ])
      [
        %{"$match" => %{"name" => %{"$eq" => "some_user}}},
        %{"$lookup" => %{
          "from" => "user_profile",
          "localField" => "id",
          "foreignField" => "user_id",
          "as" => "profile"
        }},
        %{"$match" => %{"profile.address" => %{"$eq" => "some_user"}}}
      ]
  """
  @spec get_mongo_query(QueryGenerator.t(), mongo_collection()) :: list()
  def get_mongo_query(args, collection) do
    Enum.reduce(args, [], &prepare_mongo_query(&1, &2, collection))
  end

  defp prepare_mongo_query({:where, where_args}, query, collection) do
    match_and_lookup_list =
      RawExpression.resolve(where_args, collection)
      |> QueryExpression.resolve()
      |> Enum.map(&prepare_mongo_query/1)

    match_and_lookup_list ++ query
  end

  defp prepare_mongo_query({:skip, skip_value}, query, _)
       when is_integer(skip_value) do
    [%{"$skip" => skip_value} | query]
  end

  defp prepare_mongo_query({:limit, limit_value}, query, _)
       when is_integer(limit_value) do
    [%{"$limit" => limit_value} | query]
  end

  defp prepare_mongo_query(%QueryExpression{match: match_expr}) when is_map(match_expr) do
    %{"$match" => resolve_match_expr(match_expr)}
  end

  defp prepare_mongo_query(%QueryExpression{lookup: lookup_expr}) when is_map(lookup_expr) do
    %{"$lookup" => resolve_lookup_expr(lookup_expr)}
  end

  defp resolve_match_expr(expr) when is_map(expr) do
    Enum.reduce(expr, %{}, fn {k, v}, acc ->
      key =
        case Map.get(@match_expr_mapping, k, k) do
          k when is_atom(k) -> Atom.to_string(k)
          k -> k
        end

      cond do
        is_map(v) ->
          Map.put(acc, key, resolve_match_expr(v))

        is_list(v) ->
          v = Enum.map(v, &resolve_match_expr/1)
          Map.put(acc, key, v)

        true ->
          Map.put(acc, key, v)
      end
    end)
  end

  defp resolve_match_expr(expr), do: expr

  defp resolve_lookup_expr(expr) do
    Enum.reduce(expr, %{}, fn {k, v}, acc ->
      k = Map.get(@lookup_expr_mapping, k, k)
      Map.put(acc, k, v)
    end)
  end
end
