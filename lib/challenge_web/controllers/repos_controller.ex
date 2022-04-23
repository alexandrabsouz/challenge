defmodule ChallengeWeb.ReposController do
  use ChallengeWeb, :controller

  alias ChallengeWeb.Auth.Guardian
  alias ChallengeWeb.FallbackController

  action_fallback FallbackController

  def show(conn, params) do
    username = Map.get(params, "username")

    token = Guardian.Plug.current_token(conn)

    with {:ok, body} <- Challenge.get_repos(username) do

      repos = repos_filter(body)

      new_token = conn.private[:refresh_token]

      conn
      |> put_status(:ok)
      |> render("repos.json", repos: repos, token: new_token)
    end
  end

  defp repos_filter(body) do
    body
    |> Enum.map(&Map.take(&1, ["id", "name", "description", "html_url", "stargazers_count"]))
  end
end
