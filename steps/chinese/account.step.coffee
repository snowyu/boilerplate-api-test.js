Request = require('loopback-supertest')

module.exports = (aDictionary)->

  this.define /注册新?用户(?:信息)?(?:如下)?[:：]?\n$object/, (aUser)->
    vContext = this.ctx
    this.api.post Request.USERS, data: aUser
    .then (response)=>
      vContext.result = response
    .catch (err)=>
      vContext.result = err
      return err
