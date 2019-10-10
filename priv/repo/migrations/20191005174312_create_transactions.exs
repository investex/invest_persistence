defmodule Persistence.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def up do
    create table(:transactions) do
      add :global_id, :uuid, null: false, default: fragment("uuid_generate_v4()")
      add :account_id, references(:accounts), null: false
      add :security_id, references(:securities), null: false
      add :classification, :string, null: false
      add :quantity, :integer, null: false
      add :price, :integer, null: false
      add :commission, :integer, null: false, default: 0
      add :settlement_date, :date, null: false

      timestamps()
    end

    alter table(:transactions) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create unique_index(:transactions, [:global_id])
    create index(:transactions, [:account_id])
    create index(:transactions, [:security_id])
  end

  def down do
    drop table(:transactions)
  end
end
