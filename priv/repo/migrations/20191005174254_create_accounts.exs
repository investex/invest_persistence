defmodule Persistence.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def up do
    create table(:accounts) do
      add :global_id, :uuid, null: false, default: fragment("uuid_generate_v4()")
      add :portfolio_id, references(:portfolios), null: false
      add :designation, :string, null: false
      add :tax_discount, :decimal, null: false
      add :value, :integer, null: false, default: 0
      add :discounted_value, :integer, null: false, default: 0

      timestamps()
    end

    alter table(:accounts) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create unique_index(:accounts, [:global_id])
    create index(:accounts, [:portfolio_id])
  end

  def down do
    drop table(:accounts)
  end
end
