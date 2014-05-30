fs = require 'fs'
path = require 'path'
_ = require 'lodash'
chai = require 'chai'
chai.config.includeStack = true
existsSync = fs.existsSync or path.existsSync

module.exports = {
  _
  assert: chai.assert
  chai: chai
  expect: chai.expect
  should: chai.should()
}

customUtilsFile = path.resolve './test/_utils.custom.coffee'
if existsSync customUtilsFile
  _.merge module.exports, require customUtilsFile
