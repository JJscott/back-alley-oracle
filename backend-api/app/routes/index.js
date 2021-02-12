module.exports = app => {

  require("./catalog.routes")(app);
  require("./card.routes")(app);

}