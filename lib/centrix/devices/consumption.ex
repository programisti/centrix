defmodule Centrix.Devices.Consumption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "consumptions" do
    field :watt, :integer

    timestamps()
  end

  @doc false
  def changeset(consumption, attrs) do
    consumption
    |> cast(attrs, [:watt])
    |> validate_required([:watt])
  end
end
