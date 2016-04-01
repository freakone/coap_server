Run with:
```
COAP_PORT=XXXXX iex -S mix
```
Pick any free port other than 5683 - this one will be used by the [CoapDispatcher](https://github.com/mskv/coap_dispatcher) app. Elixir does not evaluate the value of the env variable every time it is run, but only once at compile time, so be sure to recompile the project after changing the COAP_PORT.

Register a resource with:
```
CoapServer.Resources.Switch.start(["switches", "1"], [{:rt, "light_switch"}])
```
which will create an endpoint coap://xxx.xxx.xxx.xxx:COAP_PORT/switches/1 with a query param rt=light_switch.

Be sure to run CoapDispatcher before registering a resource, otherwise the registration will fail.
