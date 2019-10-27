defmodule PortfolioTest do
  use Invest.Persistence.RepoCase
  import Invest.Persistence.Factory
  alias Invest.Persistence.Portfolio

  describe "validations" do
    setup do
      [portfolio: build(:portfolio)]
    end

    test "has a valid factory", %{portfolio: portfolio} = _ do
      assert {:ok, _} = Portfolio.changeset(portfolio) |> Repo.insert
    end

    test "is invalid without a name", %{portfolio: portfolio} = _ do
      changeset = %{portfolio | name: nil} |> Portfolio.changeset
      refute changeset.valid?
    end

    test "is invalid without a currency", %{portfolio: portfolio} = _ do
      changeset = %{portfolio | currency: nil} |> Portfolio.changeset
      refute changeset.valid?
    end

    test "is valid without a value", %{portfolio: portfolio} = _ do
      changeset = %{portfolio | value: nil} |> Portfolio.changeset
      assert changeset.valid?
    end

    test "is valid without a discounted value", %{portfolio: portfolio} = _ do
      changeset = %{portfolio | discounted_value: nil} |> Portfolio.changeset
      assert changeset.valid?
    end

    test "is invalid without a user", %{portfolio: portfolio} = _ do
      changeset = %{portfolio | user_id: nil} |> Portfolio.changeset
      refute changeset.valid?
    end

    test "is invalid with an invalid user", %{portfolio: portfolio} = _ do
      assert {:error, changeset} = %{portfolio | user_id: -1} |> Portfolio.changeset |> Repo.insert
    end
  end
end
