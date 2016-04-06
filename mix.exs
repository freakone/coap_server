defmodule CoapServer.Mixfile do
  use Mix.Project

  @default_port 5683

  def project do
    [app: :coap_server,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do

    apps = [:nerves, :logger, :nerves_lib, :nerves_io_led]

    if :os.type == {:unix, :darwin} do
      apps = apps ++ [:nerves_networking]
    end

    [
      applications: apps,
      mod: {CoapServer, port},
      env: [coap_port: port, registry_endpoint: 'coap://51.255.50.48:5683/registry']
    ]
  end

  defp deps do
    [
      {:gen_coap, git: "https://github.com/gotthardp/gen_coap.git"},
      {:coap, git: "https://github.com/mskv/coap.git"},
      {:apex, "~>0.4.0"},
      {:nerves, "~> 0.2"},
      {:nerves_lib, github: "nerves-project/nerves_lib"},
      {:nerves_networking, github: "nerves-project/nerves_networking", tag: "v0.6.0"},
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
