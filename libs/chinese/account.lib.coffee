
Request = require 'loopback-supertest'
Promise = require 'bluebird'
isArray = require 'util-ex/lib/is/type/array'

module.exports = (aDictionary)->
  admin = username: 'admin', password: 'admiN123#'

  this.define /(不?应?该?存在)用户[:：]?\s*$string/, (aExists, aUsername)->
    if aExists[0] is '不'
      vCount = 0
    else
      vCount = 1
      if isArray aUsername
        vCount = aUser.length
    _getUsers.call this, aUsername
    .then (result)->
      expect(result).to.have.length vCount

  this.define /超级(?:管理[员者]|用户)(?:已经?)?登录/, ->
    vContext = this.ctx
    this.api.login admin
    .then (response)->
      vContext.result = response
    .catch (err)=>
      vContext.result = err
      return err

  this.define /(不?成功)注册新?用户[，,]?其?(?:用户)(?:信息)?(?:如下)?[:：]?$object/, (result, aUser)->
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
    .query {where: {username: {neq: 'admin'}}}
    .then (response)->
      vContext.result = response
    .catch (err)->
      vContext.result = err
      return err

  this.define /[清删][理除]指定用户[:：]$string/, (aUsers)->
    vContext = this.ctx
    if isArray aUsers
      result = this.api.delete Request.USERS
      .query where: JSON.stringify username: inq: aUsers
    else
      result = this.api.delete Request.USERS
      .query where: username: aUsers
    result.then (response)->
      vContext.result = response
      # console.log response
    .catch (err)->
      vContext.result = err
      return err

  # internal function to get users list:
  # must be call with _getUsers.call(this, theUserNames)
  _getUsers = (aUsername)->
    vContext = this.ctx
    if isArray aUsername
      aQuery = username: inq: aUsername
    else if aUsername
      aQuery = username: aUsername
    result = this.api.get Request.USERS
    result = result.query filter: JSON.stringify(where: aQuery) if aQuery
    result.then (response)->
      vContext.result = response
      if response.status isnt 200
        console.log response
      expect(response.status).to.be.equal 200
      response.body
    .catch (err)->
      vContext.result = err
      expect(err).to.be.null

