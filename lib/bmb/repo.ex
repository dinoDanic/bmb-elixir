defmodule Bmb.Repo do
  use Ecto.Repo,
    otp_app: :bmb,
    adapter: Ecto.Adapters.Postgres
end
