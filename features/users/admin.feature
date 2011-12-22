Feature: 管理员的登陆与退出
  为实现管理员登陆后台管理
  作为一名管理员
  我应该可以访问后台管理
  
  Scenario: 管理员登陆后台管理
    Given 有一名管理员，邮箱为"admin@yeah.net"密码为"admin12345"
    When 在前台用"admin@yeah.net"和"admin12345"登录后，我进入后台管理
    Then 我应当看到后台管理的欢迎界面
    
  Scenario: 非管理员登陆后台
    Given 有一名普通用户，邮箱为"user@yeah.net"密码为"user12345"
    When 在前台用"user@yeah.net"和"user12345"登录后，我进入后台管理
    Then 我应当看到你不是管理员，不能进入后台管理的消息提示
  
  
  
  
  
  

  
