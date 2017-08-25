defmodule Stewarding do
  @moduledoc """
  Documentation for Stewarding.
  """
  use Application
  alias Stewarding.Person
  use PlumberGirl

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Stewarding.Repo, []),
    ]
    opts = [ strategy: :one_for_one, name: Stewarding.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def main(args) do
    IO.puts "Hello world"
  end

  def add_person(key) do
    %{:key => key}
    |> Person.add_person
    >>> setup_relationships
  end

  def get_steward(key) do
    key
    |> Person.fetch_person
    >>> Person.get_steward
  end

  def get_stewardee(key) do
    key
    |> Person.fetch_person
    >>> Person.get_stewardee
  end

  # ----

  defp setup_relationships(person) do
    case MatchMaker.match(person) do
      nil -> {:ok, person}
      relationship -> store_relationship(relationship, person)
    end
  end

  defp store_relationship(relationship, person) do
    case Stewarding.Repo.insert(relationship) do
      result = {:error, _} -> result
      {:ok, _} -> {:ok, person}
    end
  end
end
