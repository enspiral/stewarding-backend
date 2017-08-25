
defmodule PersonTest do
  use ExUnit.Case
  alias Stewarding.Person

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Stewarding.Repo)
  end

  test "Returns nil if no other person exist" do
    {:ok, person} = Person.add_person(%{:key => "craig"})
    assert Person.get_previous(person) == nil
  end

  test "Returns previous person" do
    {:ok, obo} = Person.add_person(%{:key => "obo"})
    {:ok, craig} = Person.add_person(%{:key => "craig"})
    {:ok, nicolas} = Person.add_person(%{:key => "nicolas"})
    assert Person.get_previous(nicolas) == craig
  end
end
