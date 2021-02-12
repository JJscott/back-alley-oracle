const Hashids = require('hashids/cjs')
const queryParser = require('../helpers/queryParser');
const cardModel = require('../models/card.model');
const { logger } = require('../helpers/logger');
const moduleLogger = logger.child({ module: 'card.controller' });
const {
  handleSuccess,
  handleInvalidRequest,
  handleNotFound
} = require('../helpers/response');


const cardPrintIdHasher = new Hashids('floris', 8);


const rowToCard = row => {
  const hashId = cardPrintIdHasher.encode(row.printId);

  let card = {};

  // card
  card.id = hashId;
  card.object = 'card';

  // template
  card.templateSid = row.templateSid;
  card.name = row.name;
  if (row.pitch !== null) card.pitch = row.pitch;
  if (row.cost !== null) card.cost = row.cost;
  if (row.varCost !== null) card.varCost = row.varCost;
  if (row.power !== null) card.power = row.power;
  if (row.defense !== null) card.defense = row.defense;
  if (row.intellect !== null) card.intellect = row.intellect;
  if (row.life !== null) card.life = row.life;
  if (row.handedness !== null) card.handedness = row.handedness;
  if (row.specialization !== null) card.specialization = row.specialization;
  card.legendary = row.legendary;
  card.class = row.class;
  card.type = row.type;
  card.subtypes = (row.subtypes_csv !== null) ? row.subtypes_csv.split(',') : [];
  card.keywords = (row.keywords_csv !== null) ? row.keywords_csv.split(',') : [];

  // face
  card.faceSid = row.faceSid;
  card.artistName = row.artistName;
  card.setNumber = row.setNumber;
  card.setCode = row.setCode;
  card.setName = row.setName;
  card.setType = row.setTypeName;
  card.booster = row.booster;
  card.draftable = row.draftable;
  card.promo = row.promo;
  card.code = row.code;
  card.rulesText = row.rulesText;
  card.flavorText = row.flavorText;
  card.rarityCode = row.rarityCode;
  card.rarityName = row.rarityName;
  card.artTypeCode = row.artTypeCode;
  card.artTypeName = row.artTypeName;
  card.frameStyle = row.frameStyle;
  if (row.frameAltColor !== null) card.frameAltColor = row.frameAltColor;
  card.imageUris = {
    png: process.env.IMG_URL + 'png/' + row.imageStr + '.png',
    normal: process.env.IMG_URL + 'normal/' + row.imageStr + '.jpg',
    small: process.env.IMG_URL + 'small/' + row.imageStr + '.jpg',
    thumb: process.env.IMG_URL + 'thumb/' + row.imageStr + '.jpg',
  };

  // print
  card.cardPrintSid = row.cardPrintSid;
  card.finishTypeCode = row.finishTypeCode;
  card.finishTypeName = row.finishTypeName;
  card.layout = row.layout;
  card.groupCode = row.groupCode;
  card.groupName = row.groupName;
  card.datePrinted = row.datePrinted;
  card.dateReleased = row.dateReleased;
  // ?? nzId ??
  // tcgPlayerId
  // cardMerchantId

  card.squireUri = `${process.env.WEB_URL}cards/${hashId}`;

  // if (row.pitch !== null)
  // card.printsUri = `${process.env.API_URL}cards/search?q=name:"${row.name}"%20${}`;

  return card;
};


// Parse query
const searchAliases = {
  p: 'pitch',
  co: 'cost',
  p: 'power',
  d: 'defense',
  l: 'life',
  i: 'intellect',
  h: 'handedness',
  c: 'class',
  sp: 'specialization',
  t: 'type',
  st: 'subtype',
  kw: 'keyword',
  rt: 'rulesText',
  ft: 'flavorText'
};


// Validate query
const validNumericOp = new Set(['=','!=','<','<=','>','>=']);
const validStringOp = new Set([':','!:']);
const validateParseQuery = (queryString) => {

  const queryValues = queryParser.parse(queryString, searchAliases);
  const warnings = [];
  const queryList = [];

  // iterate through the combinations of key op and value
  for (const [key, opValue] of Object.entries(queryValues)) {    
    for (const [op, value] of Object.entries(opValue)) {
      console.log(`key= ${key}, op= '${op}', value= ${value}`);

      switch (key) {
        // numeric
        case 'pitch':
        case 'cost':
        case 'power':
        case 'defense':
        case 'life':
        case 'intellect':
        case 'handedness':
          let intValue;
          if (!validNumericOp.has(op)) {
            warnings.push(`Invalid operator '${op}' for key '${key}'`);
            break;
          }
          if (Array.isArray(value)) {      
            intValue = value.map(parseInt);
            if (intValue.some(isNaN)) {
              warnings.push(`Invalid integer values ${value} for key '${key}' and operator '${op}'`);
              break;
            }
          }
          else {
            intValue = parseInt(value);
            if (isNaN(intValue)) {
              warnings.push(`Invalid integer value '${value}' for key '${key}' and operator '${op}'`);
              break;
            }
          }
          queryList.push({key: key, op: op, value: value})
          break;

        // string
        case 'class':
        case 'specialization':
        case 'type':
        case 'subtype':
        case 'keyword':
          if (!validStringOp.has(op)) {
            warnings.push(`Invalid operator '${op}' for key '${key}'`);
            break;
          }
          queryList.push({key: key, op: op, value: value})
          break;

        // name
        case 'name':
        case 'rulesText':
        case 'flavorText':
          if (op !== ':') {
            warnings.push(`Invalid operator '${op}' for key '${key}'`);
          }
          queryList.push({key: key, op: op, value: value})
          break;

        // catch-all
        default:
          warnings.push(`Unknown key '${key}'`);
      }
    }
  }

  return {
    queryList: queryList,
    warnings: warnings
  };
};



