defmodule ChallengeWeb.UsersView do
    use ChallengeWeb, :view

    alias Challenge.User

    def render("create.json", %{user: %User{} = user, token: token}) do
      %{
        message: "user created!",
        user: user,
        token: token
      }
    end

    def render("sign_in.json", %{token: token}) do
      %{
        token: token
      }
    end

    def render("user.json", %{user: %User{} = user, token: token}), do: %{user: user,  token: token}
end