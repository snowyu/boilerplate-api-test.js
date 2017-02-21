Request = require 'loopback-supertest'
Promise = require 'bluebird'
isArray = require 'util-ex/lib/is/type/array'

module.exports = (aDictionary)->
  this.define /[清删][理除]所有用户,只保留超级用户/, ->
    vContext = this.ctx
    this.api.delete Request.USERS
    .query {where: {neq: {username: 'admin'}}}
    .then (response)->
      vContext.result = response

  this.define /删除指定条件的资源/, (aQuery, aResource)->


  this.define /[删清][除理空]资源[:：]?\s*$string(?:\s*[,，]\s*保留($string))?/, (aResource, aQuery)->
    vContext = this.ctx
    result = this.api.delete aResource
    if isArray aQuery
      aQuery = nin: aQuery
    else if aQuery
      aQuery = neq: aQuery
    result = result.query {where: aQuery} if aQuery
    result.then (response)->
      vContext.result = response
    .catch (err)->
      vContext.result = err

  #this.define /[删清][除理空]指定条件\s*$string\s*的资源[:：]?\s*$string/, (aQuery, aResource)->
  # this.define /删除指定条件的资源/, (aQuery, aResource)->
  #   console.log 'get', aQuery, aResource
  #   return
  #   vContext = this.ctx
  #   if isArray aUsers
  #     result = this.api.delete Request.USERS
  #     .query where: in: username: aUsers
  #   else
  #     result = this.api.delete Request.USERS
  #     .query where: username: aUsers
  #   result.then (response)->
  #     vContext.result = response
  #   .catch (err)->
  #     vContext.result = err
