defmodule GithubChallengeWeb.ClientView do
    use GithubChallengeWeb, :view

    def render("show.json", %{repos: repos}) do
        %{
            repos: repos
        }
    end
end