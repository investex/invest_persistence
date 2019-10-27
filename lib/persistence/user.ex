defmodule Invest.Persistence.User do
  use Invest.Persistence.Schema

  schema "users" do
    field :global_id, :binary_id, read_after_writes: true
    field :email, :string
    field :password_hash, :string

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> Ecto.Changeset.cast(params, [:email, :password_hash])
    |> Ecto.Changeset.validate_required([:email, :password_hash])
    |> Ecto.Changeset.unique_constraint(:email)
  end
end
