const knex = require('../../helpers/database')
const { rowToCard } = require('./rowToCard')

exports.getOne = async (hashId) => {
    const cardId = cardIdHasher.decode(hashId)[0];
    console.log(hashId);
    console.log(cardId);
    let result = [];
  
    await knex
      .select('*')
      .from({prints:'mv_cards'})
      .where('card_id', cardId)
      .then(rows => {
        result = rowToCard(rows[0]);
      })
      .catch(err => {
        moduleLogger.error(err);
        throw err;
      });
    return result;
  }