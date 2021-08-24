defmodule CentrixWeb.Api.V1.ConsumptionController do
  use CentrixWeb, :controller
  alias Centrix.Devices

  def index(conn, %{"device_id" => device_id}) do
    devices = Devices.list_consumption_history(device_id)
    json(conn, devices)
  end
end
