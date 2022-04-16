defmodule GithubChallenge.Repo do
  use Ecto.Repo,
    otp_app: :github_challenge,
    adapter: Ecto.Adapters.Postgres
end
