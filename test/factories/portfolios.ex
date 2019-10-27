defmodule Invest.Persistence.Factories.Portfolios do
  defmacro __using__(_opts) do
    quote do
      def portfolio_factory do
        %Invest.Persistence.Portfolio{
          user_id: insert(:user).id,
          name: Faker.Name.name,
          currency: "CAD",
          value: Faker.Random.Elixir.random_between(0, 1000),
          discounted_value: Faker.Random.Elixir.random_between(0, 1000)
        }
      end
    end
  end
end
