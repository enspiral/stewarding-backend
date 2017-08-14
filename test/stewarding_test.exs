defmodule StewardingTest do
  use ExUnit.Case
  doctest Stewarding

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Stewarding.Repo)
  end

  test "adding a person with duplicate key reports an error" do
    email = "craig@enspiral.com"
    assert {:ok, _} = Stewarding.add_person(email)
    assert Stewarding.add_person(email) == {:error, email <> " already exists"}
  end

  test "getting steward on person who doesn't exist returns error" do
    assert Stewarding.get_steward("craig@enspiral.com") == {:error, "person not found"}
    assert Stewarding.get_stewardee("craig@enspiral.com") == {:error, "person not found"}
  end

  test "first person has no connections" do
    Stewarding.add_person "craig@enspiral.com"

    assert Stewarding.get_steward("craig@enspiral.com") == {:ok, nil}
    assert Stewarding.get_stewardee("craig@enspiral.com") == {:ok, nil}
  end

  # test "second person is stewarded by first" do
  #   Stewarding.add_person "craig@enspiral.com"
  #   Stewarding.add_person "nicolas@enspiral.com"

  #   assert Stewarding.get_steward("nicolas@enspiral.com") == {:ok, "craig@enspiral.com"}
  #   assert Stewarding.get_stewardee("nicolas@enspiral.com") == {:ok, nil}
  # end
end
