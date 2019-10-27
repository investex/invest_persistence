defmodule Invest.Persistence.Holding do
  use Invest.Persistence.Schema
  alias Invest.Persistence.{Account, Security}

  schema "holdings" do
    field :global_id, :binary_id, read_after_writes: true
    field :currency, :string
    field :quantity, :integer, read_after_writes: true
    field :value, :integer, read_after_writes: true

    belongs_to :account, Account
    belongs_to :security, Security

    timestamps()
  end

  def changeset(holding, params \\ %{})
  def changeset(%{security: %Ecto.Association.NotLoaded{}} = holding, params) do
    base_changeset(holding, params)
    |> Ecto.Changeset.validate_required([:security_id])
  end
  def changeset(%{security: %{}} = holding, params) do
    base_changeset(holding, params)
  end
  def changeset(holding, params) do
    base_changeset(holding, params)
    |> Ecto.Changeset.validate_required([:security_id])
  end

  defp base_changeset(holding, params) do
    holding
    |> Ecto.Changeset.cast(params, [:currency, :quantity, :value, :account_id, :security_id])
    |> Ecto.Changeset.validate_required([:currency, :quantity, :value, :account_id])
    |> Ecto.Changeset.assoc_constraint(:account)
    |> Ecto.Changeset.assoc_constraint(:security)
    |> Ecto.Changeset.unique_constraint(:security, name: :holdings_account_id_security_id_index)
  end
end
