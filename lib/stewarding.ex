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
    case Person.add_person(%{:key => key}) do
      result = {:ok, person} ->
        relationship = MatchMaker.match(person)
        case relationship do
          nil -> result
          rel -> Stewarding.Repo.insert(rel)
        end
      result -> result
    end
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
end
