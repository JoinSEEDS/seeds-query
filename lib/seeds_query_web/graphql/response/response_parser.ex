defmodule SeedsQueryWeb.Graphql.Response.ResponseParser do
  @moduledoc """
    Parse response based on type
  """

  @doc """
   parse response to supplied type
  """
  def parse_response(nil, _), do: nil
  def parse_response(value, :integer) when is_integer(value), do: value

  def parse_response(value, :integer) when is_binary(value) and value != "" do
    case Integer.parse(value) do
      {v, _} -> v
      _ -> nil
    end
  end

  def parse_response(value, :integer) when is_float(value), do: trunc(value)

  def parse_response(value, :string), do: "#{value}"

  def parse_response(value, :float) when is_float(value), do: value
  def parse_response(value, :float) when is_integer(value), do: value / 1

  def parse_response(value, :float) when is_binary(value) do
    case Float.parse(value) do
      {v, _} -> v
      _ -> nil
    end
  end

  def parse_response(id, :id), do: id

  def parse_response(value, %Absinthe.Type.List{of_type: type})
      when is_binary(value) do
    case Jason.decode(value) do
      {:ok, resp} when is_list(resp) ->
        resp

      {:ok, _} ->
        nil

      _ ->
        value
        |> String.replace("\\", "")
        |> String.replace_leading("[", "")
        |> String.replace_trailing("]", "")
        |> String.split(",")
        |> Enum.map(&parse_response(&1, type))
    end
  end

  def parse_response(_, _), do: nil
end
