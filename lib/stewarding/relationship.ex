defmodule Relationship do
  use Ecto.Schema
  alias Stewarding.Repo
  import Ecto.Query
  import Ecto.Changeset

  schema "relationships" do
    belongs_to :source, Stewarding.Person
    belongs_to :target, Stewarding.Person
  end

  def fetch_targetting(person) do
    Relationship
    |> where([r], r.target_id == ^person.id)
    |> Repo.one
  end

  def fetch_source(nil), do: nil
  def fetch_source(%Relationship{source_id: person_id}) do
    Stewarding.Person
    |> Repo.get_by(id: person_id)
  end

  def fetch_sourcing(person) do
    Relationship
    |> where([s], s.source_id == ^person.id)
    |> Repo.one
  end

  def fetch_target(nil), do: nil
  def fetch_target(%Relationship{target_id: person_id}) do
    Stewarding.Person
    |> Repo.get_by(id: person_id)
  end
end
