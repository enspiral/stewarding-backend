defmodule Stewarding.Repo do
  use Ecto.Repo, otp_app: :stewarding
end

defmodule Stewarding.Person do
  use Ecto.Schema
  import Ecto.Query
  alias Stewarding.Person
  alias Stewarding.Repo

  schema "people" do
    field :key, :string
    field :stewardee, :string
  end

  def last_person do
    Person
    |> last
    |> Repo.one
  end

  def fetch_person(key) do
    Person
    |> Repo.get_by(key: key)
  end

  def add_person(key) do
    case Person.fetch_person(key) do
      nil -> Repo.insert %Person{key: key}
      _ -> {:error, key <> " already exists"}
    end
  end

  def get_steward(key) do
    steward = Person |> Repo.get_by(stewardee: key)
    key
    |> fetch_person
    |> validate_found(fn _ -> steward end)
  end

  def get_stewardee(key) do
    key
    |> fetch_person
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
