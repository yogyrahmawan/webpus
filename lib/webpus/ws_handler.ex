defmodule Webpus.WsHandler do 
  @behaviour :cowboy_websocket_handler
  require Logger

  def init(_, _req, _opts) do 
    {:upgrade, :protocol, :cowboy_websocket}
  end 

  def websocket_init(_type, req, _opts) do 
    {:ok, req, %{}, 60000}
  end

  def websocket_handle({:text, "ping"}, req, state) do
    {:reply, {:text, "pong"}, req, state}
  end

  def websocket_handle({:text, "subscribe_" <> topic}, req, state) do  
    :gproc.reg({:p,:l,topic}) 
    {:ok, req, state} 
  end

  def websocket_handle({:text, "unsubscribe_" <> topic}, req, state) do 
    :gproc.unreg({:p,:l,topic})
    {:ok, req, state}
  end

  def websocket_info({:publish,message}, req, state) do  
    {:reply, {:text, message}, req, state}
  end

  def websocket_terminate(_reason, _req, _state) do
    :ok
  end
end 
