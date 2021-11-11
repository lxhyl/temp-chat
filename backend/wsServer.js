const webSocket = require("ws").Server
const wss = new webSocket({ port: 5002 })


wss.on('connection', ws => {
  ws.on('message', msg => {
    msg = msg.toString()
    try {
      msg = JSON.parse(msg)
      console.log('msg',msg)
      if (msg.type === 'connect') {
        ws.roomid = msg.roomid
        return
      }
      if (msg.type === 'text') {
        wss.clients.forEach(client => {
          if (client.roomid === msg.roomid) {
            client.send(JSON.stringify(msg))
          }
        })
      }
    } catch {

    }
  })
})
