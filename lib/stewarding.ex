defmodule Stewarding do
  @moduledoc """
  Documentation for Stewarding.
  """

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Stewarding.Repo, []),
    ]
  end

  def main(args) do
    IO.puts "Hello world"
  end

  def add_person(key) do
    Stewarding.Repo.insert %Stewarding.Person{key: key}
  end

  def get_steward(key) do
    {:ok, "craig@enspiral.com"}
  end

  def get_stewardee(key) do
    {:ok, nil}
  end
end
