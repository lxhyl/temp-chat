const webSocket = require("ws").Server
const wss  = new webSocket({port:5002})

wss.on('connection',ws => {
  ws.on('message',msg => {
    msg = msg.toString()
    console.log("msg",msg)
  })
  ws.send('hello')
})
