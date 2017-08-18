defmodule Stewarding.Person do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset
  alias Stewarding.Person
  alias Stewarding.Repo

  schema "people" do
    field :key, :string
  end


  def changeset(record, params \\ :empty) do
    record
    |> cast(params, [:key])
    |> validate_required([:key])
    |> unique_constraint(:key)
  end

  def get_previous(person) do
    Person
    |> where([p], p.id < ^person.id )
    |> last
    |> Repo.one
  end

  def fetch_person(key) do
    Person
    |> Repo.get_by(key: key)
    |> validate_found
  end

  def add_person(attrs) do
      %Person{}
      |> changeset(attrs)
      |> Repo.insert()
  end

  def get_steward(key) do
    key
    |> fetch_person
    |> case do
      result = {:error, _} -> result
      {:ok, person} -> person
        |> Relationship.fetch_targetting
        |> Relationship.fetch_source
        |> (&({:ok, &1})).()
    end
  end

  def get_stewardee(key) do
    key
    |> fetch_person
    |> case do
      result = {:error, _} -> result
      {:ok, person} -> person
        |> Relationship.fetch_sourcing
        |> Relationship.fetch_target
        |> (&({:ok, &1})).()
    end
  end

# ---

  defp validate_found(person) do
    case person do
      nil -> {:error, "person not found"}
      person -> {:ok, person}
    end
  end
end
