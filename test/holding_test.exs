defmodule HoldingTest do
  use Persistence.RepoCase
  import Persistence.Factory
  alias Persistence.Holding

  describe "validations" do
    setup do
      [holding: build(:holding)]
    end

    test "has a valid factory", %{holding: holding} = _ do
      assert {:ok, _} = Holding.changeset(holding) |> Repo.insert
    end

    test "is invalid without a currency", %{holding: holding} = _ do
      changeset = %{holding | currency: nil} |> Holding.changeset
      refute changeset.valid?
    end

    test "is invalid without a quantity", %{holding: holding} = _ do
      changeset = %{holding | quantity: nil} |> Holding.changeset
      refute changeset.valid?
    end

    test "is invalid without a value", %{holding: holding} = _ do
      changeset = %{holding | value: nil} |> Holding.changeset
      refute changeset.valid?
    end

    test "is invalid without an account", %{holding: holding} = _ do
      changeset = %{holding | account_id: nil} |> Holding.changeset
      refute changeset.valid?
    end

    test "is invalid with an invalid account", %{holding: holding} = _ do
      assert {:error, changeset} = %{holding | account_id: -1} |> Holding.changeset |> Repo.insert
    end

    test "is invalid without a security", %{holding: holding} = _ do
      changeset = %{holding | security_id: nil} |> Holding.changeset
      refute changeset.valid?
    end

    test "is invalid with an invalid security", %{holding: holding} = _ do
      assert {:error, changeset} = %{holding | security_id: -1} |> Holding.changeset |> Repo.insert
    end

    test "is valid with a newly created security already cast", %{holding: holding} = _ do
      changeset = %{holding | security_id: nil, security: build(:security)} |> Holding.changeset
      assert changeset.valid?
    end

    test "is valid with a newly created security not cast", %{holding: holding} = _ do
      changeset = %{holding | security_id: nil, security: params_for(:security)} |> Holding.changeset
      assert changeset.valid?
    end

    test "is invalid with the same account and a duplicate security", %{holding: holding} = _ do
      insert(:holding, account_id: holding.account_id, security_id: holding.security_id)
      assert {:error, changeset} = Holding.changeset(holding) |> Repo.insert
    end
  end
end
