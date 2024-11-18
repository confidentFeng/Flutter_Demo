import 'package:get/get.dart';

// （2）自定义自己的国际化字符串 
class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // 1-配置中文简体
    'zh_CN': {
      '中国': '中国',
    },

    // 2-配置中文繁体
    'zh_HK': {
      '中国': '中國',
    },
    
    // 3-配置英文
    'en_US': {
      '中国': 'China',
    }
  };
}