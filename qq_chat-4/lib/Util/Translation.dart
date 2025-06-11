import 'package:get/get.dart';

// （2）自定义自己的国际化字符串 
class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // 1-配置中文简体
    'zh_CN': {
      '用户': '用户',
      '密码': '密码',
      '记住密码': '记住密码',
      '自动登录': '自动登录',              
      '登录': '登录',
      '注册账号': '注册账号',
      '找回密码': '找回密码',         
      '用户名异常': '用户名异常',
      '用户名为空': '用户名为空',
      '密码异常': '密码异常',
      '密码为空': '密码为空',
      '用户名、密码正确': '用户名、密码正确',
      '去登陆': '去登陆',
    },

    // 2-配置中文繁体
    'zh_HK': {
      '用户': '用戶',
      '密码': '密碼',
      '记住密码': '記住密碼',
      '自动登录': '自動登錄',              
      '登录': '登錄',
      '注册账号': '註冊賬號',
      '找回密码': '找回密碼',  
      '用户名异常': '用戶名異常',
      '用户名为空': '用戶名爲空',
      '密码异常': '密碼異常',
      '密码为空': '密碼爲空',
      '用户名、密码正确': '用戶名、密碼正確',
      '去登陆': '去登陸',
    },
    
    // 3-配置英文
    'en_US': {
      '用户': 'user',      
      '密码': 'password', 
      '记住密码': 'Remember pw',
      '自动登录': 'Auto login',              
      '登录': 'Login',
      '注册账号': 'Register',
      '找回密码': 'Retrieve',      
      '用户名异常': 'Abnormal username',      
      '用户名为空': 'The username is empty',      
      '密码异常': 'Password exception',      
      '密码为空': 'Password is empty',      
      '用户名、密码正确': 'The username and password are correct',      
      '去登陆': 'Go log in',              
    }
  };
}