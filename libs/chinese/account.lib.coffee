
Request = require 'loopback-supertest'
Promise = require 'bluebird'
isArray = require 'util-ex/lib/is/type/array'

module.exports = (aDictionary)->
  aDictionary.define 'str', /('.+'|".*")/

  admin = username: 'admin', password: 'admiN123#'

  this.define /超级(?:管理[员者]|用户)(?:已经?)?登录/, ->
    vContext = this.ctx
    this.api.login admin
    .then (response)->
      vContext.result = response
    .catch (err)=>
      vContext.result = err
      return err

  this.define /(不?成功)注册新?用户[，,]?其?(?:用户)(?:信息)?(?:如下)?[:：]?\n$object/, (result, aUser)->
    result = result[0] isnt '不'
    vContext = this.ctx
    this.api.post Request.USERS
    .send aUser
    .then (response)->
      if result
        expect(response.status).to.be.equal 200
      else
        expect(response.status).not.to.be.equal 200
      vContext.result = response
    .catch (err)=>
      vContext.result = err
      return err

  this.define /[清删][理除]所有用户,只保留超级用户/, ->
    vContext = this.ctx
    this.api.delete Request.USERS
    .query {where: {neq: {username: 'admin'}}}
    .then (response)->
      vContext.result = response

  this.define /[清删][理除]指定用户[:：]$string/, (aUsers)->
    vContext = this.ctx
    if isArray aUsers
      result = this.api.delete Request.USERS
      .query where: in: username: aUsers
    else
      result = this.api.delete Request.USERS
      .query where: username: aUsers
    result.then (response)->
      vContext.result = response

