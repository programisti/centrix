defmodule CentrixWeb.Api.V1.SessionView do
  use CentrixWeb, :view

  def render("token.json", %{user: _user, token: {:error, error}}) do
    IO.inspect error
    %{
      status: :error,
      message: "Unknown error duraing authentication"
    }
  end

  def render("token.json", %{user: user, token: token}) do
    %{
      name: user.name,
      access: response(token)
    }
  end

  defp response({:ok, token, %{"exp" => exp}}) do
    token_response(token, exp)
  end

  defp response({:ok, _old_token, {token, %{"exp" => exp}}}) do
    token_response(token, exp)
  end

  # Create nice response shape
  defp token_response(token, exp) do
    %{access_token: token, token_type: "bearer", expires_in: exp}
  end
end
