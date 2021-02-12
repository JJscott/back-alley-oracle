const app = require('./app')
const http = require('http')
const { logger } = require('./app/helpers/logger');

const server = http.createServer(app)

// set port, listen for requests
const PORT = process.env.PORT;
server.listen(PORT, () => {
  logger.info(`API server started on port ${PORT}`);
});

module.exports = { app, server };