use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :challenge, Challenge.Repo,
  username: "postgres",
  password: "LQS--log",
  database: "challenge_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :challenge, ChallengeWeb.Endpoint,
  http: [port: 4002],
  server: false

config :challenge, Challenge.Github.Client, github_client_adapter: Challenge.Github.ClientMock

# Print only warnings and errors during test
config :logger, level: :warn
