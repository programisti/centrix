defmodule Centrix.Devices.Device do
  use Ecto.Schema
  import Ecto.Changeset

  alias Centrix.Accounts.User
  alias Centrix.Devices.Sensor

  schema "devices" do
    field :name, :string

    belongs_to :category, User
    belongs_to :user, User
    has_many :sensors, Sensor

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:name, :user_id, :category_id])
    |> validate_required([:name, :user_id])
  end
end
