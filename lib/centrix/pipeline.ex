defmodule Centrix.Pipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline,
    otp_app: :centrix,
    error_handler: Centrix.ErrorHandler,
    module: Centrix.Guardian

  # If there is a session token, restrict it to an access token and validate it
  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  # If there is an authorization header, restrict it to an access token and validate it
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})
  plug Guardian.Plug.LoadResource, allow_blank: true
end
