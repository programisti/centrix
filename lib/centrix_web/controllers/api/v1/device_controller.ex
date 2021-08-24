defmodule CentrixWeb.Api.V1.DeviceController do
  use CentrixWeb, :controller
  alias Centrix.Devices

  def index(conn, _params) do
    devices = Devices.list_devices([:sensors, :user])
    render(conn, "list.json", devices: devices)
  end

  def create(conn, %{"device" => device_params, "category_id" => category_id}) do
    %{private: %{guardian_default_resource: current_user}} = conn

    with device_params <-
           Map.merge(device_params, %{"user_id" => current_user.id, "category_id" => category_id}),
         {:ok, device} <- Devices.create_device(device_params),
         device <- Centrix.Repo.preload(device, :sensors) do
      render(conn, "device.json", device: device)
    end
  end
end
