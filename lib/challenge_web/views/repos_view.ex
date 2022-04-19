defmodule ChallengeWeb.ReposView do
  use ChallengeWeb, :view

  def render("repos.json", %{repos: repos}) do
    %{
      repos: repos
    }
  end
end
