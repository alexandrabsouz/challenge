defmodule ChallengeWeb.ClientView do
  use ChallengeWeb, :view

  def render("show.json", %{repos: repos}) do
    %{
      repos: repos
    }
  end
end
