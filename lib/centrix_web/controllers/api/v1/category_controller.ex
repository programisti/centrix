defmodule CentrixWeb.Api.V1.CategoryController do
  use CentrixWeb, :controller
  alias Centrix.Devices

  action_fallback(CentrixWeb.FallbackController)

  def index(conn, _params) do
    %{private: %{guardian_default_resource: current_user}} = conn
    categories = Devices.list_user_categories(current_user, [:devices])
    render(conn, "list.json", categories: categories)
  end

  def create(conn, %{"category" => category_params}) do
    %{private: %{guardian_default_resource: current_user}} = conn

    with category_params <- Map.put(category_params, "user_id", current_user.id),
         {:ok, category} <- Devices.create_category(category_params),
         category <- Centrix.Repo.preload(category, :devices) do
      render(conn, "category.json", category: category)
    end
  end
end