// Find a single Card with id
exports.getOne = async (req, res) => {

  if (!req.params.hasOwnProperty('cardId')) {
    return handleInvalidRequest(res, `Missing query parameter 'cardId'`);
  }

  // const id = req.params.cardId;
  const id = cardPrintIdHasher.decode(req.params.cardId);

  const searchOptions = {
    printId: id
  };

  // TODO, handle no result
  const row = await cardModel.getOne({ searchOptions });

  if (row === undefined || row.length == 0) {
    return handleNotFound(res, `No card with id: ${id} found`)
  }

  const card = rowToCard(row);
  return handleSuccess(res, card);
};



exports.getRandom = async (req, res) => {
  // TODO validate?

  const row = await cardModel.getRandom();

  if (row === undefined || row.length == 0) {
    return handleNotFound(res, `No card found`)
  }

  const card = rowToCard(row);
  return handleSuccess(res, card);
};



exports.search = async (req, res) => {
  // TODO validate?
  if (!req.query.hasOwnProperty('q')) {
    return handleInvalidRequest('Request is missing query parameters');
  }

  // query
  // 
  const queryString = req.query.q;
  const {queryList, warnings} = validateParseQuery(queryString);

  // query page number
  // 
  let pageNumber = 1;
  if (req.query.hasOwnProperty('page')) {
    let tempPage = parseInt(req.query.page);
    if (!isNaN(tempPage)) {
      if (tempPage >= 1) {
        pageNumber = tempPage;
      } else {
        warnings.push(`Invalid page number '${tempPage}' - must greater than or equal to 1`);
      }
    } else {
      warnings.push(`Invalid page number '${req.query.page}'`);
    }
  }

  // query page size
  // 
  let pageLimit = 60;
  if (req.query.hasOwnProperty('limit')) {
    let tempLimit = parseInt(req.query.limit);
    if (!isNaN(tempLimit)) {
      if (tempLimit >= 1 && tempLimit <= 120) {
        pageLimit = tempLimit;
      } else {
        warnings.push(`Invalid page limit '${tempLimit}' - must be between 1 and 120`);
      }
    } else {
      warnings.push(`Invalid page limit '${req.query.limit}'`);
    }
  }

  // order
  // 
  let sortClauses = [];
  if (req.query.hasOwnProperty('sort')) {
    // force inputs to be arrays
    let tempSortValues = Array.isArray(req.query.sort) ? req.query.sort : [req.query.sort];
    let tempSortOrder = [];
    if (req.query.hasOwnProperty('order')) {
      tempSortOrder = Array.isArray(req.query.order) ? req.query.order : [req.query.order];
    }

    // pair each sort value with a sort order
    for (let i = 0; i < tempSortValues.length; i++) {
      sortValue = tempSortValues[i].toLowerCase();
      orderValue = (i < tempSortOrder.length) ? tempSortOrder[i].toLowerCase() : 'ascending';
      switch(sortValue) {
        case 'name':
        case 'pitch':
        case 'cost':
        case 'power':
        case 'defense':
        case 'life':
        case 'intellect':
        case 'handedness':
        case 'class':
        case 'type':
        case 'subtype':
        case 'specialization':
          if (orderValue === 'ascending') {
            sortClauses.push(`${sortValue} ASC`);
          } else if (orderValue === 'descending') {
            sortClauses.push(`${sortValue} DESC`);
          } else {
            warnings.push(`Invalid sorting order '${orderValue}' for sorting value '${sortValue}'`);
          }
          break;
        default:
          warnings.push(`Invalid sorting value '${sortValue}'`);
      }
    }
  }
  sortClauses.push(`templateSid ASC`); // default and final sort value


  // uniqueness
  //
  let unique = 'templateId'
  if (req.query.hasOwnProperty('unique')) {
    uniqueValue = req.query.unique.toLowerCase();
    switch(uniqueValue) {
      case 'templateid':
      case 'printid':
        unique = uniqueValue;
        break;
      default:
        warnings.push(`Invalid unique value '${uniqueValue}'`);
    }
  }


  // fetch main card data
  //
  const {totalCount, rows} = await cardModel.findAll({
    searchOptions: queryList,
    pageOptions: {page: pageNumber, limit: pageLimit},
    orderBy: sortClauses,
    unique: unique
  });

  cards = rows.map(row => rowToCard(row));

  // TODO fetch backfaces


  // return
  // 
  const cardList = {
    object: 'list',
    totalCount: totalCount,
    hasMore: (totalCount > pageNumber * pageLimit),
    warnings: warnings,
    data: cards
  };

  return handleSuccess(res, cardList);
};