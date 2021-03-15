
const queryParser = require('../helpers/queryParser');
const cardModel = require('../models/card.model');
const { logger } = require('../helpers/logger');
const moduleLogger = logger.child({ module: 'card.controller' });
const {
  handleSuccess,
  handleInvalidRequest,
  handleNotFound,
  handleInternalError
} = require('../helpers/response');



// Parse query
const searchAliases = {
  x: 'pitch',
  r: 'cost',
  p: 'power',
  d: 'defense',
  l: 'life',
  i: 'intellect',
  h: 'handedness',
  c: 'class',
  s: 'specialization',
  t: 'type',
  u: 'subtype',
  k: 'keyword',
  o: 'rules_text',
  f: 'flavor_text'
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
        case 'rules_text':
        case 'flavor_text':
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

  if (!req.params.hasOwnProperty('templateSid')) {
    return handleInvalidRequest(res, `Missing query parameter 'templateSid'`);
  }

  const templateSid = req.params.templateSid;

  try {
    const card = await cardModel.getOne(templateSid, req.query.id)
    if (card === undefined || card.length == 0) {
      return handleNotFound(res, `No card with templateSid: ${templateSid} found`)
    }
    return handleSuccess(res, card);
  }
  catch(err) {
    return handleInternalError(res, `Internal error while processing templateSid: ${templateSid} and id: ${req.query.id}` );
  }
};



exports.getRandom = async (req, res) => {
  try {
    const card = await cardModel.getRandom();
    if (card === undefined || card.length == 0) {
      return handleNotFound(res, `No card found`)
    }
    return handleSuccess(res, card);
  }
  catch(err) {
    return handleInternalError(res, `Internal error while processing random card` );
  }
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

  // // order
  // // 
  // let sortClauses = [];
  // if (req.query.hasOwnProperty('sort')) {
  //   // force inputs to be arrays
  //   let tempSortValues = Array.isArray(req.query.sort) ? req.query.sort : [req.query.sort];
  //   let tempSortOrder = [];
  //   if (req.query.hasOwnProperty('order')) {
  //     tempSortOrder = Array.isArray(req.query.order) ? req.query.order : [req.query.order];
  //   }

  //   // pair each sort value with a sort order
  //   for (let i = 0; i < tempSortValues.length; i++) {
  //     sortValue = tempSortValues[i].toLowerCase();
  //     orderValue = (i < tempSortOrder.length) ? tempSortOrder[i].toLowerCase() : 'ascending';
  //     switch(sortValue) {
  //       case 'name':
  //       case 'pitch':
  //       case 'cost':
  //       case 'power':
  //       case 'defense':
  //       case 'life':
  //       case 'intellect':
  //       case 'handedness':
  //       case 'class':
  //       case 'type':
  //       case 'subtype':
  //       case 'specialization':
  //         if (orderValue === 'ascending') {
  //           sortClauses.push(`${sortValue} ASC`);
  //         } else if (orderValue === 'descending') {
  //           sortClauses.push(`${sortValue} DESC`);
  //         } else {
  //           warnings.push(`Invalid sorting order '${orderValue}' for sorting value '${sortValue}'`);
  //         }
  //         break;
  //       default:
  //         warnings.push(`Invalid sorting value '${sortValue}'`);
  //     }
  //   }
  // }
  // sortClauses.push(`templateSid ASC`); // default and final sort value


  // uniqueness
  //
  let unique = 'cards'
  if (req.query.hasOwnProperty('unique')) {
    uniqueValue = req.query.unique.toLowerCase();
    switch(uniqueValue) {
      case 'prints':
      case 'cards':
      case 'cycles':
      // case 'art':
        unique = uniqueValue;
        break;
      default:
        warnings.push(`Invalid unique value '${uniqueValue}'`);
    }
  }

  try {
    // fetch main card data
    //
    const {totalCount, rows} = await cardModel.findAll({
        searchOptions: queryList,
        pageOptions: {page: pageNumber, limit: pageLimit},
        // orderBy: sortClauses,
        unique: unique
      });

    // return
    // 
    const cardList = {
      object: 'list',
      total_count: totalCount,
      // hasMore: (totalCount > pageNumber * pageLimit),
      warnings: warnings,
      data: rows
    };

    return handleSuccess(res, cardList);
  }
  catch (err) {
    return handleInternalError(res, `Internal error while processing card search query` );
  };
};