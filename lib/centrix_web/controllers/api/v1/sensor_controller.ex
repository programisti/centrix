defmodule CentrixWeb.Api.V1.SensorController do
  use CentrixWeb, :controller
  alias Centrix.Devices

  def index(conn, _params) do
    sensors = Devices.list_sensors()
    render(conn, "list.json", sensors: sensors)
  end

  def turn_on(conn, %{"sensor_id" => sensor_id}) do
    with {:ok, sensor} <- Devices.turn_sensor_on(sensor_id) do
      render(conn, "sensor.json", sensor: sensor)
    end
  end

  def turn_off(conn, %{"sensor_id" => sensor_id}) do
    with {:ok, sensor} <- Devices.turn_sensor_off(sensor_id) do
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
