defmodule ChallengeWeb.ReposController do
  use ChallengeWeb, :controller

  alias ChallengeWeb.Auth.Guardian
  alias ChallengeWeb.FallbackController

  action_fallback FallbackController

  def show(conn, params) do
    username = Map.get(params, "username")

    token = Guardian.Plug.current_token(conn)
    token_refresh_async = Task.async(fn -> Guardian.refresh(token, ttl: {1, :minute}) end)

    with {:ok, body} <- Challenge.get_repos(username) do
      {:ok, _old_stuff, {new_token, _new_claims}} = Task.await(token_refresh_async)

      repos = repos_filter(body)

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
