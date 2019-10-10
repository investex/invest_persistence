defmodule Persistence.Repo.Migrations.CreatePortfolios do
  use Ecto.Migration

  def up do
    create table(:portfolios) do
      add :global_id, :uuid, null: false, default: fragment("uuid_generate_v4()")
      add :user_id, references(:users), null: false
      add :currency, :string, null: false
      add :value, :integer, null: false, default: 0
      add :discounted_value, :integer, null: false, default: 0

      timestamps()
    end

    alter table(:portfolios) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create unique_index(:portfolios, [:global_id])
    create index(:portfolios, [:user_id])
  end

  def down do
    drop table(:portfolios)
  end
end
