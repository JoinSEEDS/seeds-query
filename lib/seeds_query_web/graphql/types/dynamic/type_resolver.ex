defmodule SeedsQueryWeb.Graphql.Types.Dynamic.TypeResolver do
  @moduledoc """
    Generates types
  """

  alias Absinthe.Blueprint.TypeReference

  def resolve("integer"), do: :integer
  def resolve("string"), do: :string
  def resolve("float"), do: :float
  def resolve("id"), do: :id

  def resolve("list:" <> value) do
    %TypeReference.List{of_type: resolve(value)}
  end

  def resolve(value), do: format_field_id(value)

  def resolve_input("integer"), do: :integer_comparison_exp
  def resolve_input("float"), do: :integer_comparison_exp
  def resolve_input("string"), do: :text_comparison_exp
  def resolve_input("id"), do: :id_comparison_exp
  def resolve_input("list:" <> input), do: resolve_input(input)

  def resolve_input(input) when is_binary(input), do: format_field_id(input <> "_bool_exp")
  def resolve_input(input), do: input

  defp format_field_id(name),
    do: name |> String.replace(~r/[^a-zA-Z0-9 ]/, "_") |> String.to_atom()
end
