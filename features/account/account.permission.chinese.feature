功能: 账号权限管理
为了对账号的权限进行管理

@功能前提
场景: 清理用户
  假定 超级用户已经登录
  # 当  清理所有用户,只保留超级用户
  # 当 清空资源:"Accounts",保留`username:'admin'`
  当 删除指定用户:`["autoTestPerm"]`
  那么 不存在用户:"autoTestPerm"

场景: 为用户新增权限
  # 那么我们可以使用超级用户，对用户进行增加权限
  假定 超级用户已经登录
  并且 成功注册新用户,其用户信息如下：
    ---
    username: 'autoTestPerm'
    password: '123123'
    ---
  并且 记住`result.body.id`到"userId"


