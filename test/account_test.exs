defmodule AccountTest do
  use Invest.Persistence.RepoCase
  import Invest.Persistence.Factory
  alias Invest.Persistence.Account

  describe "validations" do
    setup do
      [account: build(:account)]
    end

    test "has a valid factory", %{account: account} = _ do
      assert {:ok, _} = Account.changeset(account) |> Repo.insert
    end

    test "is invalid without a designation", %{account: account} = _ do
      changeset = %{account | designation: nil} |> Account.changeset
      refute changeset.valid?
    end

    test "is invalid without a tax discount", %{account: account} = _ do
      changeset = %{account | tax_discount: nil} |> Account.changeset
      refute changeset.valid?
    end

    test "is invalid without a value", %{account: account} = _ do
      changeset = %{account | value: nil} |> Account.changeset
      refute changeset.valid?
    end

    test "is invalid without a discounted value", %{account: account} = _ do
      changeset = %{account | discounted_value: nil} |> Account.changeset
      refute changeset.valid?
    end

    test "is invalid without a portfolio", %{account: account} = _ do
      changeset = %{account | portfolio_id: nil} |> Account.changeset
      refute changeset.valid?
    end

    test "is invalid with an invalid portfolio", %{account: account} = _ do
      assert {:error, changeset} = %{account | portfolio_id: -1} |> Account.changeset |> Repo.insert
    end
  end
end
