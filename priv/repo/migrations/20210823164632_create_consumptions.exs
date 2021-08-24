defmodule Centrix.Repo.Migrations.CreateConsumptions do
  use Ecto.Migration

  def change do
    create table(:consumptions) do
      add :watt, :integer

      add :device_id, references(:devices)

      timestamps()
    end

  end
end
