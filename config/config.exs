# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :github_challenge,
  ecto_repos: [GithubChallenge.Repo]

config :tesla, adapter: Tesla.Adapter.Hackney

# Configures the endpoint
config :github_challenge, GithubChallengeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "60WjZCDLkyMB9q7omjPhxPMR4nC3X7xAKavL3zro5A4E1oRe9vjmVgMNKEJ1ccF0",
  render_errors: [view: GithubChallengeWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GithubChallenge.PubSub,
  live_view: [signing_salt: "8fTet2Nr"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :github_challenge, GithubChallenge.Github.Client, github_client_adapter: GithubChallenge.Github.Client

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"


