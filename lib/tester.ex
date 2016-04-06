defmodule Tester do

  require Logger

  def start_link() do
    led_list = Application.get_env(:coap_server, :led_list)
    Logger.debug "you are running on regular os, log instead of led blinking"
    spawn fn -> blink_list_forever(led_list) end
    {:ok, self}
  end

  # call blink_led on each led in the list sequence, repeating forever
  defp blink_list_forever(led_list) do
    Enum.each(led_list, &blink(&1))
    blink_list_forever(led_list)
  end

  # given an led key, turn it on for 100ms then back off
  defp blink(led_key) do
    Logger.debug "blink #{led_key}"
    :timer.sleep 2000
  end

end
