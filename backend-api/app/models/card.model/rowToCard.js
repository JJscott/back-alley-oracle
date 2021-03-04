const cardIdHasher = require('./cardIdHasher')


const singleRowToCard = (row) => {
  let card = {};
  card.object = 'card';

  if (!(row)) return card;
  // card
  const hashId = cardIdHasher.encode(row.card_id);
  card.hash_id = hashId;
  // template
  card.template_sid = row.template_sid;
  card.name = row.name;
  if (row.pitch !== null) card.pitch = row.pitch;
  if (row.cost !== null) card.cost = row.cost;
  if (row.cost_var !== null) card.varCost = row.cost_var;
  if (row.power !== null) card.power = row.power;
  if (row.power_var !== null) card.power = row.power;
  if (row.defense !== null) card.defense = row.defense;
  if (row.defense_var !== null) card.defense = row.defense;
  if (row.intellect !== null) card.intellect = row.intellect;
  if (row.life !== null) card.life = row.life;
  if (row.handedness !== null) card.handedness = row.handedness;
  if (row.specialization !== null) card.specialization = row.specialization;
  card.legendary = row.legendary;
  card.class = row.class;
  card.type = row.type;
  card.subtypes = (row.subtypes_arr !== null) ? row.subtypes_arr : [];
  // face
  card.face_sid = row.face_sid;
  card.artist_name = row.artist_name;
  card.set_number = row.set_number;
  card.set_code = row.set_code;
  card.set_name = row.set_name;
  card.set_type = row.set_type_name;
  card.booster = row.booster;
  card.draftable = row.draftable;
  card.promo = row.promo;
  card.code = row.code;
  card.rules_text = row.rules_text;
  card.flavor_text = row.flavor_text;
  card.rarity_code = row.rarity_code;
  card.rarity_name = row.rarity_name;
  card.art_type_code = row.art_type_code;
  card.art_type_name = row.art_type_name;
  card.frame_style = row.frame_style;
  if (row.frame_color !== null) card.frame_color = row.frame_color;
  card.image_uris = {
    png: process.env.IMG_URL + 'raw/' + row.image_str + '.png',
    normal: process.env.IMG_URL + 'raw/' + row.image_str + '.png',
    small: process.env.IMG_URL + 'raw/' + row.image_str + '.png',
    thumb: process.env.IMG_URL + 'raw/' + row.image_str + '.png',
  };
  // print
  card.card_print_sid = row.card_print_sid;
  card.finish_type_code = row.finish_type_code;
  card.finish_type_name = row.finish_type_name;
  card.layout = row.layout;
  card.group_code = row.group_code;
  card.group_name = row.group_name;
  card.date_printed = row.date_printed;
  card.date_released = row.date_released;
  // ?? nzId ??
  // tcgPlayerId
  // cardMerchantId
  card.bao_uri = `${process.env.WEB_URL}cards/${hashId}`;
  return card;
}


exports.rowToCard = (row) => {
  return singleRowToCard(row);
}


exports.rowsToCycles = (rows) => {
  console.log("rows");
  console.log(rows);

  let tempCycleList = [];
  let cards = [];
  rows.forEach(row => {
    let card = this.rowToCard(row);
    if (cards.length > 0 && cards[0].name !== card.name) {
      // console.log(`pushing all cards ${cards.map(c => c.name)}`);
      tempCycleList.push(cards);
      cards = [];
    }
    // console.log(`push card into list ${card.name}`);
    cards.push(card);
  });
  tempCycleList.push(cards);

  console.log("cycles");
  console.log(tempCycleList);

  cycles = []
  tempCycleList.forEach(c => {
    cycles.push({
      object: 'cycle',
      name: c[0].name,
      count: c.length,
      bao_uri: `${process.env.WEB_URL}cycle?id=${c.map(x => x.hash_id).join('+')}`,
      cards: c
    });
  });
  return cycles;
}