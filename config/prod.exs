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
  stacktrace: false,
  show_sensitive_data_on_connection_error: false,
  pool_size: 10

config :bmb, BmbWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {0, 0, 0, 0}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "uvwuQObU9x/xGbok+rb2N2tqLpeCGqckq0SYH1vcFJNiM3gymmSYYX2GDCqCjPSG",
  watchers: []

# CORS
config :cors_plug,
  origin: [
    "https://bmb-prod.vercel.app",
    "https://bmb-dev.vercel.app"
  ],
  methods: ["GET", "POST", "FETCH", "OPTIONS"]

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
