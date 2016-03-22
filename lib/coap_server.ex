defmodule CoapServer do
  use Application

  def start(_type, port) do
    CoapServer.Supervisor.start_link(port)
  end
end
