defmodule SeedsQuery.QueryManagerTest do
  @moduledoc """
  Tests for query manager context functions
  """

  use ExUnit.Case
  alias SeedsQuery.QueryManager

  describe "run aggregrate with match" do
    test "returns list of docs" do
      assert [user1, user2, user3, user4, user5] = QueryManager.resolve(%{}, "accts.seeds-users")

      all_users = [
        "accts.seeds-acascalheira",
        "accts.seeds-alejandroga1",
        "accts.seeds-aleksandar11",
        "accts.seeds-alextest1234",
        "accts.seeds-cometogetdev"
      ]

      assert user1["_id"] in all_users
      assert user2["_id"] in all_users
      assert user3["_id"] in all_users
      assert user4["_id"] in all_users
      assert user5["_id"] in all_users
    end

    test "returns list of docs satisfying `eq` condition" do
      args = %{where: %{account: %{_eq: "acascalheira"}}}
      assert [user] = QueryManager.resolve(args, "accts.seeds-users")

      assert user["_id"] == "accts.seeds-acascalheira"
      assert user["account"] == "acascalheira"
    end

    test "returns list of docs satisfying `ne` condition" do
      args = %{where: %{account: %{_ne: "acascalheira"}}}
      assert [user1, user2, user3, user4] = QueryManager.resolve(args, "accts.seeds-users")

      users = [
        "accts.seeds-alejandroga1",
        "accts.seeds-aleksandar11",
        "accts.seeds-alextest1234",
        "accts.seeds-cometogetdev"
      ]

      assert user1["_id"] in users
      assert user2["_id"] in users
      assert user3["_id"] in users
      assert user4["_id"] in users
    end

    test "returns list of docs satisfying `in` condition" do
      args = %{where: %{account: %{_in: ["acascalheira", "alejandroga1"]}}}
      assert [user1, user2] = QueryManager.resolve(args, "accts.seeds-users")

      assert user1["_id"] in [
               "accts.seeds-alejandroga1",
               "accts.seeds-acascalheira"
             ]

      assert user2["_id"] in [
               "accts.seeds-alejandroga1",
               "accts.seeds-acascalheira"
             ]
    end

    test "returns list of docs satisfying `nin` condition" do
      args = %{where: %{account: %{_nin: ["acascalheira", "alejandroga1"]}}}
      assert [user1, user2, user3] = QueryManager.resolve(args, "accts.seeds-users")

      users = [
        "accts.seeds-aleksandar11",
        "accts.seeds-alextest1234",
        "accts.seeds-cometogetdev"
      ]

      assert user1["_id"] in users
      assert user2["_id"] in users
      assert user3["_id"] in users
    end

    test "returns list of docs satisfying `gt` and `lt` condition" do
      args = %{where: %{reputation: %{_gt: 100, _lt: 200}}}
      assert [user] = QueryManager.resolve(args, "accts.seeds-users")

      assert user["_id"] == "accts.seeds-aleksandar11"
      assert user["reputation"] == 145
    end

    test "returns list of docs satisfying `gte` and `lte` condition" do
      args = %{where: %{reputation: %{_gte: 100, _lte: 200}}}
      assert [user1, user2] = QueryManager.resolve(args, "accts.seeds-users")

      assert user1["_id"] in [
               "accts.seeds-aleksandar11",
               "accts.seeds-acascalheira"
             ]

      assert user2["_id"] in [
               "accts.seeds-aleksandar11",
               "accts.seeds-acascalheira"
             ]
    end

    test "returns list of docs satisfying `and` condition" do
      args = %{where: %{_and: [%{reputation: %{_gte: 100}}, %{status: %{_eq: "citizen"}}]}}
      assert [user1, user2] = QueryManager.resolve(args, "accts.seeds-users")

      assert user1["_id"] in [
               "accts.seeds-cometogetdev",
               "accts.seeds-acascalheira"
             ]

      assert user2["_id"] in [
               "accts.seeds-cometogetdev",
               "accts.seeds-acascalheira"
             ]
    end

    test "returns list of docs satisfying `or` condition" do
      args = %{where: %{_or: [%{type: %{_eq: "organisation"}}, %{status: %{_eq: "citizen"}}]}}
      assert [user1, user2, user3] = QueryManager.resolve(args, "accts.seeds-users")

      users = [
        "accts.seeds-cometogetdev",
        "accts.seeds-acascalheira",
        "accts.seeds-alextest1234"
      ]

      assert user1["_id"] in users
      assert user2["_id"] in users
      assert user3["_id"] in users
    end

    test "returns list of docs satisfying `not` condition" do
      args = %{where: %{type: %{_not: %{_eq: "individual"}}}}
      assert [user] = QueryManager.resolve(args, "accts.seeds-users")

      assert user["_id"] == "accts.seeds-alextest1234"
    end

    test "returns list of docs satisying nested logical operations" do
      args = %{
        where: %{
          _and: [
            %{_or: [%{type: %{_eq: "organisation"}}, %{status: %{_eq: "citizen"}}]},
            %{reputation: %{_gt: 100}}
          ]
        }
      }

      assert [user1, user2] = QueryManager.resolve(args, "accts.seeds-users")

      users = [
        "accts.seeds-cometogetdev",
        "accts.seeds-alextest1234"
      ]

      assert user1["_id"] in users
      assert user2["_id"] in users
    end
  end

  describe "run aggregate with match and lookup" do
    test "returns list of docs satisfying lookup condition[simple]" do
      args = %{where: %{vouches_for: %{vouch_points: %{_gt: 100}}}}
      users = ["accts.seeds-cometogetdev", "accts.seeds-alejandroga1"]
      assert [user1, user2] = QueryManager.resolve(args, "accts.seeds-users")
      assert user1["_id"] in users
      assert user2["_id"] in users
    end

    test "returns list of docs satisfying lookup condition[logical]" do
      args = %{
        where: %{
          _and: [
            %{vouches_for: %{vouch_points: %{_gte: 50}}},
            %{vouches_by: %{vouch_points: %{_lte: 200}}}
          ]
        }
      }

      assert [user] = QueryManager.resolve(args, "accts.seeds-users")
      assert user["_id"] == "accts.seeds-alejandroga1"
    end
  end
end
