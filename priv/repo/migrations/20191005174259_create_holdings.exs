defmodule Invest.Persistence.Repo.Migrations.CreateHoldings do
  use Ecto.Migration

  def up do
    create table(:holdings) do
      add :global_id, :uuid, null: false, default: fragment("uuid_generate_v4()")
      add :account_id, references(:accounts), null: false
      add :security_id, references(:securities), null: false
      add :currency, :string, null: false
      add :quantity, :integer, null: false, default: 0
      add :value, :integer, null: false, default: 0

      timestamps()
    end

    alter table(:holdings) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create unique_index(:holdings, [:global_id])
    create unique_index(:holdings, [:account_id, :security_id])
    create index(:holdings, [:account_id])
    create index(:holdings, [:security_id])
  end

  def down do
    drop table(:holdings)
  end
end
