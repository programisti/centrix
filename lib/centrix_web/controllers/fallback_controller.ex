defmodule CentrixWeb.FallbackController do
  use CentrixWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{errors: errors}}) do
    pretty_errors =
      Enum.map(errors, fn {field, {msg, _}} ->
        %{
          field: field,
          message: msg
        }
      end)

    json(conn, %{status: :error, errors: pretty_errors})
  end

  def call(conn, {:error, msg}) when is_binary(msg) do
    name = action_name(conn)
    json(conn, %{status: :error, errors: [%{field: name, message: msg}]})
  end
end
