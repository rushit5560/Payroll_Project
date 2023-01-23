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

      log("loginUserFunction passing Data : $bodyData");

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
          userId: int.parse(loginDetailsModel.loginData.data.id.toString()),
          roleId: int.parse(loginDetailsModel.loginData.data.roleId.toString()),
          userName: loginDetailsModel.loginData.data.userName,
          userEmail: loginDetailsModel.loginData.data.email,
          userProfileImage: loginDetailsModel.loginData.data.photo,
        );

        await userPreference
            .setAllPermissionIntoPrefs(
          subAdminView:
              loginDetailsModel.loginData.permissiondata.subadminview == "on"
                  ? true
                  : false,
          subAdminAdd: loginDetailsModel.loginData.data.roleId.toString() == "1"
              ? true
              : false,
          subAdminEdit:
              loginDetailsModel.loginData.permissiondata.subadminedit == "on"
                  ? true
                  : false,
          subAdminDelete: false,
          companyView: loginDetailsModel.loginData.data.roleId.toString() == "1"
              ? true
              : false,
          companyAdd:
              loginDetailsModel.loginData.permissiondata.companyadd == "on"
                  ? true
                  : false,
          companyEdit:
              loginDetailsModel.loginData.permissiondata.companyedit == "on"
                  ? true
                  : false,
          companyDelete: false,
          departmentView:
              loginDetailsModel.loginData.permissiondata.departmentview == "on"
                  ? true
                  : false,
          departmentAdd:
              loginDetailsModel.loginData.permissiondata.departmentadd == "on"
                  ? true
                  : false,
          departmentEdit:
              loginDetailsModel.loginData.permissiondata.departmentedit == "on"
                  ? true
                  : false,
          departmentDelete:
              loginDetailsModel.loginData.permissiondata.departmentdelete ==
                      "on"
                  ? true
                  : false,
          locationView:
              loginDetailsModel.loginData.permissiondata.locationview == "on"
                  ? true
                  : false,
          locationAdd:
              loginDetailsModel.loginData.permissiondata.locationadd == "on"
                  ? true
                  : false,
          locationEdit:
              loginDetailsModel.loginData.permissiondata.locationedit == "on"
                  ? true
                  : false,
          locationDelete:
              loginDetailsModel.loginData.permissiondata.locationdelete == "on"
                  ? true
                  : false,
          employeeView:
              loginDetailsModel.loginData.permissiondata.employeeview == "on"
                  ? true
                  : false,
          employeeAdd:
              loginDetailsModel.loginData.permissiondata.employeeadd == "on"
                  ? true
                  : false,
          employeeEdit:
              loginDetailsModel.loginData.permissiondata.employeeedit == "on"
                  ? true
                  : false,
          employeeDelete:
              loginDetailsModel.loginData.permissiondata.employeedelete == "on"
                  ? true
                  : false,
          employeeDocumentView:
              loginDetailsModel.loginData.permissiondata.employeedocumentview ==
                      "on"
                  ? true
                  : false,
          employeeDocumentAdd:
              loginDetailsModel.loginData.permissiondata.employeedocumentadd ==
                      "on"
                  ? true
                  : false,
          employeeDocumentEdit: false,
          employeeDocumentDelete: loginDetailsModel
                      .loginData.permissiondata.employeedocumentdelete ==
                  "on"
              ? true
              : false,
          employeeDocumentDownload: loginDetailsModel
                      .loginData.permissiondata.employeedocumentdownload ==
                  "on"
              ? true
              : false,
          payChecksView:
              loginDetailsModel.loginData.permissiondata.payrollview == "on"
                  ? true
                  : false,
          payChecksAdd:
              loginDetailsModel.loginData.permissiondata.payrolladd == "on"
                  ? true
                  : false,
          payChecksEdit: false,
          payChecksDelete: false,
          payChecksDownload:
              loginDetailsModel.loginData.permissiondata.payrolldownload == "on"
                  ? true
                  : false,
          approvePayChecksView:
              loginDetailsModel.loginData.permissiondata.approvepaychecksview ==
                      "on"
                  ? true
                  : false,
          approvePayChecksAdd: false,
          approvePayChecksEdit:
              loginDetailsModel.loginData.permissiondata.approvepaychecksedit ==
                      "on"
                  ? true
                  : false,
          approvePayChecksDelete: loginDetailsModel
                      .loginData.permissiondata.approvepaychecksdelete ==
                  "on"
              ? true
              : false,
          emailTemplateView:
              loginDetailsModel.loginData.permissiondata.emailtemplateview ==
                      "on"
                  ? true
                  : false,
          emailTemplateAdd:
              loginDetailsModel.loginData.permissiondata.emailtemplateadd ==
                      "on"
                  ? true
                  : false,
          emailTemplateEdit:
              loginDetailsModel.loginData.permissiondata.emailtemplateedit ==
                      "on"
                  ? true
                  : false,
          roleView: loginDetailsModel.loginData.data.roleId.toString() == "1"
              ? true
              : false,
          roleEdit: loginDetailsModel.loginData.data.roleId.toString() == "1"
              ? true
              : false,
        )
            .whenComplete(() {
          if (int.parse(loginDetailsModel.loginData.data.roleId.toString()) ==
              1) {
            Get.off(() => HomeScreen());
          } else if (int.parse(
                  loginDetailsModel.loginData.data.roleId.toString()) ==
              2) {
            Get.off(() => HomeScreen());
          } else if (int.parse(
                  loginDetailsModel.loginData.data.roleId.toString()) ==
              3) {
            Get.off(() => CompanyHomeScreen());
          } else if (int.parse(
                  loginDetailsModel.loginData.data.roleId.toString()) ==
              4) {
            Get.off(() => EmployeeHomeScreen());
          }
        });
      } else {
        Fluttertoast.showToast(msg: loginDetailsModel.error.toString());
        log(loginDetailsModel.error.toString());
        // if (loginDetailsModel.error
        //     .toLowerCase()
        //     .contains("Login details not match with our records.")) {
        //   Fluttertoast.showToast(msg: loginDetailsModel.error);
        // }
        // else if (loginDetailsModel.error
        //     .toLowerCase()
        //     .contains("password don't match")) {
        //   Fluttertoast.showToast(msg: loginDetailsModel.error);
        // }
      }
    } catch (e) {
      log("user login error : $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
