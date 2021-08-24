defmodule CentrixWeb.Api.V1.SessionController do
  use CentrixWeb, :controller

  alias Centrix.Accounts
  alias Centrix.Guardian
  alias Argon2

  action_fallback CentrixWeb.FallbackController

  def create(conn, params) do
    with hash <- Argon2.hash_pwd_salt(params["password"]),
         attrs <- Map.put(params, "encrypted_password", hash),
         {:ok, user} <- Accounts.create_user(attrs),
         _ <- IO.inspect(user),
         token <- Guardian.encode_and_sign(user) do
      render(conn, "token.json", user: user, token: token)
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- Accounts.authenticate(email, password),
         token <- Guardian.encode_and_sign(user) do
      render(conn, "token.json", user: user, token: token)
    end
  end
end
