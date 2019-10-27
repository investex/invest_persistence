defmodule Invest.Persistence.Factories.Holdings do
  defmacro __using__(_opts) do
    quote do
      def holding_factory do
        %Invest.Persistence.Holding{
          account_id: insert(:account).id,
          security_id: insert(:security).id,
          currency: "CAD",
          quantity: Faker.Random.Elixir.random_between(0, 1000),
          value: Faker.Random.Elixir.random_between(0, 1000)
        }
      end
    end
  end
end
