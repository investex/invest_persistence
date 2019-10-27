defmodule Invest.Persistence.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Invest.Persistence.Worker.start_link(arg)
      # {Invest.Persistence.Worker, arg}
      Invest.Persistence.Repo
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Invest.Persistence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
