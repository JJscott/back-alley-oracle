// const _ = require('lodash');
// const { validationResult } = require('express-validator');
// const { getTokenData } = require('./authentication');
// const userModel = require('../models/userModel');
// const permissionModel = require('../models/permissionModel');

// const emitValidationResponse = (res, errorArray) => {
//   return res.status(422).json({
//     success: false,
//     status: 422,
//     message: errorArray.length === 1 ? 'There is a validation error.' : 'There are validation errors.',
//     data: errorArray
//   });
// };

// const handleValidationError = (req, res) => {
//   const errors = validationResult(req);
//   if (!errors.isEmpty()) {
//     const errorArray = errors.array();
//     return emitValidationResponse(res, errorArray);
//   }
//   return null;
// };

// const handleCustomValidationError = (res, errorArray) => {
//   return emitValidationResponse(res, errorArray);
// };

const handleSuccess = (res, send) => {
  return res.status(200).send(send);
};

const handleCreated = (res, send) => {
  return res.status(201).send(send);
};

const handleInvalidRequest = (res, send) => {
  return res.status(400).send(send);
};

// TODO
// | 401 | Unauthorized | The request did not include an authentication token or the authentication token was expired. |
// | 405 | Not Allowed | The HTTP method in the request was not supported by the resource. For example, the DELETE method cannot be used with the Agent API. |

const handleForbidden = (res, send) => {
  return res.status(403).send(send);
};

const handleNotFound = (res, send) => {
  return res.status(404).send(send);
};


const handleInternalError = (res, send) => {
  return res.status(500).send(send);
};


const handleUnavaliable = (res, send) => {
  return res.status(503).send(send);
};



// const handleRedirect = (res, status, url) => {
//   return res.redirect(status, url);
// };

// const handlePermissionError = async (req, res, permissionKey) => {
//   const tokenData = await getTokenData(req);
//   if (tokenData.role === userModel.userRole.administrator) {
//     return null;
//   }

//   if (tokenData.role === userModel.userRole.staff) {
//     // If user role is staff, then make sure staff has permission
//     const permissionUser = await permissionModel.findPermissionUsers({
//       searchOptions: {
//         'permission_user.user_id': tokenData.id,
//         'permission.permission_key': permissionKey
//       }
//     });

//     if (_.isEmpty(permissionUser) === false) {
//       return null;
//     }
//   }

//   return res.status(401).json({
//     success: false,
//     status: 401,
//     message: 'You do not have a permission to perform this action.',
//     data: {}
//   });
// };

// const validateRequest = async (req, res, options) => {
//   // Handle validation error if the request is not valid
//   const validationResponse = handleValidationError(req, res);
//   if (validationResponse !== null) {
//     return validationResponse;
//   }

//   if (options.permissionKey) {
//     const validationPermission = await handlePermissionError(req, res, options.permissionKey);
//     if (validationPermission !== null) {
//       return validationPermission;
//     }
//   }

//   return null;
// };

module.exports = {
  // handleValidationError,
  // handleCustomValidationError,
  handleSuccess,
  handleCreated,
  handleInvalidRequest,
  handleForbidden,
  handleNotFound,
  handleInternalError,
  handleUnavaliable,
  // handleRedirect,
  // validateRequest
};
