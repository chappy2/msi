# Simple Webserver serving files static in public folder
express = require 'express'
path = require 'path'
config = require 'config'
app = express()

clientApp = path.resolve __dirname, '../public/dist'
sourcemapNeedsCoffeeFile = path.resolve __dirname, '../public/src'
exposeDocumentation = path.resolve __dirname, '../docs'
customDepend = path.resolve __dirname, './../public/dependencies/jquery-ui-1.12.1.custom'
bowerDepend = path.resolve __dirname, './../public/dependencies/bower_components'

app.use '/public/dist/',(express.static clientApp)
app.use express.static exposeDocumentation
app.use '/public/src/',(express.static sourcemapNeedsCoffeeFile)
app.use express.static customDepend
app.use express.static bowerDepend
app.use express.static __dirname


#app.listen 5001,"localhost"
app.listen config.Server.Port,config.Server.Ip