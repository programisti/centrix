defmodule Centrix.Devices.Sensor do
  use Ecto.Schema
  import Ecto.Changeset

  alias Centrix.Devices.Device

  schema "sensors" do
    field :name, :string
    field :is_on, :boolean, default: false

    belongs_to :device, Device

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:name, :device_id, :is_on])
    |> validate_required([:name, :device_id])
  end
end
