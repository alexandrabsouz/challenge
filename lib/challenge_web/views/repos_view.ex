defmodule ChallengeWeb.ReposView do
  use ChallengeWeb, :view

  def render("repos.json", %{repos: repos, token: token}) do
    %{
      repos: repos,
      token: token
    }
  end
end
