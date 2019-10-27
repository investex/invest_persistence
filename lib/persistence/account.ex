defmodule Invest.Persistence.Account do
  use Invest.Persistence.Schema
  alias Invest.Persistence.Portfolio

  schema "accounts" do
    field :global_id, :binary_id, read_after_writes: true
    field :designation, :string
    field :tax_discount, :decimal
    field :value, :integer, read_after_writes: true
    field :discounted_value, :integer, read_after_writes: true

    belongs_to :portfolio, Portfolio

    timestamps()
  end

  def changeset(account, params \\ %{}) do
    account
    |> Ecto.Changeset.cast(params, [:designation, :tax_discount, :value, :discounted_value, :portfolio_id])
    |> Ecto.Changeset.validate_required([:designation, :tax_discount, :value, :discounted_value, :portfolio_id])
    |> Ecto.Changeset.assoc_constraint(:portfolio)
  end
end
