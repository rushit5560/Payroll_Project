import 'dart:developer';
import 'package:get/get.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';

class AdminDrawerController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  UserPreference userPreference = UserPreference();

  RxBool companyView = false.obs;
  RxBool departmentView = false.obs;
  RxBool employeeView = false.obs;

  RxInt roleId = 0.obs;
  RxInt userid = 0.obs;
  RxBool isSubadminShowPermission = false.obs;
  RxBool isGeneralSettingShowPermission = false.obs;

  getUserIdFunctionFromPrefs() async {
    isLoading(true);
    int userIdPrefs = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.userIdKey);
    int roleIdPrefs = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.roleIdKey);
    userid.value = userIdPrefs;
    roleId.value = roleIdPrefs;

    log('Home Screen Init userid : ${userid.value}');
    await getUserPermission();
    isLoading(false);
  }

  getUserPermission() async {
    isLoading(true);
    companyView.value = await userPreference.getBoolPermissionFromPrefs(
        keyId: UserPreference.companyViewKey);
    departmentView.value = await userPreference.getBoolPermissionFromPrefs(
        keyId: UserPreference.departmentViewKey);
    employeeView.value = await userPreference.getBoolPermissionFromPrefs(
        keyId: UserPreference.employeeViewKey);

    isSubadminShowPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.subAdminViewKey);
    isGeneralSettingShowPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.generalSettingViewKey);


    log('companyView1111111111111111111 : ${companyView.value}');
    log('departmentView : ${departmentView.value}');
    log('employeeView : ${employeeView.value}');
    isLoading(false);
  }

  @override
  void onInit() {
    getUserIdFunctionFromPrefs();
    super.onInit();
  }
}
