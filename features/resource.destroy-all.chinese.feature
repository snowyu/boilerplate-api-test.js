功能: 清除资源
为了方便在测试运行前清理资源，特制定下列的清除步骤。

@功能前提
场景: 登录超级用户
  假如 超级用户已经登录

@场景前提
场景: 清空资源
  假如 清空资源:"OrganizationReplies"

场景: 测试清空资源
  假如 新建资源"OrganizationReplies"成功,内容为
    ---
    "whatModel": "Account"
    "whatId": "A"
    "content": "A"
    ---
  而且 新建资源"OrganizationReplies"成功,内容为
    ---
    "whatModel": "Account"
    "whatId": "A"
    "content": "B"
    ---
  而且 新建资源"OrganizationReplies"成功,内容为
    ---
    "whatModel": "Account"
    "whatId": "A"
    "content": "C"
    ---
  当 清空资源:"OrganizationReplies"
  那么 当列出资源:OrganizationReplies
  而且 记住结果的"body.length"到"count"
  而且 期望保留的"count"=0

场景: 删除指定一行条件的资源
  假如 新建资源"OrganizationReplies"成功,内容为
    ---
    "whatModel": "Account"
    "whatId": "A"
    "content": "A"
    ---
  而且 新建资源"OrganizationReplies"成功,内容为
    ---
    "whatModel": "Account"
    "whatId": "A"
    "content": "B"
    ---
  而且 新建资源"OrganizationReplies"成功,内容为
    ---
    "whatModel": "Account"
    "whatId": "C"
    "content": "C"
    ---
  当 删除指定条件`whatId: 'A'`的资源:"OrganizationReplies"
  那么 当列出资源:OrganizationReplies
  而且 记住结果的"body.length"到"count"
  而且 期望保留的"count"=1

场景: 删除指定多行条件的资源
  假如 新建资源"OrganizationReplies"成功,内容为
    ---
    "whatModel": "Account"
    "whatId": "A"
    "content": "A"
    ---
  而且 新建资源"OrganizationReplies"成功,内容为
    ---
    "whatModel": "Account"
    "whatId": "A"
    "content": "B"
    ---
  而且 新建资源"OrganizationReplies"成功,内容为
    ---
    "whatModel": "Organization"
    "whatId": "A"
    "content": "C"
    ---
  当 删除资源"OrganizationReplies"，指定条件如下
    ---
    whatModel: "Account"
    whatId: 'A'
    ---
  那么 当列出资源:OrganizationReplies
  而且 记住结果的"body.length"到"count"
  而且 期望保留的"count"=1
