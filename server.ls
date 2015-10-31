http = require 'http'

context = do ->
    'pwd': '~'
    'PATH': ''
    setPwd: (path) ->
        @pwd = path
    setPath: (path) ->
        @PATH = path

server = http.createServer (req, res) ->
    #todo: get IP address of machine
    console.log req.connection.remoteAddress
    if ['::1', ''].indexOf(req.connection.remoteAddress) != -1
      console.log req.connection.remoteAddress
      console.log context.pwd
      res.writeHead 200
      res.end 'Hello World'
    else
      res.writeHead 403
      res.end 'Forbidden'

server.listen 8080
