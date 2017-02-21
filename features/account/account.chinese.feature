功能: 账号微服务
为了对用户的信息进行管理，通过账号微服务可以对用户进行注册，登录，注销以及管理等一系列操作。
用户的信息包括了用户的基本信息，角色信息，和组织信息。

背景:

  假定 超级用户已经登录
  当  清理所有用户,只保留超级用户
  那么 不存在用户"test1"
  #假定 清空资源:"Accounts",保留`username:'admin'`

场景: 新用户注册

  # 假如 新建资源:Accounts 内容为
  假如 成功注册新用户,其用户信息如下：
    ---
    username: 'test1'
    password: '123123'
    ---
  那么 期望上次的状态为200.
  并且 期望上次的结果包括：
    ----
    username: 'test1'
    ----

  当 登录用户:'test1',密码:"123123"
  那么 期望 上次的状态为200.
