defmodule CentrixWeb.Api.V1.ConsumptionControllerTest do
  use CentrixWeb.ConnCase
  alias Centrix.Accounts

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "gets consumption history for device", %{conn: conn} do
      device = insert(:device)
      insert(:consumption, %{watt: 25, device_id: device.id})
      insert(:consumption, %{watt: 27, device_id: device.id})
      insert(:consumption, %{watt: 22, device_id: device.id})
      insert(:consumption, %{watt: 23, device_id: device.id})

      user = Accounts.get_user!(device.user_id)

      data =
        conn
        |> login(user)
        |> get(
          Routes.category_device_consumption_path(conn, :index, device.category_id, device.id)
        )
        |> json_response(200)

      assert Enum.count(data) == 4
    end

    test "gets consumption history for device between time range", %{conn: conn} do
      device = insert(:device)
      insert(:consumption, %{watt: 25, device_id: device.id})
      insert(:consumption, %{watt: 27, device_id: device.id})
      insert(:consumption, %{watt: 22, device_id: device.id})
      insert(:consumption, %{watt: 23, device_id: device.id})

      user = Accounts.get_user!(device.user_id)

      data =
        conn
        |> login(user)
        |> get(
          Routes.category_device_consumption_path(conn, :index, device.category_id, device.id, %{
            start_date: "2021-07-23T23:50:07Z",
            end_date: "2022-10-23T23:50:07Z"
            })
        )
        |> json_response(200)

      assert Enum.count(data) == 4
    end

    test "gets consumption history for without end_date", %{conn: conn} do
      device = insert(:device)
      insert(:consumption, %{watt: 25, device_id: device.id})
      insert(:consumption, %{watt: 27, device_id: device.id})
      insert(:consumption, %{watt: 22, device_id: device.id})
      insert(:consumption, %{watt: 23, device_id: device.id})

      user = Accounts.get_user!(device.user_id)

      data =
        conn
        |> login(user)
        |> get(
          Routes.category_device_consumption_path(conn, :index, device.category_id, device.id, %{
            start_date: "2021-07-23T23:50:07Z"
            })
        )
        |> json_response(200)

      assert Enum.count(data) == 4
    end

    test "stranger can not accesss to someones device's consumption history", %{conn: conn} do
      device = insert(:device)
      insert(:consumption, %{watt: 25, device_id: device.id})
      insert(:consumption, %{watt: 27, device_id: device.id})
      insert(:consumption, %{watt: 22, device_id: device.id})
      insert(:consumption, %{watt: 23, device_id: device.id})

      strange_user = insert(:user)

      data =
        conn
        |> login(strange_user)
        |> get(
          Routes.category_device_consumption_path(conn, :index, device.category_id, device.id)
        )
        |> json_response(200)

      assert %{
               "errors" => [%{"message" => "Not a device owner"}],
               "status" => "error"
             } = data
    end
  end
end
