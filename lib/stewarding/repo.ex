defmodule Stewarding.Repo do
  use Ecto.Repo, otp_app: :stewarding
end

defmodule Stewarding.Person do
  use Ecto.Schema
  import Ecto.Query

  schema "people" do
    field :key, :string
    field :stewardee, :string
  end

  def last_person do
    Stewarding.Person
    |> Ecto.Query.last
    |> Stewarding.Repo.one
  end

  def fetch_person(key) do
    Stewarding.Person
    |> Stewarding.Repo.get_by(key: key)
  end

  def add_person(key) do
    case Stewarding.Person.fetch_person(key) do
      nil -> Stewarding.Repo.insert %Stewarding.Person{key: key}
      _ -> {:error, key <> " already exists"}
    end
  end

  def get_steward(key) do
    steward = Stewarding.Person |> Stewarding.Repo.get_by(stewardee: key)
    fetch_person(key)
    |> validate_found(fn _ -> steward end)
  end

  def get_stewardee(key) do
    fetch_person(key)
    |> validate_found(&(&1.stewardee))
  end

# ---

  defp validate_found(person, thunk) do
    case person do
      nil -> {:error, "person not found"}
      person -> {:ok, thunk.(person)}
    end
  end
end
