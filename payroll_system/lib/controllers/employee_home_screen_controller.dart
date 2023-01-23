
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';

class EmployeeHomeScreenController extends GetxController {

  RxBool isLoading = false.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UserPreference userPreference = UserPreference();
  RxBool isDocumentDownloadPermission = false.obs;
  RxBool isDocumentUploadPermission = false.obs;
  RxBool ispayChecksDownloadPermission = false.obs;

  RxString employeeName = "".obs;

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  initMethod() async {
    isLoading(true);
    isDocumentDownloadPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.employeeDocumentDownloadKey);
    isDocumentUploadPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.employeeDocumentAddKey);
    ispayChecksDownloadPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.payChecksDownloadKey);
    employeeName.value = await userPreference.getStringValueFromPrefs(keyId: UserPreference.userNameKey);
    isLoading(false);
  }
}
