const app = require('./app')
const http = require('http')

const log = require('./app/helpers/logger').create('index.js');

const server = http.createServer(app)

// set port, listen for requests
const PORT = process.env.PORT;
server.listen(PORT, () => {
  log.info(`API server started on port ${PORT}`);
});

module.exports = { app, server };