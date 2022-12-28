import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/Utils/api_url.dart';
import 'package:payroll_system/Utils/extension_methods/user_preference.dart';
import 'package:payroll_system/screen/company_home_screen/company_home_screen.dart';
import 'package:payroll_system/screen/employee_home_screen/employee_home_screen.dart';
import '../Models/log_in_model.dart';
import '../Screen/Home_Screen/home_screen.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  UserPreference userPreference = UserPreference();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  RxBool isPasswordVisible = true.obs;
  RxBool isPrivacyChecked = false.obs;

  //User login
  Future<void> loginUserFunction(BuildContext context) async {
    isLoading(true);
    String url = ApiUrl.loginApi;
    log("loginUserFunction Api url : $url");

    try {
      Map<String, dynamic> bodyData = {
        "email": loginEmailController.text.trim(),
        "password": loginPasswordController.text.trim()
      };

      log("loginUserFunction passing Data :  $bodyData");

      http.Response response = await http.post(Uri.parse(url), body: bodyData);
      log("loginUserFunction response :  ${response.body}");

      LoginDetailsModel loginDetailsModel =
          LoginDetailsModel.fromJson(json.decode(response.body));
      isSuccessStatus = loginDetailsModel.success.obs;

      if (isSuccessStatus.value) {
        log("loginUserFunction isSuccessStatus :  ${isSuccessStatus.value}");

        Fluttertoast.showToast(msg: loginDetailsModel.messege);

        await userPreference.setUserLoginDetailsToPrefs(
          isLoggedIn: true,
          userId: loginDetailsModel.loginData.data.id,
          roleId: loginDetailsModel.loginData.data.roleId,
          userName: loginDetailsModel.loginData.data.userName,
          userEmail: loginDetailsModel.loginData.data.email,
          userProfileImage: loginDetailsModel.loginData.data.photo,
        );

        await userPreference
            .setUserPermissionsToPrefsAndLocal(
          //role
          roleAdd: loginDetailsModel.loginData.permissiondata.roleadd == "on"
              ? true
              : false,
          roleEdit: loginDetailsModel.loginData.permissiondata.roleedit == "on"
              ? true
              : false,
          roleView: loginDetailsModel.loginData.permissiondata.roleview == "on"
              ? true
              : false,
          roleDelete:
              loginDetailsModel.loginData.permissiondata.roledelete == "on"
                  ? true
                  : false,
          // company
          companyAdd:
              loginDetailsModel.loginData.permissiondata.companyadd == "on"
                  ? true
                  : false,
          companyEdit:
              loginDetailsModel.loginData.permissiondata.companyedit == "on"
                  ? true
                  : false,
          companyView:
              loginDetailsModel.loginData.permissiondata.companyview == "on"
                  ? true
                  : false,
          companyDelete:
              loginDetailsModel.loginData.permissiondata.companydelete == "on"
                  ? true
                  : false,
          // location
          locationAdd:
              loginDetailsModel.loginData.permissiondata.locationadd == "on"
                  ? true
                  : false,
          locationEdit:
              loginDetailsModel.loginData.permissiondata.locationedit == "on"
                  ? true
                  : false,
          locationView:
              loginDetailsModel.loginData.permissiondata.locationview == "on"
                  ? true
                  : false,
          locationDelete:
              loginDetailsModel.loginData.permissiondata.locationdelete == "on"
                  ? true
                  : false,
          // employee
          employeeAdd:
              loginDetailsModel.loginData.permissiondata.employeeadd == "on"
                  ? true
                  : false,
          employeeEdit:
              loginDetailsModel.loginData.permissiondata.employeeedit == "on"
                  ? true
                  : false,
          employeeView:
              loginDetailsModel.loginData.permissiondata.employeeview == "on"
                  ? true
                  : false,
          employeeDelete:
              loginDetailsModel.loginData.permissiondata.employeedelete == "on"
                  ? true
                  : false,
          // department
          departmentAdd:
              loginDetailsModel.loginData.permissiondata.departmentadd == "on"
                  ? true
                  : false,
          departmentEdit:
              loginDetailsModel.loginData.permissiondata.departmentedit == "on"
                  ? true
                  : false,
          departmentView:
              loginDetailsModel.loginData.permissiondata.departmentview == "on"
                  ? true
                  : false,
          departmentDelete:
              loginDetailsModel.loginData.permissiondata.departmentdelete ==
                      "on"
                  ? true
                  : false,
        )
            .whenComplete(() {
          // Reset the form
          // formKey.currentState!.reset();

          /// Role wise route set
          if (loginDetailsModel.loginData.data.roleId == 1) {
            Get.off(() => HomeScreen());
          } else if (loginDetailsModel.loginData.data.roleId == 2) {
            Get.off(() => HomeScreen());
          } else if (loginDetailsModel.loginData.data.roleId == 3) {
            Get.off(() => CompanyHomeScreen());
          } else if (loginDetailsModel.loginData.data.roleId == 4) {
            Get.off(() => EmployeeHomeScreen());
          }
        });

        Fluttertoast.showToast(msg: 'You are successfully login');
      } else {
        if (loginDetailsModel.error.contains("Email don't match")) {
          Fluttertoast.showToast(msg: "Email don't match");
        } else if (loginDetailsModel.error.contains("password don't match")) {
          Fluttertoast.showToast(msg: "password don't match");
        }
      }
    } catch (e) {
      log("user login error : $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  // //User getUserPermissionsFunction
  // Future<void> getUserPermissionsFunction({
  //   required BuildContext context,
  //   required String userId,
  // }) async {
  //   isLoading(true);
  //   String url = ApiUrl.getPermissionApi + userId;
  //   log("getUserPermissionsFunction Api url : $url");

  //   try {
  //     http.Response response = await http.get(
  //       Uri.parse(url),
  //     );

  //     log("getUserPermissionsFunction response :  ${response.body}");

  //     UserPermissionModel userPermissionModel =
  //         UserPermissionModel.fromJson(json.decode(response.body));
  //     isSuccessStatus = userPermissionModel.success.obs;

  //     if (isSuccessStatus.value) {
  //       log("getUserPermissionsFunction isSuccessStatus :  ${isSuccessStatus.value}");

  //       // Fluttertoast.showToast(msg: userPermissionModel.messege);

  //       UserPreference().setUserPermissionsToPrefsAndLocal(
  //         // role
  //         roleAdd: userPermissionModel.data.roleadd == "on" ? true : false,
  //         roleEdit: userPermissionModel.data.roleedit == "on" ? true : false,
  //         roleView: userPermissionModel.data.roleview == "on" ? true : false,
  //         roleDelete:
  //             userPermissionModel.data.roledelete == "on" ? true : false,
  //         //company
  //         companyAdd:
  //             userPermissionModel.data.companyadd == "on" ? true : false,
  //         companyEdit:
  //             userPermissionModel.data.companyedit == "on" ? true : false,
  //         companyView:
  //             userPermissionModel.data.companyview == "on" ? true : false,
  //         companyDelete:
  //             userPermissionModel.data.companydelete == "on" ? true : false,
  //         //location
  //         locationAdd:
  //             userPermissionModel.data.locationadd == "on" ? true : false,
  //         locationEdit:
  //             userPermissionModel.data.locationedit == "on" ? true : false,
  //         locationView:
  //             userPermissionModel.data.locationview == "on" ? true : false,
  //         locationDelete:
  //             userPermissionModel.data.locationdelete == "on" ? true : false,
  //         //employee
  //         employeeAdd:
  //             userPermissionModel.data.employeeadd == "on" ? true : false,
  //         employeeEdit:
  //             userPermissionModel.data.employeeedit == "on" ? true : false,
  //         employeeView:
  //             userPermissionModel.data.employeeview == "on" ? true : false,
  //         employeeDelete:
  //             userPermissionModel.data.employeedelete == "on" ? true : false,
  //         //department
  //         departmentAdd:
  //             userPermissionModel.data.departmentadd == "on" ? true : false,
  //         departmentEdit:
  //             userPermissionModel.data.departmentedit == "on" ? true : false,
  //         departmentView:
  //             userPermissionModel.data.departmentview == "on" ? true : false,
  //         departmentDelete:
  //             userPermissionModel.data.departmentdelete == "on" ? true : false,
  //       );

  //       // Fluttertoast.showToast(msg: 'You are successfully login');
  //     } else {
  //       Fluttertoast.showToast(msg: 'user permissions not found');
  //     }
  //   } catch (e) {
  //     log("getUserPermissionsFunction error : $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
  }
}
