use Mix.Config

config :coap_server, rpi: true
config :coap_server, led_list: [ :red, :green ]
config :nerves_io_led, names: [ red: "led0", green: "led1" ]