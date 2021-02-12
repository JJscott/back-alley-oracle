const fs = require('fs');
const path = require('path');

exports.seed = function(knex) {
    const sql0 = fs.readFileSync(path.join(__dirname, './raw_sql/tempCardSetsAndGroups.sql')).toString();
    const sql1 = fs.readFileSync(path.join(__dirname, './raw_sql/tempCardTemplates.sql')).toString();
    const sql2 = fs.readFileSync(path.join(__dirname, './raw_sql/tempCardFaces.sql')).toString();
    const sql3 = fs.readFileSync(path.join(__dirname, './raw_sql/tempCardPrints.sql')).toString();
    const sql4 = fs.readFileSync(path.join(__dirname, './raw_sql/loadTempTables.sql')).toString();
    return knex.raw(sql0)
      .then(() => { return knex.raw(sql1); })
      .then(() => { return knex.raw(sql2); })
      .then(() => { return knex.raw(sql3); })
      .then(() => { return knex.raw(sql4); })
};
