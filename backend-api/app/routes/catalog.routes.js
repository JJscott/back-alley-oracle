module.exports = app => {
  const catalogController = require("../controllers/catalog.controller.js");

  const router = require("express").Router();

  router.get("/card-names", catalogController.getCardNames);
  router.get("/card-classes", catalogController.getCardClasses);
  router.get("/card-types", catalogController.getCardTypes);
  router.get("/card-subtypes", catalogController.getCardSubtypes);
  router.get("/card-types-subtypes", catalogController.getCardTypesAndSubtypes);
  router.get("/card-specializations", catalogController.getCardSpecializations);
  router.get("/card-keywords", catalogController.getCardKeywords);
  router.get("/card-rarities", catalogController.getCardRarities);
  router.get("/card-art-types", catalogController.getCardArtTypes);
  router.get("/card-finish-types", catalogController.getCardFinishTypes);

  app.use('/catalog', router);
};