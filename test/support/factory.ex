defmodule Persistence.Factory do
  use ExMachina.Ecto, repo: Persistence.Repo

  use Persistence.Factories.Accounts
  use Persistence.Factories.AssetCategories
  use Persistence.Factories.Holdings
  use Persistence.Factories.Portfolios
  use Persistence.Factories.Securities
  use Persistence.Factories.Transactions
  use Persistence.Factories.Users
end
