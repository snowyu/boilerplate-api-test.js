# 注意功能和描述之间不能有空行！
功能: 信息管理微服务
对各类信息进行管理，包括公告，新闻，招聘等，这些称为信息的类别。
信息通过isCat字段来区分到底是类别还是信息正文。


背景:
  假定 超级用户已经登录
  #inq:[{id:'/物业/#information/新闻'},{id:'/物业/#information/新闻/军事新闻'}]
  # 假定 删除指定条件的资源

# id和name的建立规则：
# name = parent.name + '/' + title
# id = orgId + '/' + name
场景: 检测id和name的自动产生

  并且 新建资源:OrganizationInformations, 内容为
    ---
    title: '新闻'
    organizationId: "/物业/#information"
    isCat: true
    ---

  那么 期望上次的状态为200.
  # 检测自动创建的id和name
  并且 期望上次的结果包括：
    ----
    id:'/物业/#information/新闻'
    name: '/新闻'
    title: '新闻'
    organizationId: "/物业/#information"
    isCat: true
    ----

  假定 新建资源:OrganizationInformations, 内容为
    ---
    title: '军事新闻'
    organizationId: "/物业/#information"
    parentId: '/物业/#information/新闻'
    isCat: true
    ---

  那么 期望上次的状态为200.
  并且 期望上次的结果包括：
    ----
    id:'/物业/#information/新闻/军事新闻'
    name: '/新闻/军事新闻'
    title: '军事新闻'
    organizationId: "/物业/#information"
    parentId: '/物业/#information/新闻'
    isCat: true
    ----
