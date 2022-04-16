defmodule GithubChallengeWeb.FallbackController do
    use GithubChallengeWeb, :controller
    alias GithubChallenge.Error
    alias GithubChallengeWeb.ErrorView
  
    def call(conn, {:error, %Error{status: status, result: result}}) do
      conn
      |> put_status(status)
      |> put_view(ErrorView)
      |> render("error.json", result: result)
    end
  end