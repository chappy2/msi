express = require 'express'
path = require 'path'
config = require 'config'
app = express()

clientApp = path.resolve __dirname, '../public/dist'
dependencies = path.resolve __dirname, './../public/dependencies/jquery-ui-1.12.1.custom'

app.use express.static clientApp
app.use express.static dependencies
app.use express.static __dirname
app.listen config.Server.Port,config.Server.Ip