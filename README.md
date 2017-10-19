# Websocket Publisher and subscriber backed by gproc

### Library 
1. gproc 
2. plug and cowboy
3. poison 

### Installation
```
mix deps.get 
mix run --no-halt 
```
The server run at port 4001

### How to use 
1. run the server
2. go to client folder and open it . it will subscribe once client connected to the ws 
3. to subscribe, use the following format : `subscribe_yourtopic`
4. you can use http://endpoint:port/broadcast to broadcast . Request Body Format : `{"topic" : "testtopic", "message" : "halo"}`

### Todo 
There is so many things to do =))

