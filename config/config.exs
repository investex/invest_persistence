import Config

config :invest_persistence, Invest.Persistence.Repo,
  database: "invest_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :invest_persistence, ecto_repos: [Invest.Persistence.Repo]

import_config "#{Mix.env()}.exs"
