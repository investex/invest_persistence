defmodule Persistence.Factories.Securities do
  defmacro __using__(_opts) do
    quote do
      def security_factory do
        %Persistence.Security{
          ticker: Faker.Finance.Stock.ticker,
          currency: "CAD",
          price: Faker.Random.Elixir.random_between(0, 1000)
        }
      end
    end
  end
end
