defmodule Persistence.MixProject do
  use Mix.Project

  def project do
    [
      app: :persistence,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Persistence.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:ex_machina, "~> 2.3", only: :test},
      {:faker, "~> 0.13", only: :test}
    ]
  end

  # This makes sure your factory and any other modules in test/support are compiled
  # when in the test environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/factories"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
