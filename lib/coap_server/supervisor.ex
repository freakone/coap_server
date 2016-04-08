defmodule CoapServer.Supervisor do
  use Supervisor

  @name CoapServer.Supervisor

  def start_link(port) do
    Supervisor.start_link(__MODULE__, port, name: @name)
  end

  def init(port) do
    children = [
      # supervisor(CoapServer.ServerSupervisor, [port]),
      worker(Coap.Storage, [[], []]),
      worker(Blinky, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
