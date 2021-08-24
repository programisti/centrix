defmodule CentrixWeb.Api.V1.DeviceView do
  use CentrixWeb, :view

  alias CentrixWeb.Api.V1.SensorView

  def render("list.json", %{devices: devices}) do
    render_many(devices, __MODULE__, "device.json")
  end

  def render("device.json", %{device: device}) do
    %{
      id: device.id,
      name: device.name,
      sensors: render_many(device.sensors, SensorView, "comment.json")
    }
  end
end
