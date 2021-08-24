defmodule CentrixWeb.Api.V1.CategoryControllerTest do
  use CentrixWeb.ConnCase
  alias Centrix.Devices

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "list all categories for user", %{conn: conn} do
      user = insert(:user)
      category = insert(:category, %{name: "Kitchen", user_id: user.id})

      data =
        conn
        |> login(user)
        |> get(Routes.category_path(conn, :index))
        |> json_response(200)

      assert Enum.count(data) > 0
      category_data = List.first(data)
      assert category_data["id"] == category.id
      assert category_data["name"] == category.name
    end

    test "do not shows categories for another user", %{conn: conn} do
      user1 = insert(:user)
      user2 = insert(:user)

      insert(:category, %{name: "Kitten", user_id: user1.id})

      data =
        conn
        |> login(user2)
        |> get(Routes.category_path(conn, :index))
        |> json_response(200)

      assert data == []
    end
  end

  describe "create" do
    test "creates category", %{conn: conn} do
      user = insert(:user)

      conn
      |> login(user)
      |> post(Routes.category_path(conn, :create), %{
          category: %{ name: "Kitten" }
        })
      |> json_response(200)

      categories = Devices.list_categories()
      assert Enum.count(Devices.list_categories()) > 0
      assert List.last(categories).name == "Kitten"
    end
  end
end
