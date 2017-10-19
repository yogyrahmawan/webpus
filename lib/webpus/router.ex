defmodule Webpus.Router do 
  use Plug.Router 
  
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match 
  plug :dispatch

  get "/health_check" do 
    conn 
    |> send_resp(200, "healthy bro")
  end

  post "/broadcast" do 
    {status, body} = 
      case conn.body_params do 
        %{"topic" => topic, "message" => message} ->
          :gproc.send({:p, :l, topic}, {:publish, message})
          {200, "ok"}
        _ -> {422, "missing_format"}
      end 
    send_resp(conn, status, body)
  end

  match _ do 
    send_resp(conn, 404, "not found bro")
  end 
end
