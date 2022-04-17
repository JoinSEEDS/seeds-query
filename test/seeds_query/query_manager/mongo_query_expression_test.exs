# defmodule SeedsQuery.QueryManager.MongoQueryGeneratorTest do
#   @moduledoc """
#   Tests related to mongo query generator
#   """

#   use ExUnit.Case
#   import Mock
#   alias SeedsQuery.QueryManager.ArgResolver
#   alias SeedsQuery.QueryManager.MongoQueryGenerator

#   describe "Get Mongo Query" do
#     test "returns list of mongo query for args" do
#       args = %{where: %{field1: %{_eq: "value1"}, field2: %{_lt: 5}}, skip: 5, limit: 1}

#       assert [match_query, skip_query, limit_query] =
#                MongoQueryGenerator.get_mongo_query(args, :some_coll)

#       assert match_query == %{
#                "$match" => %{"field1" => %{"$eq" => "value1"}, "field2" => %{"$lt" => 5}}
#              }

#       assert limit_query == %{"$limit" => 1}
#       assert skip_query == %{"$skip" => 5}
#     end

#     test "returns list of mongo query for args with logical operations" do
#       args = %{
#         where: %{
#           field1: %{_eq: "value1"},
#           _or: [%{field2: %{_eq: "some_value"}}, %{field3: %{_eq: "other_value"}}]
#         }
#       }

#       assert [match_query] = MongoQueryGenerator.get_mongo_query(args, :some_coll)
#       assert field1_query = match_query["$match"]["field1"]
#       assert field1_query == %{"$eq" => "value1"}
#       assert [or_query_1, or_query_2] = match_query["$match"]["$or"]
#       assert or_query_1 == %{"field3" => %{"$eq" => "other_value"}}
#       assert or_query_2 == %{"field2" => %{"$eq" => "some_value"}}
#     end

#     test "returns list of mongo query with lookup" do
#       with_mock(ArgResolver,
#         resolve_args: fn _, key ->
#           case key do
#             :lookup ->
#               %{
#                 from: "other_collection",
#                 local_field: "foreign_key_field",
#                 foreign_field: "key_field"
#               }

#             _ ->
#               %{}
#           end
#         end
#       ) do
#         args = %{
#           where: %{
#             lookup: %{field2: %{_eq: "value2"}},
#             field1: %{_eq: "value1"}
#           }
#         }

#         assert [match_query_1, lookup_query, match_query_2] =
#                  MongoQueryGenerator.get_mongo_query(args, "some_coll")

#         assert match_query_1 == %{"$match" => %{"field1" => %{"$eq" => "value1"}}}

#         assert lookup_query == %{
#                  "$lookup" => %{
#                    "as" => "lookup",
#                    "foreignField" => "key_field",
#                    "from" => "other_collection",
#                    "localField" => "foreign_key_field"
#                  }
#                }

#         assert match_query_2 == %{"$match" => %{"lookup.field2" => %{"$eq" => "value2"}}}
#       end
#     end
#   end
# end
