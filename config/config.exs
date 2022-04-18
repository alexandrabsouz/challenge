# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :challenge,
  ecto_repos: [Challenge.Repo]

config :tesla, adapter: Tesla.Adapter.Hackney

# Configures the endpoint
config :challenge, ChallengeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "60WjZCDLkyMB9q7omjPhxPMR4nC3X7xAKavL3zro5A4E1oRe9vjmVgMNKEJ1ccF0",
  render_errors: [view: ChallengeWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Challenge.PubSub,
  live_view: [signing_salt: "8fTet2Nr"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :challenge, Challenge.Github.Client, github_client_adapter: Challenge.Github.Client

config :challenge, Challenge.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :challenge, ChallengeWeb.Auth.Pipeline,
  module: ChallengeWeb.Auth.Guardian,
  error_handler: ChallengeWeb.Auth.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
