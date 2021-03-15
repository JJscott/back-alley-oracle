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
      .then(rows => { result = (rows.length !== 0) ? rowToCard(rows[0]) : undefined; })
      .catch(err => { moduleLogger.error(err); throw err; });
    return result;
  }
  
  