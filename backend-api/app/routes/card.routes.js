module.exports = app => {
  const cardController = require("../controllers/card.controller.js");

  const router = require("express").Router();

  router.get("/search", cardController.search);
  router.get("/random", cardController.getRandom);
  router.get("/:templateSid", cardController.getOne);

  app.use('/cards', router);
};