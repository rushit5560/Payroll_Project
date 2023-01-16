import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Screen/authentication_screens/login_screen/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/screen/company_home_screen/company_home_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_details.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/user_permission_model/user_permission_model.dart';
import '../Screen/Home_Screen/home_screen.dart';
import '../Utils/api_url.dart';
import '../screen/employee_home_screen/employee_home_screen.dart';

class SplashScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  UserPreference userPreference = UserPreference();

  //User getUserPermissionsFunction
  Future<void> getUserPermissionsFunction({required String roleId}) async {
    isLoading(true);
    log('UserDetails.roleId Only for permission : ${UserDetails.roleId}');
    log('UserDetails.roleId1 Only for permission : $roleId');
    String url = "${ApiUrl.getPermissionApi}$roleId";
    log("getUserPermissionsFunction Api url1212 : $url");

    try {
      http.Response response = await http.get(Uri.parse(url));
      log("getUserPermissionsFunction response :  ${response.body}");

      UserPermissionModel userPermissionModel =
          UserPermissionModel.fromJson(json.decode(response.body));
      isSuccessStatus = userPermissionModel.success.obs;

      if (isSuccessStatus.value) {
        log("getUserPermissionsFunction isSuccessStatus :  ${isSuccessStatus.value}");

        // Fluttertoast.showToast(msg: userPermissionModel.messege);

        await userPreference.setUserPermissionsToPrefsAndLocal(
          // role
          roleAdd: userPermissionModel.data.roleadd == "on" ? true : false,
          roleEdit: userPermissionModel.data.roleedit == "on" ? true : false,
          roleView: userPermissionModel.data.roleview == "on" ? true : false,
          roleDelete:
              userPermissionModel.data.roledelete == "on" ? true : false,
          //company
          companyAdd:
              userPermissionModel.data.companyadd == "on" ? true : false,
          companyEdit:
              userPermissionModel.data.companyedit == "on" ? true : false,
          companyView:
              userPermissionModel.data.companyview == "on" ? true : false,
          companyDelete:
              userPermissionModel.data.companydelete == "on" ? true : false,
          //location
          locationAdd:
              userPermissionModel.data.locationadd == "on" ? true : false,
          locationEdit:
              userPermissionModel.data.locationedit == "on" ? true : false,
          locationView:
              userPermissionModel.data.locationview == "on" ? true : false,
          locationDelete:
              userPermissionModel.data.locationdelete == "on" ? true : false,
          //employee
          employeeAdd:
              userPermissionModel.data.employeeadd == "on" ? true : false,
          employeeEdit:
              userPermissionModel.data.employeeedit == "on" ? true : false,
          employeeView:
              userPermissionModel.data.employeeview == "on" ? true : false,
          employeeDelete:
              userPermissionModel.data.employeedelete == "on" ? true : false,
          //department
          departmentAdd:
              userPermissionModel.data.departmentadd == "on" ? true : false,
          departmentEdit:
              userPermissionModel.data.departmentedit == "on" ? true : false,
          departmentView:
              userPermissionModel.data.departmentview == "on" ? true : false,
          departmentDelete:
              userPermissionModel.data.departmentdelete == "on" ? true : false,
        );

        // Set LoggedIn user data
        UserDetails.roleId = await userPreference.getIntValueFromPrefs(
            keyId: UserPreference.roleIdKey);
        UserDetails.userId = await userPreference.getIntValueFromPrefs(
            keyId: UserPreference.userIdKey);
        UserDetails.userName = await userPreference.getStringValueFromPrefs(
            keyId: UserPreference.userNameKey);
        UserDetails.userEmail = await userPreference.getStringValueFromPrefs(
            keyId: UserPreference.userEmailKey);
        UserDetails.userProfileImage = await userPreference
            .getStringValueFromPrefs(keyId: UserPreference.userProfileImageKey);
        // Set Role Permission in local variable
        UserDetails.roleView = await userPreference.getBoolPermissionFromPrefs(
            keyId: UserPreference.roleViewKey);
        UserDetails.roleAdd = await userPreference.getBoolPermissionFromPrefs(
            keyId: UserPreference.roleAddKey);
        UserDetails.roleEdit = await userPreference.getBoolPermissionFromPrefs(
            keyId: UserPreference.roleEditKey);
        UserDetails.roleDelete = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.roleDeleteKey);

        // Set Company Permission in local variable
        UserDetails.companyView = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.companyViewKey);
        UserDetails.companyAdd = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.companyAddKey);
        UserDetails.companyEdit = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.companyEditKey);
        UserDetails.companyDelete = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.companyDeleteKey);

        // Set Location Permission in local variable
        UserDetails.locationView = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.locationViewKey);
        UserDetails.locationAdd = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.locationAddKey);
        UserDetails.locationEdit = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.locationEditKey);
        UserDetails.locationDelete =
            await userPreference.getBoolPermissionFromPrefs(
                keyId: UserPreference.locationDeleteKey);

        // Set Employee Permission in local variable
        UserDetails.employeeView = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.employeeViewKey);
        UserDetails.employeeAdd = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.employeeAddKey);
        UserDetails.employeeEdit = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.employeeEditKey);
        UserDetails.employeeDelete =
            await userPreference.getBoolPermissionFromPrefs(
                keyId: UserPreference.employeeDeleteKey);

        // Set Department Permission in local variable
        UserDetails.departmentView =
            await userPreference.getBoolPermissionFromPrefs(
                keyId: UserPreference.departmentViewKey);
        UserDetails.departmentAdd = await userPreference
            .getBoolPermissionFromPrefs(keyId: UserPreference.departmentAddKey);
        UserDetails.departmentEdit =
            await userPreference.getBoolPermissionFromPrefs(
                keyId: UserPreference.departmentEditKey);
        UserDetails.departmentDelete =
            await userPreference.getBoolPermissionFromPrefs(
                keyId: UserPreference.departmentDeleteKey);

        if (UserDetails.roleId == 1) {
          Get.off(() => HomeScreen());
        } else if (UserDetails.roleId == 2) {
          Get.off(() => HomeScreen());
        } else if (UserDetails.roleId == 3) {
          Get.off(() => CompanyHomeScreen());
        } else if (UserDetails.roleId == 4) {
          Get.off(() => EmployeeHomeScreen());
        } else {
          Get.off(() => LoginScreen());
        }

        // Fluttertoast.showToast(msg: 'You are successfully login');
      } else {
        Fluttertoast.showToast(msg: 'user permissions not found');
      }
    } catch (e) {
      log("getUserPermissionsFunction error : $e");

      rethrow;
    } finally {
      isLoading(false);
    }
  }

  startTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Timer(
      const Duration(milliseconds: 2500),
      () async {
        bool isUserLoggedIn =
            prefs.getBool(UserPreference.isUserLoggedInKey) ?? false;

        if (isUserLoggedIn == true) {
          int roleId = prefs.getInt(UserPreference.roleIdKey) ?? 0;
          await userPreference.getUserPrefsAndSaveToLocal();
          await getUserPermissionsFunction(roleId: roleId.toString());
        
        } else {
          Get.off(() => LoginScreen());
        }
      },
    );
  }

  @override
  void onInit() {
    startTimer();

    super.onInit();
  }
}
