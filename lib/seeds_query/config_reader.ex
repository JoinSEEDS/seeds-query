defmodule SeedsQuery.ConfigReader do
  @moduledoc """
  Reads json config files
  """
  alias SeedsQuery.Config

  defp get_json_from_file(path) do
    with {:ok, content} <- File.read(path),
         {:ok, json_content} <- Jason.decode(content) do
      {:ok, json_content}
    end
  end

  defp get_config(key) do
    path =
      Config.get_config()
      |> Map.get(key)

    if is_nil(path) do
      {:error, :expected_config_path}
    else
      get_json_from_file(path)
    end
  end

  @spec get_db_config :: {:error, atom | Jason.DecodeError.t()} | {:ok, any}
  def get_db_config do
    get_config(:db_config_path)
  end
end
