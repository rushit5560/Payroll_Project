import 'dart:developer';

import 'package:get/get.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';

class CompanyDrawerController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  UserPreference userPreference = UserPreference();

  RxBool companyView = false.obs;
  RxBool departmentView = false.obs;
  RxBool employeeView = false.obs;

  getUserPermission() async {
    isLoading(true);
    companyView.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.companyViewKey);
    departmentView.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.departmentViewKey);
    employeeView.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.employeeViewKey);
    log('companyView1111111111111111111 : ${companyView.value}');
    log('departmentView : ${departmentView.value}');
    log('employeeView : ${employeeView.value}');
    isLoading(false);
  }

  @override
  void onInit() {
    getUserPermission();
    super.onInit();
  }

}