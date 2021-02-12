module.exports = (sequelize, Sequelize) => {
  var UserRole = sequelize.define("userRole", {
    roleName: {
      type: Sequelize.STRING,
      allowNull: false
    }
  });

  return UserRole;
};