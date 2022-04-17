defmodule SeedsQueryWeb.Schema.CommonTypes do
  @moduledoc """
  Common Types for graphql Schema
  """
  use Absinthe.Schema.Notation

  input_object :id_comparison_exp do
    field(:_not, :id_comparison_exp)
    field(:_eq, :string)
    field(:_ne, :string)
    field(:_in, list_of(:string))
    field(:_nin, list_of(:string))
  end

  input_object :text_comparison_exp do
    field(:_not, :text_comparison_exp)
    field(:_eq, :string)
    field(:_ne, :string)
    field(:_gt, :string)
    field(:_gte, :string)
    field(:_lt, :string)
    field(:_lte, :string)
    field(:_in, list_of(:string))
    field(:_nin, list_of(:string))
  end

  input_object :integer_comparison_exp do
    field(:_not, :integer_comparison_exp)
    field(:_eq, :integer)
    field(:_ne, :integer)
    field(:_gt, :integer)
    field(:_gte, :integer)
    field(:_lt, :integer)
    field(:_lte, :integer)
    field(:_in, list_of(:integer))
    field(:_nin, list_of(:integer))
  end
end
