defmodule UserTest do
  use Persistence.RepoCase
  import Persistence.Factory
  alias Persistence.User

  describe "validations" do
    setup do
      [user: build(:user)]
    end

    test "has a valid factory", %{user: user} = _ do
      assert {:ok, _} = User.changeset(user) |> Repo.insert
    end

    test "is invalid without an email", %{user: user} = _ do
      changeset = %{user | email: nil} |> User.changeset
      refute changeset.valid?
    end

    test "is invalid without an encrypted password", %{user: user} = _ do
      changeset = %{user | password_hash: nil} |> User.changeset
      refute changeset.valid?
    end

    test "is invalid with a duplicate email", %{user: user} = _ do
      insert(:user, email: user.email)
      assert {:error, changeset} = User.changeset(user) |> Repo.insert
    end
  end
end
