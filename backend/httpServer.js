const http = require('http')

const App = http.createServer()

App.on('request',function(req,res){
  res.end(JSON.stringify({code:200,msg:'success'}))
})

App.listen(5001)