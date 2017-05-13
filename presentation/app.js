"use strict";
require('use-strict')
const express = require('express');
const path = require('path');
const revealRunInTerminal = require('../reveal-run-in-terminal/index.js');

var fs        = require('fs');
var io        = require('socket.io');
var Mustache  = require('mustache');
var http      = require('http');

var config = require('config');
var app       = express();
var staticDir = express.static;
var server    = http.createServer(app);

io = io(server);

let revealRunInTerminalPlugin = path.resolve(__dirname, '../reveal-run-in-terminal/static');
let revealJsPath = path.resolve(__dirname, '../reveal.js');



app.set('views', __dirname + '/views')
app.set('view engine', 'jade')

app.use(revealRunInTerminal({
  publicPath: __dirname,
  commandRegex: /coffee/,
  log: true,
  allowRemote: true
}));

io.on( 'connection', function( socket ) {

	socket.on( 'new-subscriber', function( data ) {
		socket.broadcast.emit( 'new-subscriber', data );
	});

	socket.on( 'statechanged', function( data ) {
	  console.log(data)
		delete data.state.overview;
		socket.broadcast.emit( 'statechanged', data );
	});

	socket.on( 'statechanged-speaker', function( data ) {
	   console.log(data)
		delete data.state.overview;
		socket.broadcast.emit( 'statechanged-speaker', data );
	});

});

app.get('/', function (req, res) {
  res.render('index',{Ip:"127.0.0.1",Port:5001});
})

app.get( '/notes/:socketId', function( req, res ) {
 	fs.readFile( revealJsPath + '/plugin/notes-server/notes.html', function( err, data ) {
		res.send( Mustache.to_html( data.toString(), {
			socketId : req.params.socketId
		}));
	});

});

app.use(express.static(revealRunInTerminalPlugin));
app.use(express.static(revealJsPath));
app.use(express.static(path.resolve(__dirname, 'public/resources')))

server.listen(config.Server.Port,config.Server.Ip);
//app.listen(5000,"localhost");


