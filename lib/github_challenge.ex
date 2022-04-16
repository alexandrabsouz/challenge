defmodule GithubChallenge do
  alias GithubChallenge.Github.Client

  defdelegate get_github(username), to: Client, as: :get_repo_info
end
