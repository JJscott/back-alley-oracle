const knex = require('../../helpers/database')
const { rowToCard } = require('./rowToCard')
const { logger } = require('../../helpers/logger')
const moduleLogger = logger.child({ module: 'card.model' })

exports.getRandom = async () => {
    let result = [];
    await knex
      .select('*')
      .from('mv_cards')
      .orderByRaw('random()')
      .limit(1)
      .then(rows => { result = rowToCard(rows[0]); })
      .catch(err => { moduleLogger.error(err); throw err; });
    return result;
  }
  
  