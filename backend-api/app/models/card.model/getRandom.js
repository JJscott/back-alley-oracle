const knex = require('../../helpers/database')
const { rowToCard } = require('./rowToCard')

exports.getRandom = async () => {
    let result = [];
    await knex
      .select('*')
      .from('mv_cards')
      .orderByRaw('random()')
      .limit(1)
      .then(rows => {
        result = rowToCard(rows[0]);
      })
      .catch(err => {
        moduleLogger.error(err);
        throw err;
      });
    return result;
  }
  
  