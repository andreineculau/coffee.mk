fs = require 'fs'
_ = require 'lodash'
chai = require 'chai'
chai.Assertion.includeStack = true

module.exports = {
  should: chai.should()
  _
}

if fs.existsSync './_utils2.coffee'
  _.merge module.exports, require './utils2'
