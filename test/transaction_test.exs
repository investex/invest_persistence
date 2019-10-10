defmodule TransactionTest do
  use Persistence.RepoCase
  import Persistence.Factory
  alias Persistence.Transaction

  describe "validations" do
    setup do
      [transaction: build(:transaction)]
    end

    test "has a valid factory", %{transaction: transaction} = _ do
      assert {:ok, _} = Transaction.changeset(transaction) |> Repo.insert
    end

    test "is invalid without a classification", %{transaction: transaction} = _ do
      changeset = %{transaction | classification: nil} |> Transaction.changeset
      refute changeset.valid?
    end

    test "is invalid without a quantity", %{transaction: transaction} = _ do
      changeset = %{transaction | quantity: nil} |> Transaction.changeset
      refute changeset.valid?
    end

    test "is invalid without a price", %{transaction: transaction} = _ do
      changeset = %{transaction | price: nil} |> Transaction.changeset
      refute changeset.valid?
    end

    test "is invalid without a commission", %{transaction: transaction} = _ do
      changeset = %{transaction | commission: nil} |> Transaction.changeset
      refute changeset.valid?
    end

    test "is invalid without a settlement date", %{transaction: transaction} = _ do
      changeset = %{transaction | settlement_date: nil} |> Transaction.changeset
      refute changeset.valid?
    end

    test "is invalid without an account", %{transaction: transaction} = _ do
      changeset = %{transaction | account_id: nil} |> Transaction.changeset
      refute changeset.valid?
    end

    test "is invalid with an invalid account", %{transaction: transaction} = _ do
      assert {:error, changeset} = %{transaction | account_id: -1} |> Transaction.changeset |> Repo.insert
    end

    test "is invalid without a security", %{transaction: transaction} = _ do
      changeset = %{transaction | security_id: nil} |> Transaction.changeset
      refute changeset.valid?
    end

    test "is invalid with an invalid security", %{transaction: transaction} = _ do
      assert {:error, changeset} = %{transaction | security_id: -1} |> Transaction.changeset |> Repo.insert
    end

    test "is valid with a newly created security already cast", %{transaction: transaction} = _ do
      changeset = %{transaction | security_id: nil, security: build(:security)} |> Transaction.changeset
      assert changeset.valid?
    end

    test "is valid with a newly created security not cast", %{transaction: transaction} = _ do
      changeset = %{transaction | security_id: nil, security: params_for(:security)} |> Transaction.changeset
      assert changeset.valid?
    end
  end
end
