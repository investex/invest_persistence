defmodule Invest.Persistence.Factories.AssetCategories do
  defmacro __using__(_opts) do
    quote do
      def asset_category_factory do
        %Invest.Persistence.AssetCategory{
          portfolio_id: insert(:portfolio).id,
          name: Faker.Industry.industry,
          target_percentage: Faker.Random.Elixir.random_uniform,
          actual_percentage: Faker.Random.Elixir.random_uniform,
          difference: Faker.Random.Elixir.random_between(0, 1000)
        }
      end
    end
  end
end
