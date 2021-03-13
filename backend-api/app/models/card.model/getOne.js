const knex = require('../../helpers/database')
const { rowToCard } = require('./rowToCard')
const cardIdHasher = require('./cardIdHasher')
const { logger } = require('../../helpers/logger')
const moduleLogger = logger.child({ module: 'card.model' })

exports.getOne = async (templateSid, hashId=null) => {
    let result = [];

    const cardId = cardIdHasher.decode(hashId)[0];

    const query = knex
      .select('*')
      .from({prints:'mv_cards'})
      .where('template_sid', templateSid)
      .orderByRaw(`
        ${cardId ? `card_id  = ${cardId} DESC,` : ''}
        set_type_rank ASC,
        date_released DESC NULL LAST,
        finish_type_rank ASC,
        art_type_rank ASC
      `);

    await query
      .then(rows => { result = rowToCard(rows[0]); })
      .catch(err => { moduleLogger.error(err); throw err; });
    return result;
  }