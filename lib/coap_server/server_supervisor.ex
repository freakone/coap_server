defmodule CoapServer.ServerSupervisor do
  require Logger
  def start_link(port) do
    Logger.debug "starting coap server"
    Supervisor.start_link(:coap_server, [port])
  end
end
