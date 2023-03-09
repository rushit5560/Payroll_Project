import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/models/change_password_model.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import '../utils/api_url.dart';

class ChangePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = true.obs;
  RxBool isNewPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  RxBool successStatus = false.obs;
  UserPreference userPreference = UserPreference();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newConfirmPasswordController = TextEditingController();

  RxInt roleId = 0.obs;

  getRoleIdFunctionFromPrefs() async {
    // isLoading(true);

    int roleIdPrefs = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.roleIdKey);
    roleId.value = roleIdPrefs;
    log('roleIdPrefs: $roleIdPrefs');
    log('userid: ${roleId.value}');

    // isLoading(false);
  }

  Future<void> changePasswordFunction() async {
    isLoading(true);
    String url = ApiUrl.changePasswordApi;
    log('changePasswordFunction Url : $url');

    int userId = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.userIdKey);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      log("userid:: $userId");
      request.fields['userid'] = "$userId";
      request.fields['oldpassword'] = oldPasswordController.text.trim();
      request.fields['password'] = newPasswordController.text.trim();
      request.fields['password_confirmation'] =
          newConfirmPasswordController.text.trim();
      log('changePasswordFunction fields ${request.fields}');
      var response = await request.send();

      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) {
        log('changePasswordFunction response: $value');
        ChangePasswordModel changePasswordModel =
            ChangePasswordModel.fromJson(json.decode(value));

        successStatus.value = changePasswordModel.success;

        if (successStatus.value) {
          Fluttertoast.showToast(msg: changePasswordModel.message);
          clearChangePasswordFieldsFunction();
          Get.back();
        } else {
          Fluttertoast.showToast(msg: changePasswordModel.message);
          log('False False');
        }
      });
    } catch (e) {
      log('changePasswordFunction Error : $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  clearChangePasswordFieldsFunction() {
    oldPasswordController.clear();
    newPasswordController.clear();
    newConfirmPasswordController.clear();
  }

  @override
  void onInit() {
    getRoleIdFunctionFromPrefs();

    super.onInit();
  }
}
