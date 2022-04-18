defmodule ChallengeWeb.UsersController do
    use ChallengeWeb, :controller

    alias Challenge.User
    #alias ChallengeWeb.Auth.Guardian
    alias ChallengeWeb.FallbackController


    def show(conn, %{"id" => id}) do
        with {:ok, user} <- Challenge.get_user_by_id(id) do
          conn
          |> put_status(:ok)
          |> render("user.json", user: user)
        end
      end
end
