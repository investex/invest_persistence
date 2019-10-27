defmodule Invest.Persistence.Repo do
  import Ecto.Query
  alias Invest.Persistence.Repo
  use Ecto.Repo,
    otp_app: :invest_persistence,
    adapter: Ecto.Adapters.Postgres

  # https://elixirforum.com/t/why-does-repo-get-and-repo-get-by-return-the-resource-or-nil-instead-of-an-ok-or-error-tuple/23089/24

  def fetch_one(queryable, opts \\ []) do
    case Repo.all(queryable, opts) do
      [one] -> {:ok, one}
      [] -> no_results_error(queryable)
      other -> multiple_results_error(queryable, length(other))
    end
  end

  def fetch(queryable, id, opts \\ []),
    do: fetch_one(query_for_fetch(queryable, id), opts)

  def fetch_by(queryable, clauses, opts \\ []),
    do: fetch_one(query_for_fetch_by(queryable, clauses), opts)

  defp assert_schema!(%{from: %{source: {_source, schema}}}) when schema != nil, do: schema

  defp assert_schema!(query) do
    raise Ecto.QueryError,
      query: query,
      message: "expected a from expression with a schema"
  end

  defp query_for_fetch(_queryable, nil) do
    raise ArgumentError, "cannot perform Repo.fetch/3 because the given value is nil"
  end

  defp query_for_fetch(queryable, id) do
    query = Ecto.Queryable.to_query(queryable)
    schema = assert_schema!(query)

    case schema.__schema__(:primary_key) do
      [pk] ->
        from(x in query, where: field(x, ^pk) == ^id)

      pks ->
        raise ArgumentError,
              "Repo.fetch/3 requires the schema #{inspect(schema)} " <>
                "to have exactly one primary key, got: #{inspect(pks)}"
    end
  end

  defp query_for_fetch_by(queryable, clauses),
    do: where(queryable, [], ^Enum.to_list(clauses))

  defp multiple_results_error(queryable, count) do
    info = Ecto.MultipleResultsError.exception(queryable: queryable, count: count)
    {:error, {info.__struct__, info.message}}
  end

  defp no_results_error(queryable) do
    info = Ecto.NoResultsError.exception(queryable: queryable)
    {:error, {info.__struct__, info.message}}
  end
end
