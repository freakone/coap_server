defmodule CoapServer do
  use Application

  @interface :eth0

  def start(_type, port) do
    import Supervisor.Spec, warn: false


    apps =
      case :os.type do
        {:unix, :darwin} ->
          {:ok, _} = Networking.setup @interface
          [worker(Blinky, [])]
        _ ->
          [worker(Tester, [])]
      end

    opts = [strategy: :one_for_one]
    Supervisor.start_link(apps, opts)
    CoapServer.Supervisor.start_link(port)
  end
end
