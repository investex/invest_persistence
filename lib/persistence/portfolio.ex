defmodule Persistence.Portfolio do
  use Persistence.Schema
  alias Persistence.User

  schema "portfolios" do
    field :global_id, :binary_id
    field :currency, :string
    field :value, :integer
    field :discounted_value, :integer

    belongs_to :user, User

    timestamps()
  end

  def changeset(portfolio, params \\ %{}) do
    portfolio
    |> Ecto.Changeset.cast(params, [:currency, :value, :discounted_value, :user_id])
    |> Ecto.Changeset.validate_required([:currency, :value, :discounted_value, :user_id])
    |> Ecto.Changeset.assoc_constraint(:user)
  end
end
