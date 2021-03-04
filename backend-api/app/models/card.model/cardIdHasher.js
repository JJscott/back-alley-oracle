// hasher
const Hashids = require('hashids/cjs')
const cardIdHasher = new Hashids('oracle', 10)

module.exports = cardIdHasher;