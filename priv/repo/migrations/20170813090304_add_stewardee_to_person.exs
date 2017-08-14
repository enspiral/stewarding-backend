defmodule Stewarding.Repo.Migrations.AddStewardeeToPerson do
  use Ecto.Migration

  def change do
    alter table(:people) do
      add :stewardee, :string
    end
  end
end
