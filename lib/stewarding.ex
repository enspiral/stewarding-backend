defmodule Stewarding do
  @moduledoc """
  Documentation for Stewarding.
  """
  use Application

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
    Stewarding.Person.add_person(key)
  end

  def get_steward(key) do
    Stewarding.Person.get_steward(key)
  end

  def get_stewardee(key) do
    Stewarding.Person.get_stewardee(key)
  end
end
