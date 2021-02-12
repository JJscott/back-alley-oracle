const db = require("../models");

module.exports = app => {
  const { authJwt } = require("../middleware");
  const controlGen = require("../controllers/resourceControllerGenerator.js");

  // insert middleware
  app.use((req, res, next) => {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });


  //TODO verify like such
  // app.get(
  //   "/api/test/mod",
  //   [authJwt.verifyToken, authJwt.isModerator],
  //   controller.moderatorBoard
  // );

  // automatically generate CRUD operations routes for a given model
  const generateRoutes = (model) => {
    var router = require("express").Router();
    router.post('/', controlGen.generateCreateForModel(model));
    router.get('/', controlGen.generateFindAllForModel(model));
    router.get('/:id', controlGen.generateFindOneForModel(model));
    router.put('/:id', controlGen.generateUpdateForModel(model));
    router.delete('/:id', controlGen.generateDeleteForModel(model));
    router.delete('/', controlGen.generateDeleteAllForModel(model));
    app.use(`/api/resource/${model.tableName}`, router);

    console.log(`Routes loaded for '/api/resource/${model.tableName}'`)
  }

  generateRoutes(db.cardBases);
  generateRoutes(db.cardClasses);
  generateRoutes(db.cardSpecializations);
  generateRoutes(db.cardSubtypes);
  generateRoutes(db.cardTypes);
  generateRoutes(db.prints);
  generateRoutes(db.printArtists);
  generateRoutes(db.printArtTypes);
  generateRoutes(db.printFoilTypes);
  generateRoutes(db.printRarities);
  generateRoutes(db.printSets);
  generateRoutes(db.printFrameStyles);
  generateRoutes(db.printFrameAltColors);
};