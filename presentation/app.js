"use strict";
const express = require('express');
const path = require('path');
const revealRunInTerminal = require('../reveal-run-in-terminal/index.js');
var config = require('config');
let app = express();

app.use(revealRunInTerminal({
  publicPath: __dirname,
  commandRegex: /node/,
  log: true,
  allowRemote: true
}));

let revealRunInTerminalPlugin = path.resolve(__dirname, '../reveal-run-in-terminal/static');
let revealJsPath = path.resolve(__dirname, '../reveal.js');
app.use(express.static(revealRunInTerminalPlugin));
app.use(express.static(revealJsPath));

app.listen(config.Server.Port,config.Server.Ip);
