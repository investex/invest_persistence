defmodule Persistence.AssetCategory do
  use Persistence.Schema
  alias Persistence.Portfolio

  schema "asset_categories" do
    field :global_id, :binary_id
    field :name, :string
    field :target_percentage, :decimal
    field :actual_percentage, :decimal
    field :difference, :integer

    belongs_to :portfolio, Portfolio

    timestamps()
  end

  def changeset(asset_category, params \\ %{}) do
    asset_category
    |> Ecto.Changeset.cast(params, [:name, :target_percentage, :actual_percentage, :difference, :portfolio_id])
    |> Ecto.Changeset.validate_required([:name, :target_percentage, :actual_percentage, :difference, :portfolio_id])
    |> Ecto.Changeset.assoc_constraint(:portfolio)
    |> Ecto.Changeset.unique_constraint(:name, name: :asset_categories_portfolio_id_name_index)
  end
end
