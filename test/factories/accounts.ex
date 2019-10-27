defmodule Invest.Persistence.Factories.Accounts do
  defmacro __using__(_opts) do
    quote do
      def account_factory do
        %Invest.Persistence.Account{
          portfolio_id: insert(:portfolio).id,
          designation: Faker.Nato.letter_code_word,
          tax_discount: Faker.Random.Elixir.random_uniform,
          value: Faker.Random.Elixir.random_between(0, 1000),
          discounted_value: Faker.Random.Elixir.random_between(0, 1000)
        }
      end
    end
  end
end
