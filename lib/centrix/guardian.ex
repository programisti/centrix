defmodule Centrix.Guardian do
  @moduledoc false

  use Guardian, otp_app: :centrix

  alias Centrix.Accounts
  alias Centrix.Accounts.User

  require Logger

  @doc ~S"""
  Get `User` representation as string - JWT subject
  """
  def subject_for_token(%User{id: id}, _claims) do
    IO.inspect 11111
    {:ok, Base.encode64("user:#{id}")}
  end

  @doc ~S"""
  Get `User` struct from its string form - JWT subject
  """
  def resource_from_claims(%{"sub" => subject}) do
    IO.inspect 222222
    with {:ok, "user:" <> id} <- Base.decode64(subject),
         %User{} = user <- Accounts.get_user!(id) do
      {:ok, user}
    else
      _error ->
        Logger.error("User not found. Subject: #{subject}")
        {:error, :no_resource_found}
    end
  end
end
