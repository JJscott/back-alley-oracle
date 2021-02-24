// Update with your config settings.
require('dotenv').config();

module.exports = {

  development: {
    client: 'pg',
    connection: {
      host:     process.env.PSQL_HOST,
      user:     process.env.PSQL_USER,
      password: process.env.PSQL_PASSWORD,
      database: process.env.PSQL_DB,
      multipleStatements: true
    },
  },

  production: {
    client: 'pg',
    connection: {
      host:     process.env.PSQL_HOST,
      user:     process.env.PSQL_USER,
      password: process.env.PSQL_PASSWORD,
      database: process.env.PSQL_DB,
      multipleStatements: true
    }
  }
  
};
