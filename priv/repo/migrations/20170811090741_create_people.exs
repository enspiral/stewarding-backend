defmodule Stewarding.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :key, :string
    end
    create unique_index(:people, [:key])
  end
end
