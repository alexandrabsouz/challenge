defmodule ChallengeWeb.FallbackController do
  use ChallengeWeb, :controller
  alias Challenge.Error
  alias ChallengeWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
