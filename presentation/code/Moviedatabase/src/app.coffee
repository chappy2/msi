express = require 'express'
path = require 'path'
config = require 'config'
app = express()

#jsFiles = path.resolve __dirname, '../resources/js/dist'
dependencies = path.resolve __dirname, './../resources/dependencies/jquery-ui-1.12.1.custom'

#app.use express.static jsFiles
app.use express.static dependencies
app.use express.static __dirname
app.listen config.Server.Port,config.Server.Ip