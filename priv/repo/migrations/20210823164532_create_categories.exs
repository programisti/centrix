defmodule Centrix.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string

      add :user_id, references(:users)
      timestamps()
    end
  end
end
