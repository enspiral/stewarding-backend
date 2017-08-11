defmodule Stewarding.Repo do
  use Ecto.Repo, otp_app: :stewarding

  # def insert(data) do

  # end
end

defmodule Stewarding.Person do
  use Ecto.Schema

  schema "people" do
    field :key, :string
  end
end