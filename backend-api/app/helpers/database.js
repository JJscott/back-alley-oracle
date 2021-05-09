const { development, production } = require('../../knexfile');
const knex = require('knex')(development);
const log = require('./logger').create('database.js');

// Confirm database has been setup correctly
knex.raw('SELECT 1').then(() => {
    log.info('Succesfully connected to database')
}).catch(err => {
    log.error('Could not connect to database')
});

module.exports = knex;