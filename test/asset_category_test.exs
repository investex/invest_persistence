defmodule AssetCategoryTest do
  use Persistence.RepoCase
  import Persistence.Factory
  alias Persistence.AssetCategory

  describe "validations" do
    setup do
      [asset_category: build(:asset_category)]
    end

    test "has a valid factory", %{asset_category: asset_category} = _ do
      assert {:ok, _} = AssetCategory.changeset(asset_category) |> Repo.insert
    end

    test "is invalid without a name", %{asset_category: asset_category} = _ do
      changeset = %{asset_category | name: nil} |> AssetCategory.changeset
      refute changeset.valid?
    end

    test "is invalid without a target percentage", %{asset_category: asset_category} = _ do
      changeset = %{asset_category | target_percentage: nil} |> AssetCategory.changeset
      refute changeset.valid?
    end

    test "is invalid without an actual percentage", %{asset_category: asset_category} = _ do
      changeset = %{asset_category | actual_percentage: nil} |> AssetCategory.changeset
      refute changeset.valid?
    end

    test "is invalid without a difference", %{asset_category: asset_category} = _ do
      changeset = %{asset_category | difference: nil} |> AssetCategory.changeset
      refute changeset.valid?
    end

    test "is invalid without a portfolio", %{asset_category: asset_category} = _ do
      changeset = %{asset_category | portfolio_id: nil} |> AssetCategory.changeset
      refute changeset.valid?
    end

    test "is invalid with an invalid portfolio", %{asset_category: asset_category} = _ do
      assert {:error, changeset} = %{asset_category | portfolio_id: -1} |> AssetCategory.changeset |> Repo.insert
    end

    test "is invalid with the same portfolio and a duplicate name", %{asset_category: asset_category} = _ do
      insert(:asset_category, name: asset_category.name, portfolio_id: asset_category.portfolio_id)
      assert {:error, changeset} = AssetCategory.changeset(asset_category) |> Repo.insert
    end
  end
end
