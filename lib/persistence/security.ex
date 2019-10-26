defmodule Persistence.Security do
  use Persistence.Schema

  schema "securities" do
    field :global_id, :binary_id, read_after_writes: true
    field :ticker, :string
    field :currency, :string
    field :price, :integer, read_after_writes: true

    timestamps()
  end

  def changeset(security, params \\ %{}) do
    security
    |> Ecto.Changeset.cast(params, [:ticker, :currency, :price])
    |> Ecto.Changeset.validate_required([:ticker, :currency, :price])
    |> Ecto.Changeset.unique_constraint(:ticker)
  end
end
