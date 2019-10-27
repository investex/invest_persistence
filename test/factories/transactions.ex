defmodule Invest.Persistence.Factories.Transactions do
  defmacro __using__(_opts) do
    quote do
      def transaction_factory do
        %Invest.Persistence.Transaction{
          account_id: insert(:account).id,
          security_id: insert(:security).id,
          classification: Faker.Pizza.topping,
          quantity: Faker.Random.Elixir.random_between(0, 1000),
          price: Faker.Random.Elixir.random_between(0, 1000),
          commission: Faker.Random.Elixir.random_between(0, 1000),
          settlement_date: Faker.Date.forward(2)
        }
      end
    end
  end
end
