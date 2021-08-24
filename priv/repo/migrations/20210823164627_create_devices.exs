defmodule Centrix.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :name, :string
      add :status, :string

      add :user_id, references(:users)
      add :category_id, references(:categories)

      timestamps()
    end
  end
end
