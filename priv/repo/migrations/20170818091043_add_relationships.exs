defmodule Stewarding.Repo.Migrations.AddRelationships do
  use Ecto.Migration

  def change do
    create table(:relationships) do
      add :source_id, references(:people), null: false
      add :target_id, references(:people), null: false
    end
    create unique_index(:relationships, [:source_id, :target_id])
  end
end
