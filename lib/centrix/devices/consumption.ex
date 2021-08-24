defmodule Centrix.Devices.Consumption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "consumptions" do
    field :watt, :integer

    belongs_to :device, Centrix.Devices.Device

    timestamps()
  end

  @doc false
  def changeset(consumption, attrs) do
    consumption
    |> cast(attrs, [:watt, :device_id])
    |> validate_required([:watt, :device_id])
  end
end
