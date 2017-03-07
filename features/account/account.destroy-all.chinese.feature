功能: 清除账号
为了方便在测试运行前清理帐号，特制定下列的清除步骤。

@功能前提
场景: 登录超级用户
  假定 超级用户已经登录

场景: 删除指定单个用户
  假定 成功注册新用户,其用户信息如下：[data]
  当 删除指定用户:"[name]"
  那么 不存在用户:"[name]"

  例子:
  |-----------|-----------------------|
  | name      | data                  |
  |-----------|-----------------------|
  | autoTest1 | username: 'autoTest1' |
  |           | password: '123123'    |
  |-----------|-----------------------|
  | autoTest2 | username: 'autoTest2' |
  |           | password: '123123'    |
  |-----------|-----------------------|
  | autoTest3 | username: 'autoTest3' |
  |           | password: '123123'    |
  |-----------|-----------------------|
  | autoTest4 | username: 'autoTest4' |
  |           | password: '123123'    |
  |-----------|-----------------------|

场景: 一次删除多个用户
  假定 成功注册新用户,其用户信息如下：
    ---
    username: 'autoTest1'
    password: '123123'
    ---
  并且 成功注册新用户,其用户信息如下：
    ---
    username: 'autoTest2'
    password: '123123'
    ---
  并且 成功注册新用户,其用户信息如下：
    ---
    username: 'autoTest3'
    password: '123123'
    ---
  当 删除指定用户:`["autoTest1","autoTest2"]`
  那么 不存在用户:`["autoTest1","autoTest2"]`
  并且 存在用户:"autoTest3"

场景: 删除所有用户,只保留超级用户
  假定 成功注册新用户,其用户信息如下：
    ---
    username: 'autoTest1'
    password: '123123'
    ---
  并且 成功注册新用户,其用户信息如下：
    ---
    username: 'autoTest2'
    password: '123123'
    ---
  当 删除所有用户,只保留超级用户
  那么 当列出资源:Accounts
  并且 记住结果的"body.length"到"count"
  并且 期望保留的"count"=1
  并且 记住`result.body[0].username`到"username"
  并且 期望保留的"username"="admin"

