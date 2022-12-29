import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UserPreference userPreference = UserPreference();
  RxInt roleId = 0.obs;

  getRoleIdFunctionFromPrefs() async {
    isLoading(true);
    int roleIdPrefs = await userPreference.getIntValueFromPrefs(keyId: UserPreference.roleIdKey);
    roleId.value = roleIdPrefs;
    log('Home Screen Init roleId : $roleId');
    isLoading(false);
  }

  @override
  void onInit() {
    getRoleIdFunctionFromPrefs();
    super.onInit();
  }

}
