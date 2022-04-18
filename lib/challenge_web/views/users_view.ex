defmodule ChallengeWeb.UsersView do
    use ChallengeWeb, :view

  def render("user.json", %{user: user}) do
    %{
      user: user
    }
  end
end