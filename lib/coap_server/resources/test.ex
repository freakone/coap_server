defmodule CoapServer.Resources.Test do
  use Coap.Resource

  def coap_get(_ch_id, prefix, _name, _query) do
    coap_content(payload: "HELLO")
  end

end
