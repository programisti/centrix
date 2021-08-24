# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :centrix,
  ecto_repos: [Centrix.Repo]

# Configures the endpoint
config :centrix, CentrixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: CentrixWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Centrix.PubSub,
  live_view: [signing_salt: "0hCyxeuR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :centrix, Centrix.Guardian,
  issuer: "centrix",
  verify_issuer: true,
  secret_key: "oxCxbtL4KOxoJGvK2AA9nsGirv0YDZSmfsE9vHM1p2JwUm/KP2jhtS8NXuogw8QX"


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
