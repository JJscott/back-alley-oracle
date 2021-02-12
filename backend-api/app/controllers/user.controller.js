const db = require("../models");
const User = db.users

const config = require("../config/auth.config");
const bcrypt = require('bcrypt');
const jwt = require("jsonwebtoken");

const saltRounds = 12; //MOVE to auth.config.js?

// Create and Save a new User
exports.register = (req, res) => {
  console.log('registering user');
  console.log(req.body)
  bcrypt.hash(req.body.password, config.saltRounds, (err, hash) => {

    // Construct user
    const user = {
      username: req.body.username,
      email: req.body.email,
      password_hash: hash
    }

    // Save user in database
    User.create(user)
      .then(data => {
        if (data) {
          res.send('User was registered successfully!');
        }
      })
      .catch(err => {
        res.status(500).send({ message: err.message });
      });
  });
}


// Authenticate User
exports.login = (req, res) => {
  const condition = { email: req.body.email };
  console.log(`login email: ${req.body.email}`);
  User.findOne({ where: condition })
    .then(data => {
      if (!data) {
        console.log('no user found');
        res.status(404).send({ message: "User Not found." });;
      } else {
        bcrypt.compare(req.body.password, data.password_hash, (err, result) => {

          // if passwords match
          if (result) { 
            console.log('logged in');
            let token = jwt.sign(
              { id: data.id },
              config.secret,
            );
            res.status(200).send({
              id: data.id,
              username: data.username,
              email: data.email,
              accessToken: token
            });
          // if password doesn't match
          } else {
            return res.status(401).send({accessToken: null, message: "Invalid Password!"});
          }
        });
      }
    })
    .catch(err => {
      res.status(500).send({ message: err.message });
    });
}