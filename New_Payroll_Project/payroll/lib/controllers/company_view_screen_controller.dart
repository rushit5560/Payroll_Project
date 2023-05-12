import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';

class CompanyViewScreenController extends GetxController {
  final String companyId = Get.arguments[0];
  final String companyName = Get.arguments[1];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  UserPreference userPreference = UserPreference();


  RxBool isDepartmentShowPermission = false.obs;
  RxBool isEmployeeShowPermission = false.obs;
  RxBool isLocationShowPermission = false.obs;
  RxBool isPayChecksShowPermission = false.obs;
  RxBool isApprovePayChecksShowPermission = false.obs;


  @override
  void onInit() {
    initMethod();
    super.onInit();
  }


  initMethod() async {
    isLoading(true);
    isDepartmentShowPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.departmentViewKey);
    isEmployeeShowPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.employeeViewKey);
    isLocationShowPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.locationViewKey);
    isPayChecksShowPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.payChecksViewKey);
    isApprovePayChecksShowPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.approvePayChecksViewKey);
    isLoading(false);


    log('isDepartmentShowPermission : ${isDepartmentShowPermission.value}');
    log('isEmployeeShowPermission : ${isEmployeeShowPermission.value}');
    log('isLocationShowPermission : ${isLocationShowPermission.value}');
    log('isPayChecksShowPermission : ${isPayChecksShowPermission.value}');
    log('isApprovePayChecksShowPermission : ${isApprovePayChecksShowPermission.value}');
  }



  
}
