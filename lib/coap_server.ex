defmodule CoapServer do
  use Application
  alias Nerves.Networking

  @interface :eth0
  @networkopts mode: "static", address: "192.168.1.200", router: "192.168.1.1", mask: "255.255.255.0"

  def start(_type, port) do
    import Supervisor.Spec, warn: false

    apps =
      case :os.type do
        {:unix, :darwin} ->
          {:ok, _} = Networking.setup @interface, @networkopts
          [worker(Blinky, [])]
        _ ->
          [worker(Tester, [])]
      end

    opts = [strategy: :one_for_one]
    Supervisor.start_link(apps, opts)
    CoapServer.Supervisor.start_link(port)
  end
end
