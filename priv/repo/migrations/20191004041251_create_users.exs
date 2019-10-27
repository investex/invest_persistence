defmodule Invest.Persistence.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    create table(:users) do
      add :global_id, :uuid, null: false, default: fragment("uuid_generate_v4()")
      add :email, :string, null: false
      add :password_hash, :string, null: false

      timestamps()
    end

    alter table(:users) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create unique_index(:users, [:global_id])
    create unique_index(:users, [:email])
  end

  def down do
    drop table(:users)
  end
end
