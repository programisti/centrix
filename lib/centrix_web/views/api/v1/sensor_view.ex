defmodule CentrixWeb.Api.V1.SensorView do
  use CentrixWeb, :view

  def render("list.json", %{sensors: sensors}) do
    render_many(sensors, __MODULE__, "sensor.json")
  end

  def render("sensor.json", %{sensor: sensor}) do
    %{
      id: sensor.id,
      name: sensor.name
    }
  end
end
