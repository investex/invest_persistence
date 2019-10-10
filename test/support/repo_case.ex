defmodule Persistence.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Persistence.Repo

      import Ecto
      import Ecto.Query
      import Persistence.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Persistence.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Persistence.Repo, {:shared, self()})
    end

    :ok
  end
end
