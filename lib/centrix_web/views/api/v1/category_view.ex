defmodule CentrixWeb.Api.V1.CategoryView do
  use CentrixWeb, :view

  alias CentrixWeb.Api.V1.DeviceView

  def render("list.json", %{categories: categories}) do
    render_many(categories, __MODULE__, "category.json")
  end

  def render("category.json", %{category: category}) do
    %{
      id: category.id,
      name: category.name,
      devices: render_many(category.devices, DeviceView, "device.json")
    }
  end
end
