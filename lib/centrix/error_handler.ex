defmodule Centrix.ErrorHandler do
  @moduledoc false

  @behaviour Guardian.Plug.ErrorHandler

  import Plug.Conn

  @impl Guardian.Plug.ErrorHandler

  def auth_error(conn, {type, reason}, _opts) do
    IO.inspect(type, label: "Guardian error handler")
    IO.inspect(reason, label: "Guardian reason")
    body = Jason.encode!(%{error: type, error_description: reason})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end
end
