import Config

config :persistence, Persistence.Repo,
  database: "invest_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :persistence, ecto_repos: [Persistence.Repo]

import_config "#{Mix.env()}.exs"
