defmodule GithubChallenge.Github.Behaviour do
  alias GithubChallenge.Error

  @callback get_repo_info(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
