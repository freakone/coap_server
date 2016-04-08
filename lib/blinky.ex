defmodule Blinky do

  @moduledoc """
  Simple example to blink a list of LEDs forever.

  The list of LEDs is platform-dependent, and defined in the config
  directory (see config.exs).   See README.md for build instructions.
  """

  alias Nerves.IO.Led
  require Logger

  def start_link() do
    led_list = Application.get_env(:coap_server, :led_list)
    Logger.debug "list of leds to blink is #{inspect led_list}"
    spawn fn -> blink_list_forever(led_list, 0) end
    {:ok, self}
  end

  # call blink_led on each led in the list sequence, repeating forever
  defp blink_list_forever(led_list, num) do
    Enum.each(led_list, &blink(&1))
    blink_list_forever(led_list, num+1)
  end

  # given an led key, turn it on for 100ms then back off
  defp blink(led_key) do
    if Application.get_env(:coap_server, :rpi) do
      Led.set [{led_key, true}]
      :timer.sleep 200
      Led.set [{led_key, false}]
    else
      Logger.debug "blink"
      :timer.sleep 1000
    end

  end

end
