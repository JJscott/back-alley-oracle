module.exports = (sequelize, Sequelize) => {
  var User = sequelize.define("user", {
    username: {
      type: Sequelize.STRING,
      allowNull: false
    },
    email: {
      type: Sequelize.STRING,
      unique: true,
      allowNull: false,
      validate: {
        isEmail: true
      }
    },
    password_hash: {
      type: Sequelize.STRING,
      allowNull: false
    }
  });

  // User.generateHash = (password) => bcrypt.hashSync(password, bcrypt.genSalt(8), null);
  // User.validPassword = (password) => bcrypt.compareSync(password, this.localPassword);

  return User;
};