defmodule CoapServer.Mixfile do
  use Mix.Project
  require Logger

  @default_port 5680

  def project do
    [app: :coap_server,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do

    apps = [:nerves, :logger, :nerves_lib, :gen_coap, :apex, :coap]

    if Application.get_env(:coap_server, :rpi) do
      apps = apps ++ [:ethernet, :nerves_io_led, :apex]
    end

    [
      applications: apps,
      mod: {CoapServer, port},
      env: [coap_port: port, registry_endpoint: 'coap://192.168.1.101:5683/registry_endpointry']
    ]
  end

  defp deps do
    [
      {:coap, git: "https://github.com/mskv/coap.git"},
      {:gen_coap, git: "https://github.com/gotthardp/gen_coap.git"},
      {:apex, "~>0.4.0"},
      {:nerves, "~> 0.2"},
      {:nerves_lib, github: "nerves-project/nerves_lib"},
      {:ethernet, github: "cellulose/ethernet"},
      {:nerves_io_led, github: "nerves-project/nerves_io_led"}
    ]
  end

  defp port do
    if port = System.get_env("COAP_PORT") do
      case Integer.parse(port) do
        {port, ""} -> port
        _ -> @default_port
      end
    else
      @default_port
    end
  end
end
