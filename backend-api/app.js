require('dotenv').config()
const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const bunyanMiddleware = require('bunyan-middleware');
const { logger } = require('./app/helpers/logger');


// create application to serve from express
const app = express();


// Middleware
// 

// app.use(express.static('build')); // static frontend
app.use(cors());
app.use(
  bunyanMiddleware({
    headerName: 'X-Request-Id',
    propertyName: 'reqId',
    logName: 'reqId',
    obscureHeaders: ['authorization'],
    logger,
    additionalRequestFinishData: (_req, _res) => { return {}; }
  })
);
// parse requests of content-type - application/json
// and application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json()); 


// serve static files in the public directory
app.use(express.static('public'))


// include routes
app.get('/', (_req, res) => {
  res.status(200).send({ success: true, status: 200, message: 'Welcome to Floris.', data: {} });
});

// All registered routes
require("./app/routes")(app);

// catch-all for non
app.get('*', (_req, res) => {
  res.status(400).send({ success: false, status: 404, message: 'Page not found.', data: {} });
});


module.exports = app