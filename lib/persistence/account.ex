defmodule Persistence.Account do
  use Persistence.Schema
  alias Persistence.Portfolio

  schema "accounts" do
    field :global_id, :binary_id
    field :designation, :string
    field :tax_discount, :decimal
    field :value, :integer
    field :discounted_value, :integer

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
