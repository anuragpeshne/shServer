http = require 'http'
qs = require 'querystring'
parse = (require './parser.ls').parse
emulator = require './emulator.ls'

context = do ->
    pwd = '~'
    PATH = ''
    setPwd: (path) ->
        @pwd = path
    setPath: (path) ->
        @PATH = path

server = http.createServer (req, res) ->
    #TODO: get IP address of machine
    console.log req.connection.remoteAddress
    if (['::1', ''].indexOf req.connection.remoteAddress) > -1
        console.log req.connection.remoteAddress + ' connected'
        if req.method == 'POST'
            body = ''

            req.on 'data', (data) ->
                body += data

                # Too much POST data, kill the connection!
                # 1e6 === 1 * Math.pow(10, 6) === 1 * 1000000 ~~~ 1MB
                if body.length > 1e6
                    request.connection.destroy

            req.on 'end', (data) ->
                post = qs.parse body
                parsedScript = parse post['script']
                console.log parsedScript
                result = emulator.execute parsedScript
                res.writeHead 201
                res.setHeader 'Content-Type', 'application/json'
                res.end JSON.stringify result
        else
            res.writeHead 200
            res.end 'Hello World'
    else
        res.writeHead 403
        res.end 'Forbidden'

server.listen 8080
