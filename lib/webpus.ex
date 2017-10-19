defmodule Webpus do
  use Application 

  def start(_type, _args) do
    Webpus.Supervisor.start_link
  end
end
