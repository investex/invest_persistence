defmodule Persistence.Factories.Users do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Persistence.User{
          email: Faker.Internet.email(),
          password_hash: Faker.String.base64()
        }
      end
    end
  end
end
