defmodule ChallengeWeb.ReposView do
  use ChallengeWeb, :view

  def render("repos.json", %{new_token: new_token, repos: repos}) do
    %{
      repos: repos,
      new_token: new_token
    }
  end
end
