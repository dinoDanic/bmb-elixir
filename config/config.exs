# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :bmb,
  ecto_repos: [Bmb.Repo]

# CORS
config :cors_plug,
  origin: [
    "http://localhost:3000",
    "http://localhost:3009",
    "http://localhost:3001",
    "http://167.235.150.40:3000",
    "https://bmb-next-three.vercel.app",
    "bmb-next-three.vercel.app"
  ],
  methods: ["GET", "POST", "FETCH", "OPTIONS"]

# Configures the endpoint
config :bmb, BmbWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: BmbWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Bmb.PubSub,
  live_view: [signing_salt: "rV02jqLR"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :bmb, Bmb.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
