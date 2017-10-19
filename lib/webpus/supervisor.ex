defmodule Webpus.Supervisor do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  
  use Supervisor
  require Logger 
  
  def start_link do 
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do 
    
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Webpus.Router, [], [port: 4001, dispatch: dispatch()])
    ]
    Logger.info "websocketpubsub.supervisor started"
    
    Supervisor.init(children, strategy: :one_for_one)
  end 

  defp dispatch do 
    [
      {:_, [
        {"/ws", Webpus.WsHandler, []},
        {:_, Plug.Adapters.Cowboy.Handler, {Webpus.Router, []}}
      ]}
    ]
  end 

end
