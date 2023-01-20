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

        await userPreference.setAllPermissionIntoPrefs(
          subAdminView:
              userPermissionModel.data.subadminview == "on" ? true : false,
          subAdminAdd: roleId == "1" ? true : false,
          subAdminEdit:
              userPermissionModel.data.subadminedit == "on" ? true : false,
          subAdminDelete: false,
          companyView: roleId == "1" ? true : false,
          companyAdd:
              userPermissionModel.data.companyadd == "on" ? true : false,
          companyEdit:
              userPermissionModel.data.companyedit == "on" ? true : false,
          companyDelete: false,
          departmentView:
              userPermissionModel.data.departmentview == "on" ? true : false,
          departmentAdd:
              userPermissionModel.data.departmentadd == "on" ? true : false,
          departmentEdit:
              userPermissionModel.data.departmentedit == "on" ? true : false,
          departmentDelete:
              userPermissionModel.data.departmentdelete == "on" ? true : false,
          locationView:
              userPermissionModel.data.locationview == "on" ? true : false,
          locationAdd:
              userPermissionModel.data.locationadd == "on" ? true : false,
          locationEdit:
              userPermissionModel.data.locationedit == "on" ? true : false,
          locationDelete:
              userPermissionModel.data.locationdelete == "on" ? true : false,
          employeeView:
              userPermissionModel.data.employeeview == "on" ? true : false,
          employeeAdd:
              userPermissionModel.data.employeeadd == "on" ? true : false,
          employeeEdit:
              userPermissionModel.data.employeeedit == "on" ? true : false,
          employeeDelete:
              userPermissionModel.data.employeedelete == "on" ? true : false,
          employeeDocumentView:
              userPermissionModel.data.employeedocumentview == "on"
                  ? true
                  : false,
          employeeDocumentAdd:
              userPermissionModel.data.employeedocumentadd == "on"
                  ? true
                  : false,
          employeeDocumentEdit: false,
          employeeDocumentDelete:
              userPermissionModel.data.employeedocumentdelete == "on"
                  ? true
                  : false,
          employeeDocumentDownload:
              userPermissionModel.data.employeedocumentdownload == "on"
                  ? true
                  : false,
          payChecksView:
              userPermissionModel.data.payrollview == "on" ? true : false,
          payChecksAdd:
              userPermissionModel.data.payrolladd == "on" ? true : false,
          payChecksEdit: false,
          payChecksDelete: false,
          payChecksDownload:
              userPermissionModel.data.payrolldownload == "on" ? true : false,
          approvePayChecksView:
              userPermissionModel.data.approvepaychecksview == "on"
                  ? true
                  : false,
          approvePayChecksAdd: false,
          approvePayChecksEdit:
              userPermissionModel.data.approvepaychecksedit == "on"
                  ? true
                  : false,
          approvePayChecksDelete:
              userPermissionModel.data.approvepaychecksdelete == "on"
                  ? true
                  : false,
          emailTemplateView:
              userPermissionModel.data.emailtemplateview == "on" ? true : false,
          emailTemplateAdd:
              userPermissionModel.data.emailtemplateadd == "on" ? true : false,
          emailTemplateEdit:
              userPermissionModel.data.emailtemplateedit == "on" ? true : false,
          roleView: roleId == "1" ? true : false,
          roleEdit: roleId == "1" ? true : false,
        );

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
