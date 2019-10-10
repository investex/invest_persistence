defmodule Persistence.Repo.Migrations.CreateSecurities do
  use Ecto.Migration

  def up do
    create table(:securities) do
      add :global_id, :uuid, null: false, default: fragment("uuid_generate_v4()")
      add :ticker, :string, null: false
      add :currency, :string, null: false
      add :price, :integer, null: false, default: 0

      timestamps()
    end

    alter table(:securities) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create unique_index(:securities, [:global_id])
    create unique_index(:securities, [:ticker])
  end

  def down do
    drop table(:securities)
  end
end
