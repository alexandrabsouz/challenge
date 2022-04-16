defmodule GithubChallengeWeb.ClientController do
    use GithubChallengeWeb, :controller

  alias GithubChallenge.Client
  alias GithubChallengeWeb.FallbackController

  action_fallback FallbackController

  def show(conn, params) do
    username = Map.get(params, "username")
    with {:ok, body} <- GithubChallenge.get_github(username) do
      repos = repos_filter(body)
      conn
      |> put_status(:ok)
      |> render("show.json", repos: repos)
    end
  end

  defp repos_filter(body) do
    body
    |> Enum.map(& Map.take(&1, ["id", "name", "description", "html_url", "stargazers_count"]))
  end
end