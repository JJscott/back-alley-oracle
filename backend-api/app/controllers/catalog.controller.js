const catalogModel = require('../models/catalog.model');
const {handleSuccess} = require('../helpers/response');


exports.getCardNames = async (req, res) => {
  const names = await catalogModel.findAllCardNames();
  catalog = {
    object: 'catalog',
    totalCount: names.length,
    data: names
  }
  handleSuccess(res, catalog);
}

exports.getCardClasses = async (req, res) => {
  const classes = await catalogModel.findAllCardClasses();
  catalog = {
    object: 'catalog',
    totalCount: classes.length,
    data: classes
  }
  handleSuccess(res, catalog);
}

exports.getCardTypes = async (req, res) => {
  const types = await catalogModel.findAllCardTypes();
  catalog = {
    object: 'catalog',
    totalCount: types.length,
    data: types
  }
  handleSuccess(res, catalog);
}

exports.getCardSubtypes = async (req, res) => {
  const subtypes = await catalogModel.findAllCardSubtypes();
  catalog = {
    object: 'catalog',
    totalCount: subtypes.length,
    data: subtypes
  }
  handleSuccess(res, catalog);
}

exports.getCardTypesAndSubtypes = async (req, res) => {
  const data = await catalogModel.findAllCardTypesAndSubtypes();
  tempData = {};
  data.forEach(({type, subtype}) => {
    if (!tempData.hasOwnProperty(type)) {
      tempData[type] = [];
    }
    if (subtype) {
      tempData[type].push(subtype);
    }
  });
  catalog = {
    object: 'catalog',
    totalCount: tempData.length,
    data: tempData
  }
  handleSuccess(res, catalog);
}

exports.getCardSpecializations = async (req, res) => {
  const specializations = await catalogModel.findAllCardSpecializations();
  catalog = {
    object: 'catalog',
    totalCount: specializations.length,
    data: specializations
  }
  handleSuccess(res, catalog);
}

exports.getCardKeywords = async (req, res) => {
  const keywords = await catalogModel.findAllCardKeywords();
  catalog = {
    object: 'catalog',
    totalCount: keywords.length,
    data: keywords
  }
  handleSuccess(res, catalog);
}

exports.getCardRarities = async (req, res) => {
  const rarities = await catalogModel.findAllCardRarities();
  catalog = {
    object: 'catalog',
    totalCount: rarities.length,
    data: rarities
  }
  handleSuccess(res, catalog);
}

exports.getCardArtTypes = async (req, res) => {
  const artTypes = await catalogModel.findAllCardArtTypes();
  catalog = {
    object: 'catalog',
    totalCount: artTypes.length,
    data: artTypes
  }
  handleSuccess(res, catalog);
}

exports.getCardFinishTypes = async (req, res) => {
  const finishTypes = await catalogModel.findAllCardFinishTypes();
  catalog = {
    object: 'catalog',
    totalCount: finishTypes.length,
    data: finishTypes
  }
  handleSuccess(res, catalog);
}