defmodule SeedsQueryWeb.UserQueryTest do
  @moduledoc """
  Graphql query test for user related queries
  """
  use SeedsQueryWeb.ConnCase

  # describe "list users" do
  #   @query """
  #   query($where: UserBoolExp, $skip: Int, $limit: Int) {
  #     list_users(where: $where, skip: $skip, limit: $limit) {
  #       _id
  #       account
  #     }
  #   }
  #   """
  #   test "returns list of users", %{conn: conn} do
  #     conn = post conn, "/api", query: @query
  #     assert %{"data" => %{"list_users" => [user1, user2, user3]}} = json_response(conn, 200)

  #     assert user1["_id"] in [
  #              "accts.seeds-biztogether",
  #              "accts.seeds-ramsolti",
  #              "accts.seeds-kailash"
  #            ]

  #     assert user2["_id"] in [
  #              "accts.seeds-biztogether",
  #              "accts.seeds-ramsolti",
  #              "accts.seeds-kailash"
  #            ]

  #     assert user3["_id"] in [
  #              "accts.seeds-biztogether",
  #              "accts.seeds-ramsolti",
  #              "accts.seeds-kailash"
  #            ]
  #   end

  #   test "returns list of users satisfying eq condition", %{conn: conn} do
  #     args = %{where: %{account: %{eq: "biztogether"}}}
  #     conn = post conn, "/api", query: @query, variables: args
  #     assert %{"data" => %{"list_users" => [user1]}} = json_response(conn, 200)

  #     assert user1["_id"] == "accts.seeds-biztogether"
  #     assert user1["account"] == "biztogether"
  #   end

  #   test "returns list of users satisfying in condition", %{conn: conn} do
  #     args = %{where: %{account: %{in: ["biztogether", "kailash"]}}}
  #     conn = post conn, "/api", query: @query, variables: args
  #     assert %{"data" => %{"list_users" => [user1, user2]}} = json_response(conn, 200)

  #     assert user1["_id"] in [
  #              "accts.seeds-biztogether",
  #              "accts.seeds-kailash"
  #            ]

  #     assert user2["_id"] in [
  #              "accts.seeds-biztogether",
  #              "accts.seeds-kailash"
  #            ]
  #   end

  #   test "returns list of users satisfying gt and lt condition", %{conn: conn} do
  #     args = %{where: %{reputation: %{gt: 100, lt: 200}}}
  #     conn = post conn, "/api", query: @query, variables: args
  #     assert %{"data" => %{"list_users" => [user]}} = json_response(conn, 200)

  #     assert user["_id"] == "accts.seeds-kailash"
  #   end

  #   test "returns list of users satisfying lookup condition", %{conn: conn} do
  #     args = %{where: %{reputation: %{gt: 100, lt: 200}, votes: %{eq: 10}}}
  #     conn = post conn, "/api", query: @query, variables: args
  #     assert %{"data" => %{"list_users" => [user]}} = json_response(conn, 200)

  #     assert user["_id"] == "accts.seeds-kailash"
  #   end
  # end
end
