defmodule CentrixWeb.Api.V1.UserView do
  use CentrixWeb, :view

  def render("list.json", %{users: users}) do
    render_many(users, __MODULE__, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email
    }
  end

end
