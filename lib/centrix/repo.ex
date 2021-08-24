defmodule Centrix.Repo do
  use Ecto.Repo,
    otp_app: :centrix,
    adapter: Ecto.Adapters.Postgres
end
