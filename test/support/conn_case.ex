defmodule CentrixWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use CentrixWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  defmodule TokenEndpoint do
    def config(:secret_key_base), do: "abc123"
  end

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import CentrixWeb.ConnCase
      import Centrix.Factory

      alias CentrixWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint CentrixWeb.Endpoint

      def login(conn, user) do
        {:ok, token, _} = Centrix.Guardian.encode_and_sign(user)
        conn
        |> Plug.Conn.put_private(:phoenix_endpoint, TokenEndpoint)
        |> Plug.Conn.assign(:current_user, user)
        |> put_req_header("authorization", "Bearer #{token}")
      end

      def login(conn) do
        user = insert(:user)
        {:ok, token, _} = Centrix.Guardian.encode_and_sign(user)
        conn
        |> Plug.Conn.put_private(:phoenix_endpoint, TokenEndpoint)
        |> Plug.Conn.assign(:current_user, user)
        |> put_req_header("authorization", "Bearer #{token}")
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Centrix.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Centrix.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
