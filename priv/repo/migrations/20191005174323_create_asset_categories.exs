defmodule Persistence.Repo.Migrations.CreateAssetCategories do
  use Ecto.Migration

  def up do
    create table(:asset_categories) do
      add :global_id, :uuid, null: false, default: fragment("uuid_generate_v4()")
      add :portfolio_id, references(:portfolios), null: false
      add :name, :string, null: false
      add :target_percentage, :decimal, null: false
      add :actual_percentage, :decimal, null: false
      add :difference, :integer, null: false

      timestamps()
    end

    alter table(:asset_categories) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create unique_index(:asset_categories, [:global_id])
    create unique_index(:asset_categories, [:portfolio_id, :name])
    create index(:asset_categories, [:portfolio_id])
  end

  def down do
    drop table(:asset_categories)
  end
end
