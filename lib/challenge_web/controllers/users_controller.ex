defmodule ChallengeWeb.UsersController do
    use ChallengeWeb, :controller

    alias Challenge.User
    alias ChallengeWeb.FallbackController


    action_fallback FallbackController

    def show(conn, %{"id" => id}) do
        with {:ok, %User{} = user} <- Challenge.get_user_by_id(id) do
          conn
          |> put_status(:ok)
          |> render("user.json", user: user)
        end
    end

    def create(conn, params) do
      with {:ok, %User{} = user} <- Challenge.create_user(params) do
        conn
        |> put_status(:created)
        |> render("create.json", user: user)
      end
    end

    def delete(conn, %{"id" => id}) do
      with {:ok, %User{}} <- Challenge.delete_user(id) do
        conn
        |> put_status(:no_content)
        |> text("")
      end
    end
end
