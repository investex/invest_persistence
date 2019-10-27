defmodule Invest.Persistence.Transaction do
  use Invest.Persistence.Schema
  alias Invest.Persistence.{Account, Security}

  schema "transactions" do
    field :global_id, :binary_id, read_after_writes: true
    field :classification, :string
    field :quantity, :integer
    field :price, :integer
    field :commission, :integer, read_after_writes: true
    field :settlement_date, :date

    belongs_to :account, Account
    belongs_to :security, Security

    timestamps()
  end

  def changeset(transaction, params \\ %{})
  def changeset(%{security: %Ecto.Association.NotLoaded{}} = transaction, params) do
    base_changeset(transaction, params)
    |> Ecto.Changeset.validate_required([:security_id])
  end
  def changeset(%{security: %{}} = transaction, params) do
    base_changeset(transaction, params)
  end
  def changeset(transaction, params) do
    base_changeset(transaction, params)
    |> Ecto.Changeset.validate_required([:security_id])
  end

  defp base_changeset(transaction, params) do
    transaction
    |> Ecto.Changeset.cast(params, [:classification, :quantity, :price, :commission, :settlement_date, :account_id, :security_id])
    |> Ecto.Changeset.validate_required([:classification, :quantity, :price, :commission, :settlement_date, :account_id])
    |> Ecto.Changeset.assoc_constraint(:account)
    |> Ecto.Changeset.assoc_constraint(:security)
  end
end
