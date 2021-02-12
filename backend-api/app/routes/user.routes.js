module.exports = app => {
  const { verifySignUp } = require("../middleware");
  const users = require("../controllers/user.controller.js");

  var router = require("express").Router();

  // insert middleware
  app.use((req, res, next) => {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });

  // Register user (using authentication middleware)
  router.post(
    "/register",
    [
      verifySignUp.checkDuplicateUsernameOrEmail,
      verifySignUp.checkRolesExisted
    ],
    users.register
  );

  // Log in user
  router.post("/login", users.login);

  app.use('/api/user', router);
  console.log(`Routes loaded for '/api/user'`)
};