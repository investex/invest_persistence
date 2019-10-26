defmodule Persistence.Portfolio do
  use Persistence.Schema
  alias Persistence.User

  schema "portfolios" do
    field :global_id, :binary_id, read_after_writes: true
    field :name, :string
    field :currency, :string
    field :value, :integer, read_after_writes: true
    field :discounted_value, :integer, read_after_writes: true

    belongs_to :user, User

    timestamps()
  end

  def changeset(portfolio, params \\ %{}) do
    portfolio
    |> Ecto.Changeset.cast(params, [:name, :currency, :value, :discounted_value, :user_id])
    |> Ecto.Changeset.validate_required([:name, :currency, :user_id])
    |> Ecto.Changeset.assoc_constraint(:user)
  end
end
