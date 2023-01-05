import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/Utils/api_url.dart';
import 'package:payroll_system/Utils/extension_methods/user_preference.dart';
import 'package:payroll_system/screen/company_employee_screens/company_home_screen/company_home_screen.dart';
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
    // log("loginUserFunction Api url : $url");

    try {
      Map<String, dynamic> bodyData = {
        "email": loginEmailController.text.trim(),
        "password": loginPasswordController.text.trim()
      };

      // log("loginUserFunction passing Data : $bodyData");

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
      } else {
        if (loginDetailsModel.error
            .toLowerCase()
            .contains("email don't match")) {
          Fluttertoast.showToast(msg: loginDetailsModel.error);
        } else if (loginDetailsModel.error
            .toLowerCase()
            .contains("password don't match")) {
          Fluttertoast.showToast(msg: loginDetailsModel.error);
        }
      }
    } catch (e) {
      log("user login error : $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
