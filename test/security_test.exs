defmodule SecurityTest do
  use Persistence.RepoCase
  import Persistence.Factory
  alias Persistence.Security

  describe "validations" do
    setup do
      [security: build(:security)]
    end

    test "has a valid factory", %{security: security} = _ do
      assert {:ok, _} = Security.changeset(security) |> Repo.insert
    end

    test "is invalid without a ticker", %{security: security} = _ do
      changeset = %{security | ticker: nil} |> Security.changeset
      refute changeset.valid?
    end

    test "is invalid without a currency", %{security: security} = _ do
      changeset = %{security | currency: nil} |> Security.changeset
      refute changeset.valid?
    end

    test "is invalid without a price", %{security: security} = _ do
      changeset = %{security | price: nil} |> Security.changeset
      refute changeset.valid?
    end
  end
end
