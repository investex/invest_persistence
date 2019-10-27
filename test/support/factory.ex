defmodule Invest.Persistence.Factory do
  use ExMachina.Ecto, repo: Invest.Persistence.Repo

  use Invest.Persistence.Factories.Accounts
  use Invest.Persistence.Factories.AssetCategories
  use Invest.Persistence.Factories.Holdings
  use Invest.Persistence.Factories.Portfolios
  use Invest.Persistence.Factories.Securities
  use Invest.Persistence.Factories.Transactions
  use Invest.Persistence.Factories.Users
end
