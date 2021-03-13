// hasher
const Hashids = require('hashids/cjs')
const cardIdHasher = new Hashids('0r4cL3', 10)

module.exports = cardIdHasher;