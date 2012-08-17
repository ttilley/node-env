http = require "http"
host = process.env.VCAP_APP_HOST or "127.0.0.1"
port = process.env.VCAP_APP_PORT or 1337

http.createServer((req, res) ->
  res.writeHead 200, "Content-Type": "text/html"

  res.write "<title>Stackato environment variables</title>"
  res.write "<h1>Stackato environment variables</h1><hr/>"
  res.write "<table>"

  env_keys = []
  for key of process.env
    env_keys.push key
  env_keys.sort()

  for env in env_keys
    res.write """
              <tr>
                <td style="border-style: solid; 
                           border-color: #034569;
                           background-color: #9FB6C3;
                           text-align: right;
                           vertical-align: top;
                           padding: 4px 1em;">
                  <b>#{env}</b>
                </td>
                <td>
                  <tt style="padding-left: 4px">#{process.env[env]}</tt>
                </td>
              </tr>
              """

  res.write "</table>"
  res.end()
).listen port, host

console.log "Server running at " + host + ":" + port
