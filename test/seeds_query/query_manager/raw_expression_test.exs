defmodule SeedsQuery.QueryManager.RawExpressionTest do
  @moduledoc """
  Tests for raw expressions
  """

  # use ExUnit.Case
  # import Mock
  # alias SeedsQuery.QueryManager.ArgResolver
  # alias SeedsQuery.QueryManager.RawExpression

  # describe "Resolve" do
  #   test "returns list of raw expressions" do
  #     with_mock(ArgResolver, resolve_args: fn _, _ -> nil end) do
  #       args = %{"field1" => %{"_eq" => "value1"}, "field2" => %{"_lt" => 5}}

  #       assert [%RawExpression{} = expr1, %RawExpression{} = expr2] =
  #                RawExpression.resolve(args, :some_coll)

  #       assert expr1.lookup_info == []
  #       assert expr1.match_value == %{"field1" => %{"_eq" => "value1"}}
  #       assert expr2.lookup_info == []
  #       assert expr2.match_value == %{"field2" => %{"_lt" => 5}}
  #     end
  #   end

  #   test "returns raw expressions for logical operations" do
  #     with_mock(ArgResolver, resolve_args: fn _, _ -> nil end) do
  #       args = %{
  #         "_not" => %{
  #           "_or" => [%{"field1" => %{"_eq" => "value1"}}, %{"field2" => %{"_lt" => 5}}]
  #         }
  #       }

  #       assert [%RawExpression{} = expr] = RawExpression.resolve(args, :some_coll)
  #       assert expr.lookup_info == []

  #       assert expr.match_value == %{
  #                "_not" => %{
  #                  "_or" => [%{"field2" => %{"_lt" => 5}}, %{"field1" => %{"_eq" => "value1"}}]
  #                }
  #              }
  #     end
  #   end

  #   test "returns raw expressions with lookups" do
  #     with_mock(ArgResolver,
  #       resolve_args: fn _, key ->
  #         case key do
  #           "lookup1" ->
  #             %{
  #               from: "lookup_coll1",
  #               local_field: "key_field",
  #               foreign_field: "key_field",
  #               as: "coll1"
  #             }

  #           "lookup2" ->
  #             %{
  #               from: "lookup_coll2",
  #               local_field: "key_field",
  #               foreign_field: "key_field",
  #               as: "coll2"
  #             }

  #           _ ->
  #             nil
  #         end
  #       end
  #     ) do
  #       args = %{
  #         "lookup1" => %{"field1" => %{"_eq" => "value1"}},
  #         "normal_field1" => %{"_lt" => 5, "_gt" => 1},
  #         "_and" => [
  #           %{
  #             "lookup1" => %{"field2" => %{"_eq" => "value2"}}
  #           },
  #           %{"lookup2" => %{"field" => %{"_in" => [1, 2, 3]}}}
  #         ]
  #       }

  #       assert [%RawExpression{} = expr1, %RawExpression{} = expr2, %RawExpression{} = expr3] =
  #                RawExpression.resolve(args, :some_coll)

  #       assert expr1_lookup1 = Enum.find(expr1.lookup_info, &(&1.from == "lookup_coll1"))

  #       assert %{
  #                from: from,
  #                local_field: local_field,
  #                foreign_field: foreign_field
  #              } = expr1_lookup1

  #       assert from == "lookup_coll1"
  #       assert local_field == "key_field"
  #       assert foreign_field == "key_field"
  #       assert expr1_lookup2 = Enum.find(expr1.lookup_info, &(&1.from == "lookup_coll2"))

  #       assert %{
  #                from: from,
  #                local_field: local_field,
  #                foreign_field: foreign_field
  #              } = expr1_lookup2

  #       assert from == "lookup_coll2"
  #       assert local_field == "key_field"
  #       assert foreign_field == "key_field"
  #       assert %{"lookup1.field2" => %{"_eq" => "value2"}} in expr1.match_value["_and"]
  #       assert %{"lookup2.field" => %{"_in" => [3, 2, 1]}} in expr1.match_value["_and"]

  #       assert [expr2_lookup] = expr2.lookup_info

  #       assert %{
  #                from: from,
  #                local_field: local_field,
  #                foreign_field: foreign_field
  #              } = expr2_lookup

  #       assert from == "lookup_coll1"
  #       assert local_field == "key_field"
  #       assert foreign_field == "key_field"
  #       assert expr2.match_value == %{"lookup1.field1" => %{"_eq" => "value1"}}

  #       assert expr3.lookup_info == []
  #       assert expr3.match_value == %{"normal_field1" => %{"_lt" => 5, "_gt" => 1}}
  #     end
  #   end
  # end
end
