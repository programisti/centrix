defmodule CentrixWeb.SessionControllerTest do
  use CentrixWeb.ConnCase
  alias Centrix.Accounts
  alias Argon2

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "register" do
    test "registers user", %{conn: conn} do
      conn
      |> post(Routes.session_path(conn, :create), %{
          name: "somename",
          email: "email@example.com",
          password: "password",
        })
      |> json_response(200)

      users = Accounts.list_users()

      assert Enum.count(users) > 0

      user = List.last(users)

      assert user.email == "email@example.com"
      assert user.name == "somename"
      assert Argon2.verify_pass("password", user.encrypted_password)
    end
  end

  describe "login" do
    test "returns token", %{conn: conn} do
      encrypted_password = Argon2.hash_pwd_salt("password")
      user = insert(:user, %{encrypted_password: encrypted_password})

      data =
        conn
        |> login(user)
        |> post(Routes.session_path(conn, :login), %{
            email: user.email,
            password: "password"
          })
        |> json_response(200)

      assert data["name"] == user.name
      assert String.length(data["access"]["access_token"]) > 30
    end
  end
end
