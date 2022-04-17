defmodule SeedsQuery.Config do
  @moduledoc """
    configs for seeds query
  """

  defstruct [:db_config_path]

  @type t() :: %__MODULE__{
          db_config_path: String.t()
        }

  @spec get_config() :: __MODULE__.t()
  def get_config do
    %__MODULE__{
      db_config_path: System.get_env("DB_CONFIG_PATH")
    }
  end
end
