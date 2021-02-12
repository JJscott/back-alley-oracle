const db = require("../models");
const Op = db.Sequelize.Op;


// Create and Save a new object
exports.generateCreateForModel = (model) => {
  return (req, res) => {
    // TODO validate

    const object = {
      ...req.body
    };

    model.create(object)
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({ message: err.message || `Error creating ${model.tableName}.` });
      });
  };
};


// Retrieve all objects from the database.
exports.generateFindAllForModel = (model) => {
  return (req, res) => {
    model.findAll()
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({ message: err.message || `Error retrieving ${model.tableName}.` });
      });
  };
};


// Find a single object with an id
exports.generateFindOneForModel = (model) => {
  return (req, res) => {
    const id = req.params.id;

    model.findByPk(id)
      .then(data => {
        if (data) {
          res.send(data);
        } else {
          res.status(404).send({ message: `Error retrieving ${model.tableName} with 'id'=${id}` });
        }
      })
      .catch(err => {
        res.status(500).send({ message: err.message || `Error retrieving ${model.tableName} with 'id'=${id}.`});
      });
  };
};


// Update a object by the id in the request
exports.generateUpdateForModel = (model) => {
  return (req, res) => {
    const id = req.params.id;

    // TODO validate

    const object = {
      ...req.body
    };

    model.update(object, { where: { id: id } })
      .then(num => {
        if (num == 1) {
          res.send({ message: `${model.tableName} was updated successfully.` });
        } else {
          res.status(409).send({ message: `Cannot update ${model.tableName} with id=${id}.` });
        }
      })
      .catch(err => {
        res.status(500).send({ message: err.message || `Error updating CardBase with id=${id}.`});
      });
  };
};


// Delete a object with the specified id in the request
exports.generateDeleteForModel = (model) => {
  return (req, res) => {
    const id = req.params.id;

    model.destroy({ where: { id: id } })
      .then(num => {
        if (num == 1) {
          res.send({ message: `${model.tableName} was deleted successfully.` });
        } else {
          res.send({ message: `Cannot delete ${model.tableName} with id=${id}.` });
        }
      })
      .catch(err => {
        res.status(500).send({ message: err.message || `Error deleting ${model.tableName} with ${id}.` });
      });
  };
};


// Delete all objects from the database.
exports.generateDeleteAllForModel = (model) => {
  return (req, res) => {
    model.destroy({
      where: {},
      truncate: false
    })
      .then(nums => {
        res.send({ message: `${nums} ${model.tableName} were deleted successfully.` });
      })
      .catch(err => {
        res.status(500).send({ message: err.message || `Error removing all ${model.tableName}.` });
      });
  };
};