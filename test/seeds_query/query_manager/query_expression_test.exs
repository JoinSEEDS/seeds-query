defmodule SeedsQuery.QueryManager.QueryExpressionTest do
  @moduledoc """
  Tests for query expression
  """
  use ExUnit.Case
  alias SeedsQuery.QueryManager.QueryExpression
  alias SeedsQuery.QueryManager.RawExpression

  describe "Resolve" do
    test "returns list of QueryExpressions for list of raw expressions with normal fiels" do
      raw_expr_list = [
        %RawExpression{lookup_info: [], match_value: %{"field1" => %{"eq" => "value1"}}},
        %RawExpression{lookup_info: [], match_value: %{"field2" => %{"lt" => 10, "gte" => 2}}}
      ]

      assert [%QueryExpression{match: match}] = QueryExpression.resolve(raw_expr_list)
      assert match == %{"field1" => %{"eq" => "value1"}, "field2" => %{"lt" => 10, "gte" => 2}}
    end

    test "returns list of QueryExpressions in order for raw expressions with normal and lookup fields" do
      raw_expr_list = [
        %RawExpression{lookup_info: [], match_value: %{"field1" => %{"eq" => "value1"}}},
        %RawExpression{
          lookup_info: [%{"from" => "coll1"}],
          match_value: %{"coll1.field2" => %{"eq" => 5}}
        }
      ]

      assert [
               %QueryExpression{match: normal_match_expr},
               %QueryExpression{lookup: lookup_expr},
               %QueryExpression{match: lookup_match_expr}
             ] = QueryExpression.resolve(raw_expr_list)

      assert normal_match_expr == %{"field1" => %{"eq" => "value1"}}
      assert lookup_expr == %{"from" => "coll1"}
      assert lookup_match_expr == %{"coll1.field2" => %{"eq" => 5}}
    end

    test "returns list of QueryExpressions for list of raw expressions with lookups and logical operations" do
      raw_expr_list = [
        %RawExpression{
          lookup_info: [
            %{
              "as" => "coll2",
              "foreignField" => "key_field",
              "from" => "lookup_coll2",
              "localField" => "key_field"
            },
            %{
              "as" => "coll1",
              "foreignField" => "key_field",
              "from" => "lookup_coll1",
              "localField" => "key_field"
            }
          ],
          match_value: %{
            "_and" => [
              %{"coll2.field" => %{"in" => [1, 2, 3]}},
              %{"coll1.field2" => %{"eq" => "value2"}}
            ]
          }
        },
        %RawExpression{
          lookup_info: [
            %{
              "as" => "coll1",
              "foreignField" => "key_field",
              "from" => "lookup_coll1",
              "localField" => "key_field"
            }
          ],
          match_value: %{"coll1.field1" => %{"eq" => "value1"}}
        },
        %RawExpression{
          lookup_info: [
            %{
              "as" => "coll2",
              "foreignField" => "key_field",
              "from" => "lookup_coll2",
              "localField" => "key_field"
            }
          ],
          match_value: %{"coll2.field" => %{"eq" => "value1"}}
        },
        %RawExpression{
          lookup_info: [],
          match_value: %{"normal_field1" => %{"gt" => 1, "lt" => 5}}
        }
      ]

      assert [
               %QueryExpression{match: normal_match_expr},
               %QueryExpression{lookup: lookup_coll1_expr},
               %QueryExpression{match: lookup_coll1_match_expr},
               %QueryExpression{lookup: lookup_coll2_expr},
               %QueryExpression{match: lookup_coll1_coll2_match_expr}
             ] = QueryExpression.resolve(raw_expr_list)

      assert normal_match_expr == %{"normal_field1" => %{"gt" => 1, "lt" => 5}}

      assert lookup_coll1_expr == %{
               "as" => "coll1",
               "foreignField" => "key_field",
               "from" => "lookup_coll1",
               "localField" => "key_field"
             }

      assert lookup_coll1_match_expr == %{"coll1.field1" => %{"eq" => "value1"}}

      assert lookup_coll2_expr == %{
               "as" => "coll2",
               "foreignField" => "key_field",
               "from" => "lookup_coll2",
               "localField" => "key_field"
             }

      assert lookup_coll1_coll2_match_expr == %{
               "_and" => [
                 %{"coll2.field" => %{"in" => [1, 2, 3]}},
                 %{"coll1.field2" => %{"eq" => "value2"}}
               ],
               "coll2.field" => %{"eq" => "value1"}
             }
    end
  end
end
