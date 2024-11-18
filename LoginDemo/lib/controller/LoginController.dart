import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //登陆按钮点击事件
  login(TextEditingController userNameController,
      TextEditingController passWordController) {
    var userName = userNameController.text;
    var passWord = passWordController.text;

    //1-用户协议是否勾选
    if (!isChecked.value) {
      Get.snackbar('用户协议未选中', '请勾选用户协议', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    //2-用户名判断
    if (userName.isEmpty) {
      Get.snackbar('用户名异常', '用户名为空', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    //3-密码判断
    if (passWord.isEmpty) {
      Get.snackbar('密码异常', '密码为空', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    Get.snackbar('用户名、密码正确', '去登陆', snackPosition: SnackPosition.BOTTOM);
    debugPrint("用户名:$userName,密码：$passWord");
  }

  //用户协议勾选事件
  var isChecked = false.obs;

  void changeChecked(bool value) {
    isChecked.value = value;
  }
}
