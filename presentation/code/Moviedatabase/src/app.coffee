express = require 'express'
path = require 'path'
config = require 'config'
app = express()

jsFiles = path.resolve __dirname, '../resources/js/dist'

app.use express.static jsFiles
app.use express.static __dirname
app.listen config.Server.Port,config.Server.Ip