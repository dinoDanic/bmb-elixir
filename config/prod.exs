import Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Bmb.Finch

# CORS
config :cors_plug,
  origin: [
    "http://localhost:3000",
    "http://localhost:3009",
    "http://localhost:3001",
    "http://167.235.150.40:3000",
    "https://bmb-next-three.vercel.app"
  ],
  methods: ["GET", "POST", "FETCH", "OPTIONS"]

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
