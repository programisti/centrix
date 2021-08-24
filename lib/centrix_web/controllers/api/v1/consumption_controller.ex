defmodule CentrixWeb.Api.V1.ConsumptionController do
  use CentrixWeb, :controller
  alias Centrix.Devices

  action_fallback(CentrixWeb.FallbackController)

  def index(conn, %{"device_id" => device_id} = params) do
    %{private: %{guardian_default_resource: current_user}} = conn

    with :ok <- Devices.is_device_owner!(current_user, device_id),
         consumptions when is_list(consumptions) <-
           Devices.list_device_consumption(device_id, params) do
      render(conn, "list.json", consumptions: consumptions)
    end
  end
end
