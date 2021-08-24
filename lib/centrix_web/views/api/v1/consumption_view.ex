defmodule CentrixWeb.Api.V1.ConsumptionView do
  use CentrixWeb, :view

  def render("list.json", %{consumptions: consumptions}) do
    render_many(consumptions, __MODULE__, "consumption.json")
  end

  def render("consumption.json", %{consumption: consumption}) do
    %{
      watt: consumption.watt,
      date: consumption.inserted_at
    }
  end
end
