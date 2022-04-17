defmodule SeedsQuery.QueryManager.QueryExpression do
  @moduledoc """
  converting raw expression into match and lookup
  """
  alias SeedsQuery.QueryManager.QueryExpression
  alias SeedsQuery.QueryManager.RawExpression

  defstruct [:match, :lookup]

  @type t() :: %QueryExpression{match: map(), lookup: map()}

  @doc """
  Receives list of raw expressions

  Creates query expression with sorted lookup and match expressions

  Returns list of query expressions

  ## Examples
    iex> resolve([%RawExpression{lookup_info: [], match_value: %{name: %{_eq: "some_user"}}}])
    [%QueryExpression{match: %{name: %{_eq: "some_user"}, lookup: nil}]

    iex> resolve([%RawExpression{
      lookup_info: [%{
        from: "user_profile",
        local_field: "id",
        foreign_field: "user_id",
        as: "profile"
      }],
      match_value: %{"profile.address" => %{_eq: "melbourne"}}
    }])
    [%QueryExpression{
      lookup: %{
        from: "user_profile",
        local_field: "id",
        foreign_field: "user_id",
        as: "profile"
      },
      match: %{"profile.address" => %{_eq: "melbourne"}}
    }]

    iex> resolve([%RawExpression{
      lookup_info: [%{
        from: "user_profile",
        local_field: "id",
        foreign_field: "user_id",
        as: "profile"
      }],
      match_value: %{_and: [%{name: %{_eq: "some_user"}}, %{"profile.address" => %{_eq: "melbourne"}}]}
    }])
    [%QueryExpression{
      lookup: %{
        from: "user_profile",
        local_field: "id",
        foreign_field: "user_id",
        as: "profile"
      },
      match: %{_and: [%{name: %{_eq: "some_user"}}, %{"profile.address" => %{_eq: "melbourne"}}]}
    }]

    iex> resolve([
        %RawExpression{lookup_info: [], match_value: %{name: %{_eq: "some_user"}}},
        %RawExpression{
          lookup_info: [%{
            from: "user_profile",
            local_field: "id",
            foreign_field: "user_id",
            as: "profile"
          }],
          match_value: %{"profile.address" => %{_eq: "melbourne"}}
        }
      ])

      [
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
      ]

  """
  @spec resolve([RawExpression.t()]) :: [QueryExpression.t()]
  def resolve(raw_expr_list) do
    raw_expr_list
    |> Enum.sort_by(&length(&1.lookup_info))
    |> Enum.reduce([], &prepare_query_expression_list/2)
  end

  defp prepare_query_expression_list(
         %RawExpression{lookup_info: lookup_info, match_value: match_value},
         query_expr_list
       ) do
    {0, query_expr_list}
    |> insert_lookup_info(lookup_info)
    |> upsert_match(match_value)
  end

  defp insert_lookup_info(
         {match_insert_position, query_expr_list},
         [lookup_params | rem_lookup_info]
       ) do
    {new_match_insert_position, query_expr_list} = insert_lookup(query_expr_list, lookup_params)

    match_insert_position =
      if new_match_insert_position > match_insert_position do
        new_match_insert_position
      else
        match_insert_position
      end

    insert_lookup_info({match_insert_position, query_expr_list}, rem_lookup_info)
  end

  defp insert_lookup_info(match_insert_data, []), do: match_insert_data

  defp upsert_match(match_insert_data, match_value) do
    case get_match(match_insert_data) do
      %QueryExpression{match: match} ->
        %QueryExpression{match: Map.merge(match, match_value)}
        |> update_match(match_insert_data)

      nil ->
        %QueryExpression{match: match_value}
        |> insert_match(match_insert_data)
    end
  end

  defp insert_match(%QueryExpression{} = query_expr, {position, query_expr_list}) do
    List.insert_at(query_expr_list, position, query_expr)
  end

  defp update_match(%QueryExpression{} = query_expr, {position, query_expr_list}) do
    List.replace_at(query_expr_list, position, query_expr)
  end

  defp insert_lookup(query_expr_list, lookup_params) do
    lookup_index = get_lookup_index(query_expr_list, lookup_params)

    if is_nil(lookup_index) do
      query_expr_list =
        List.insert_at(query_expr_list, -1, %QueryExpression{lookup: lookup_params})

      {length(query_expr_list), query_expr_list}
    else
      {lookup_index + 1, query_expr_list}
    end
  end

  defp get_lookup_index(query_expr_list, lookup_params) do
    Enum.find_index(query_expr_list, fn query_expr ->
      query_expr.lookup && Map.equal?(query_expr.lookup, lookup_params)
    end)
  end

  defp get_match({position, query_expression_list}) do
    case Enum.at(query_expression_list, position, nil) do
      %QueryExpression{match: match} = query_expr when is_map(match) -> query_expr
      _ -> nil
    end
  end
end
