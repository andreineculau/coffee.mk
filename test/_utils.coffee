fs = require 'fs'
path = require 'path'
_ = require 'lodash'
chai = require 'chai'
chai.Assertion.includeStack = true

module.exports = {
  _
  assert: chai.assert
  chai: chai
  expect: chai.expect
  should: chai.should()
}

customUtilsFile = path.resolve './test/_utils.custom.coffee'
if fs.existsSync customUtilsFile
  _.merge module.exports, require customUtilsFile
