# Loopback API Test

## Install

第一次Git Clone后，必须执行：

    npm install

然后执行 `npm test` 进行测试。

* 简单
* 快速
* 易扩展

模板项目：[boilerplate-api-test](https://github.com/snowyu/boilerplate-api-test.js)

## 用途

* 自动化测试
* 固化错误
* 批量数据整理(导入，清理)

## 目录文件结构

* `.api-bdd-test.yml` : 配置文件
* `test`: mocha 的测试配置目录
* `features`: 功能描述目录（主要写测试的地方）
* `libs`: 自定义的库目录(所有功能都会加载)
* `steps`: 自定义的步骤目录（匹配的功能才会加载）

## 配置文件

`.api-bdd-test.yml` 指定API服务器的地址和路径:

```yaml
server: "http://localhost:3000" # API服务器
root: /api                      # API服务器的路径
libs: "./libs"                  # 自定义的库目录
steps: "./steps"                # 自定义的步骤目录
features: "./features"          # 功能描述目录
```

## 描述你的测试

在 `features` 目录下存放所有的功能。

* 按照 Model 名称(单数)来组织子目录
* `[model]/[model].chinese.feature`: 用于描述Model主功能概述，以及基本的CRUD操作测试
* `[model]/[model].[operation].chinese.feature`: 用于描述Model的其它业务操作


### 基本概念

* Feature(功能)：相当于一个user story(case)。
  * Scenario(场景): 功能的操作路径
    * Step(步骤)：步骤的标准写法由`given-when-then`所组成
      * Given(假定)步骤:用来描述要准备那些测试环境
      * When(当)步骤:用来描述如何执行待测程式
      * Then(那么)步骤:用来描述如何验证测试是否成功

### 注解(annotation)

同一功能文件中有效

可以放在功能，场景，步骤前

* @pending : 待定/暂缓
* @only    : 仅仅

只能放在场景前，标识该场景为特殊场景:

* before（功能前提）: 在所有场景前执行
* after（功能收工）: 在所有场景后执行
* beforeEach(场景前提): 在每一个场景前执行
* afterEach(场景收工): 在每一个场景后执行
* beforeStep(步骤前提): 在每一个步骤前执行
* afterStep（(步骤收工)）: 在每一个步骤后执行

### 标准步骤

* 新建资源:Accounts 内容为
    ---
    username: 'yourName..'
    password: '...'
    ---
* 列出资源:Accounts
* 搜索资源:Accounts,按如下条件
    ---
    filter: where: {}
    ---
* 修改ID为"XXXX"的资源:Accounts
    ---
    username: 'yourName..'
    ---
* 删除ID为"XXX"的资源:Accounts
* [不]存在ID为"1"的资源(Accounts)
* 上次的状态为200
* 上次的结果包括
* 上次的结果是

* 超级用户已经登录
* 登录用户:'autoTest1',密码:"123123"
* 注销用户|退出系统
* 删除指定用户:`["autoTest1"]`
* 删除所有用户,只保留超级用户
* [不]存在用户:"autoTest3"

### 标准 API

* GET|POST|PUT|DELETE|HEAD "Accounts":
    ---
    data:
      username: 'yourName..'
      password: '...'
    heads:
    query:
    fields:
    attach:
    ---

### 例子

```cucumber
功能: 账号微服务
为了对用户的信息进行管理，通过账号微服务可以对用户进行注册，登录，注销以及管理等一系列操作。
用户的信息包括了用户的基本信息，角色信息，和组织信息。

@功能前提
场景: 清理用户
  假定 超级用户已经登录
  # 当  清理所有用户,只保留超级用户
  # 当 清空资源:"Accounts",保留`username:'admin'`
  当 删除指定用户:`["autoTest1"]`
  那么 不存在用户:"autoTest1"

场景: 新用户注册

  # 假如 新建资源:Accounts 内容为
  假如 成功注册新用户,其用户信息如下：
    ---
    username: 'autoTest1'
    password: '123123'
    ---
  那么 期望上次的状态为200.
  并且 期望上次的结果包括：
    ----
    username: 'autoTest1'
    ----

  当 登录用户:'autoTest1',密码:"123123"
  那么 期望 上次的状态为200.
```

利用"例子"可以按照例子表中的数据反复执行某个场景:
注意：例子必须在该场景的所有步骤之后出现。

```cucumber
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
```

* [Account Feature](./features/account.chinese.feature)
* [Account.destroyAll Feature](./features/account.destroy-all.chinese.feature)

## 约定

features 目录:

* 可以存放在旗下的任意子目录:便于分类管理
* 文件必须以扩展名`.feature`结束
* 子扩展名`.chinese` 表示中文
  * 如: `account.chinese.feature`
* 抛开`.chinese.feature`部分为功能的文件名称。

steps 目录:

* 文件必须存在子扩展名`.step`
* 文件可以是js或者coffee-script，
  * 如：`.step.js`或`.step.coffee`
* 中文放在`steps`的`chinese`子目录下，
  × 只有同语言的对应的功能文件才会加载
* 步骤的文件名称必须和功能的文件名称保持一致
  * 如：功能文件 `account.chinese.feature`
  * 那么对应的步骤文件： `account.step.js` 或者 `account.step.coffee`

libs 目录:

* 所有功能都会被加载，不过在语言目录下的库，只有同语言的才会被加载
* 文件必须存在子扩展名`.lib`
* 文件可以是js或者coffee-script，
  * 扩展名为：`.lib.js`或`.lib.coffee`
* 中文放在`libs`的`chinese`子目录下





