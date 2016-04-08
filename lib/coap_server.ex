defmodule CoapServer do
  use Application

  def start(_type, port) do
    if Application.get_env(:coap_server, :rpi) do
      {:ok, _} = Ethernet.start_link interface: "eth0", hostname: "happy"
    end
    pid = CoapServer.Supervisor.start_link(port)
    CoapServer.Resources.Switch.start(["switches", "1"], [])
    pid
  end
end
