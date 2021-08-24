defmodule CentrixWeb.Api.V1.SensorControllerTest do
  use CentrixWeb.ConnCase
  alias Centrix.{Accounts, Devices}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "list all sensors for device", %{conn: conn} do
      user = insert(:user)
      category = insert(:category, %{name: "Kitchen", user_id: user.id})
      device = insert(:device, %{name: "Thermometer", category_id: category.id, user_id: user.id})
      sensor = insert(:sensor, %{name: "Sensor1", device_id: device.id})

      data =
        conn
        |> login(user)
        |> get(Routes.category_device_sensor_path(conn, :index, category.id, device.id))
        |> json_response(200)

      assert Enum.count(data) > 0
      device_data = List.first(data)
      assert device_data["id"] == sensor.id
      assert device_data["name"] == sensor.name
    end

    test "do not shows sensors for another device", %{conn: conn} do
      user1 = insert(:user)
      user2 = insert(:user)

      category_user1 = insert(:category, %{name: "Kitchen User1", user_id: user1.id})
      category_user2 = insert(:category, %{name: "Kitchen User2", user_id: user2.id})

      device_user1 = insert(:device, %{name: "Thermometer User1", category_id: category_user1.id})
      device_user2 = insert(:device, %{name: "Thermometer User2", category_id: category_user2.id})

      insert(:sensor, %{name: "For User1", device_id: device_user1.id})
      insert(:sensor, %{name: "For User2", device_id: device_user2.id})

      data =
        conn
        |> login(user2)
        |> get(
          Routes.category_device_sensor_path(conn, :index, category_user2.id, device_user2.id)
        )
        |> json_response(200)

      assert [%{"name" => "For User2"}] = data
    end
  end

  describe "on/off" do
    test "owner can turn sensor on", %{conn: conn} do
      sensor = insert(:sensor, %{name: "Sensor1", is_on: false})
      device = Devices.get_device!(sensor.device_id)
      user = Accounts.get_user!(device.user_id)

      conn
      |> login(user)
      |> get(Routes.sensor_path(conn, :turn_on, sensor.id))
      |> json_response(200)

      sensor = Devices.get_sensor!(sensor.id)

      assert sensor.is_on
    end

    test "strange user can not turn sensor on", %{conn: conn} do
      user2 = insert(:user)
      sensor = insert(:sensor, %{name: "Sensor1", is_on: false})

      data =
        conn
        |> login(user2)
        |> get(Routes.sensor_path(conn, :turn_on, sensor.id))
        |> json_response(200)

      assert %{
               "errors" => [%{"field" => "turn_on", "message" => "User is not sensor owner"}],
               "status" => "error"
             } = data

      sensor = Devices.get_sensor!(sensor.id)

      refute sensor.is_on
    end
  end
end
