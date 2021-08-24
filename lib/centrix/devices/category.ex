defmodule Centrix.Devices.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string

    belongs_to :user, Centrix.Accounts.User
    has_many :devices, Centrix.Devices.Device

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
