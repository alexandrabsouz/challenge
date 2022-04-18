defmodule Challenge.Github.Behaviour do
  alias Challenge.Error

  @callback get_repo_info(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
