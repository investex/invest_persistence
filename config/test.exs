import Config

config :persistence, Persistence.Repo,
  database: "invest_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
