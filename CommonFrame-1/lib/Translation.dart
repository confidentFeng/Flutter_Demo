import 'package:get/get.dart';

// （2）自定义自己的国际化字符串 
class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // 1-配置中文简体
    'zh_CN': {
      '登录': '登录',
      '用户协议未选中': '用户协议未选中',
      '请勾选用户协议': '请勾选用户协议',
      '用户名异常': '用户名异常',
      '用户名为空': '用户名为空',
      '密码异常': '密码异常',
      '密码为空': '密码为空',
      '用户名、密码正确': '用户名、密码正确',
      '去登陆': '去登陆',
      '用户': '用户',
      '密码': '密码',
      '同意': '同意',
      '<服务协议>': '<服务协议>',
      '<隐私政策>': '<隐私政策>',
    },

    // 2-配置中文繁体
    'zh_HK': {
      '登录': '登錄',
      '用户协议未选中': '用戶協議未選中',
      '请勾选用户协议': '請勾選用戶協議',
      '用户名异常': '用戶名異常',
      '用户名为空': '用戶名爲空',
      '密码异常': '密碼異常',
      '密码为空': '密碼爲空',
      '用户名、密码正确': '用戶名、密碼正確',
      '去登陆': '去登陸',
      '用户': '用戶',
      '密码': '密碼',
      '同意': '同意',
      '<服务协议>': '<服務協議>',
      '<隐私政策>': '<隱私政策>',
    },
    
    // 3-配置英文
    'en_US': {
      '登录': 'Login',
      '用户协议未选中': 'User agreement not selected',
      '请勾选用户协议': 'Please check the user agreement',      
      '用户名异常': 'Abnormal username',      
      '用户名为空': 'The username is empty',      
      '密码异常': 'Password exception',      
      '密码为空': 'Password is empty',      
      '用户名、密码正确': 'The username and password are correct',      
      '去登陆': 'Go log in',      
      '用户': 'user',      
      '密码': 'password',      
      '同意': 'agree with',      
      '<服务协议>': '<Service Agreement>',      
      '<隐私政策>': '<Privacy Policy>',      
    }
  };
}