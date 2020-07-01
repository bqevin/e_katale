# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :e_katale,
  ecto_repos: [EKatale.Repo]

# Configures the endpoint
config :e_katale, EKataleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "O8YIYXVdxlAnLta5/qwWaujowfTugYGtb/WnfirLpUBSJ1B0zJkJb/8hBl9108UN",
  render_errors: [view: EKataleWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: EKatale.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configure your database
config :e_katale, EKatale.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("PG_USERNAME"),
  password: System.get_env("PG_PASSWORD"),
  database: System.get_env("PG_DATABASE"),
  hostname: System.get_env("PG_HOST"),
  pool_size: 10

# Configure guardian
config :e_katale, EKataleWeb.Auth.Guardian, 
  issuer: "e_katale",
  secret_key: "IMEiOus1vwi9VOmiZ1da+FFojpISjgAyKSoRXCctnXA5BGp10GJWjfJRdNWjo/CX",
  ttl: {System.get_env("TOKEN_TTL", String.to_atom(System.get_env("TOKEN_TTL_UNIT")))}

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
