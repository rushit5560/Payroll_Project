
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
  RxBool isPayChecksDownloadPermission = false.obs;

  RxString employeeName = "".obs;

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  initMethod() async {
    isLoading(true);
    isDocumentDownloadPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.employeeDocumentViewKey);
    isDocumentUploadPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.employeeDocumentViewKey);
    isPayChecksDownloadPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.payChecksViewKey);
    employeeName.value = await userPreference.getStringValueFromPrefs(keyId: UserPreference.userNameKey);
    log('isDocumentDownloadPermission : ${isDocumentDownloadPermission.value}');
    log('isDocumentUploadPermission : ${isDocumentUploadPermission.value}');
    log('isPayChecksDownloadPermission : ${isPayChecksDownloadPermission.value}');

    isLoading(false);
  }
}
