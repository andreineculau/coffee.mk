fs = require 'fs'
_ = require 'lodash'
chai = require 'chai'
chai.Assertion.includeStack = true

module.exports = {
  should: chai.should()
  _
}

if fs.existsSync './_utils.custom.coffee'
  _.merge module.exports, require './utils.custom.coffee'
