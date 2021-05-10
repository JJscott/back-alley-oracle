const catalogModel = require('../models/catalog.model');
const {handleSuccess} = require('../helpers/response');


exports.getCardNames = async (req, res) => {
  const names = await catalogModel.findAllCardNames();
  catalog = {
    object: 'catalog',
    total_count: names.length,
    data: names
  }
  handleSuccess(res, catalog);
}

exports.getCardClasses = async (req, res) => {
  const classes = await catalogModel.findAllCardClasses();
  catalog = {
    object: 'catalog',
    total_count: classes.length,
    data: classes
  }
  handleSuccess(res, catalog);
}

exports.getCardTypes = async (req, res) => {
  const types = await catalogModel.findAllCardTypes();
  catalog = {
    object: 'catalog',
    total_count: types.length,
    data: types
  }
  handleSuccess(res, catalog);
}

exports.getCardSubtypes = async (req, res) => {
  const subtypes = await catalogModel.findAllCardSubtypes();
  catalog = {
    object: 'catalog',
    total_count: subtypes.length,
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
    total_count: tempData.length,
    data: tempData
  }
  handleSuccess(res, catalog);
}

exports.getCardSpecializations = async (req, res) => {
  const specializations = await catalogModel.findAllCardSpecializations();
  catalog = {
    object: 'catalog',
    total_count: specializations.length,
    data: specializations
  }
  handleSuccess(res, catalog);
}

exports.getCardKeywords = async (req, res) => {
  const keywords = await catalogModel.findAllCardKeywords();
  catalog = {
    object: 'catalog',
    total_count: keywords.length,
    data: keywords
  }
  handleSuccess(res, catalog);
}

exports.getCardRarities = async (req, res) => {
  const rarities = await catalogModel.findAllCardRarities();
  catalog = {
    object: 'catalog',
    total_count: rarities.length,
    data: rarities
  }
  handleSuccess(res, catalog);
}

exports.getCardArtTypes = async (req, res) => {
  const artTypes = await catalogModel.findAllCardArtTypes();
  catalog = {
    object: 'catalog',
    total_count: artTypes.length,
    data: artTypes
  }
  handleSuccess(res, catalog);
}

exports.getCardFinishTypes = async (req, res) => {
  const finishTypes = await catalogModel.findAllCardFinishTypes();
  catalog = {
    object: 'catalog',
    total_count: finishTypes.length,
    data: finishTypes
  }
  handleSuccess(res, catalog);
}