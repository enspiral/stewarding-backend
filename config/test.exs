use Mix.Config

config :stewarding, Stewarding.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "stewarding_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432"