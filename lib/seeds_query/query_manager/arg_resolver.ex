defmodule SeedsQuery.QueryManager.ArgResolver do
  @moduledoc """
  resolvers args
  """

  def resolve_args("accts.seeds-users", :balance) do
    %{from: "balance"}
  end

  def resolve_args("accts.seeds-users", :votes) do
    %{from: "votes", local_field: "account", foreign_field: "account", as: "u"}
  end

  def resolve_args("accts.seeds-users", :invites) do
    %{from: "invites"}
  end

  def resolve_args("accts.seeds-users", :vouches_by) do
    %{from: "accts.seeds-vouches", local_field: "account", foreign_field: "sponsor"}
  end

  def resolve_args("accts.seeds-users", :vouches_for) do
    %{from: "accts.seeds-vouches", local_field: "account", foreign_field: "account"}
  end

  def resolve_args(_coll, _key), do: nil
end
