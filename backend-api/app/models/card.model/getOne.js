const knex = require('../../helpers/database')
const { rowToCard } = require('./rowToCard')
const cardIdHasher = require('./cardIdHasher')
const { logger } = require('../../helpers/logger')
const moduleLogger = logger.child({ module: 'card.model' })

exports.getOne = async (templateSid, hashId=null) => {
    let result = [];

    const cardId = cardIdHasher.decode(hashId)[0];
    const cardIdOrder = cardId ? `card_id = ${cardId} DESC,` : '';

    const query = knex
      .select('*')
      .from({prints:'mv_cards'})
      .where('template_sid', 'like', templateSid)
      .orderByRaw(`
        ${cardIdOrder}
        set_type_rank ASC,
        date_released DESC,
        finish_type_rank ASC,
        art_type_rank ASC
      `);

    await query
      .then(rows => {result = (rows.length !== 0) ? rowToCard(rows[0]) : undefined; })
      .catch(err => { moduleLogger.error(err); throw err; });

    return result;
  }