defmodule CentrixWeb.Api.V1.SensorController do
  use CentrixWeb, :controller
  alias Centrix.Devices
  action_fallback(CentrixWeb.FallbackController)

  def index(conn, %{"device_id" => device_id}) do
    sensors = Devices.list_sensors_for_device(device_id)
    render(conn, "list.json", sensors: sensors)
  end

  def turn_on(conn, %{"sensor_id" => sensor_id}) do
    %{private: %{guardian_default_resource: current_user}} = conn

    with true <-
           Devices.is_sensor_owner?(current_user, sensor_id) ||
             {:error, "User is not sensor owner"},
         {:ok, sensor} <- Devices.turn_sensor_on(sensor_id) do
      render(conn, "sensor.json", sensor: sensor)
    end
  end

  def turn_off(conn, %{"sensor_id" => sensor_id}) do
    %{private: %{guardian_default_resource: current_user}} = conn

    with true <-
           Devices.is_sensor_owner?(current_user, sensor_id) ||
             {:error, "User is not sensor owner"},
         {:ok, sensor} <- Devices.turn_sensor_off(sensor_id) do
      render(conn, "sensor.json", sensor: sensor)
    end
  end

  def create(conn, %{"device_id" => device_id, "sensor" => sensor_params}) do
    with sensor_params <- Map.put(sensor_params, "device_id", device_id),
         {:ok, sensor} <- Devices.create_sensor(sensor_params) do
      render(conn, "sensor.json", sensor: sensor)
    end
  end
end
