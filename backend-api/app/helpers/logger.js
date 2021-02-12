require('dotenv').config();
const bunyan = require('bunyan');
const packageJson = require('../../package.json');

const logger = bunyan.createLogger({
  name: 'Floris API',
  version: packageJson.version,
  streams: [{
    stream: process.stdout,
    level: process.env.NODE_ENV === 'development' ? bunyan.TRACE : bunyan.FATAL
  }]
});
logger.info({ NODE_ENV: process.env.NODE_ENV }, 'API logger loaded');

module.exports = { bunyan, logger };
