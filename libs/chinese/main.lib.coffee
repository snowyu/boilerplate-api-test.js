Request = require 'loopback-supertest'
Promise = require 'bluebird'
isArray = require 'util-ex/lib/is/type/array'
isObject= require 'util-ex/lib/is/type/object'

module.exports = (aDictionary)->
  this.define /查找指定条件$string的资源[:：]\s*$string/, (aQuery, aResource)->
    vContext = this.ctx
    result = this.api.get aResource
    result = result.query filter: {where: aQuery} if aQuery
    result.then (response)->
      vContext.result = response
    .catch (err)->
      vContext.result = err

  this.define /[删清][理空]资源[:：]\s*$string/, (aResource)->
    vContext = this.ctx
    this.api.delete aResource
    .then (response)->
      vContext.result = response
    .catch (err)->
      vContext.result = err

  this.define /[删清][除理空]指定条件\s*$string\s*的资源[:：]?\s*$string/, (aQuery, aResource)->
    vContext = this.ctx
    result = this.api.delete aResource
    # aQuery = inq: aQuery if isArray aQuery
    result = result.query {where: aQuery} if aQuery
    result.then (response)->
      vContext.result = response
    .catch (err)->
      vContext.result = err

  this.define /[删清][除理空]资源\s*$string[,，]?\s*指定条件如下[:：]?\n$object/, (aResource,aQuery)->
    vContext = this.ctx
    result = this.api.delete aResource
    # aQuery = inq: aQuery if isArray aQuery
    result = result.query {where: aQuery} if aQuery
    result.then (response)->
      vContext.result = response
    .catch (err)->
      vContext.result = err
