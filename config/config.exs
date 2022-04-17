# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :seeds_query, SeedsQueryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oTyD0HAbb1DA14RvBNpOBlrTnx3HslOGdu6hQ1IhDympAUKH/W9vwoiveUDKmLqN",
  render_errors: [view: SeedsQueryWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SeedsQuery.PubSub,
  live_view: [signing_salt: "Xd4or9dm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Mongo Database configuration
config :seeds_query, :mongo_blockchain_db, url: {:system, "MONGO_BLOCKCHAIN_URL"}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"