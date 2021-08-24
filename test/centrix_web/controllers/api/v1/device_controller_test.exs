defmodule CentrixWeb.Api.V1.DeviceControllerTest do
  use CentrixWeb.ConnCase
  alias Centrix.Devices

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "list all devices for category", %{conn: conn} do
      user = insert(:user)
      category = insert(:category, %{name: "Kitchen", user_id: user.id})
      device = insert(:device, %{name: "Kitchen", category_id: category.id, user_id: user.id})

      data =
        conn
        |> login(user)
        |> get(Routes.category_device_path(conn, :index, category.id))
        |> json_response(200)

      assert Enum.count(data) > 0
      device_data = List.first(data)
      assert device_data["id"] == device.id
      assert device_data["name"] == device.name
    end

    test "do not shows devices for another user and category", %{conn: conn} do
      user1 = insert(:user)
      user2 = insert(:user)

      category_for_user1 = insert(:category, %{name: "Kitchen User1", user_id: user1.id})
      category_for_user2 = insert(:category, %{name: "Kitchen User2", user_id: user2.id})

      insert(:device, %{name: "For User1", category_id: category_for_user1.id, user_id: user1.id})
      insert(:device, %{name: "For User2", category_id: category_for_user2.id, user_id: user2.id})

      data =
        conn
        |> login(user2)
        |> get(Routes.category_device_path(conn, :index, category_for_user1.id))
        |> json_response(200)

      assert [] = data
    end
  end

  describe "create" do
    test "creates category", %{conn: conn} do
      user = insert(:user)
      category = insert(:category, %{name: "Kitchen", user_id: user.id})

      conn
      |> login(user)
      |> post(Routes.category_device_path(conn, :index, category.id), %{
          device: %{
            name: "Thermometer"
          }
        })
      |> json_response(200)

      devices = Devices.list_devices()

      assert Enum.count(devices) > 0
      assert List.last(devices).name == "Thermometer"
      assert List.last(devices).user_id == user.id
      assert List.last(devices).category_id == category.id
    end
  end
end
