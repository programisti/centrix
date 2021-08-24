defmodule Centrix.Repo.Migrations.CreateSensors do
  use Ecto.Migration

  def change do
    create table(:sensors) do
      add :name, :string
      add :is_on, :boolean

      add :device_id, references(:devices)

      timestamps()
    end
  end
end
