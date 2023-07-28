import Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Bmb.Finch

config :bmb, Bmb.Repo,
  username: System.get_env("PGUSER"),
  password: System.get_env("PGPASSWORD"),
  hostname: System.get_env("PGHOST"),
  database: System.get_env("PGDATABASE"),
  port: System.get_env("PGPORT"),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# CORS
config :cors_plug,
  origin: [
    "https://bmb-next-prod.vercel.app"
  ],
  methods: ["GET", "POST", "FETCH", "OPTIONS"]

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
