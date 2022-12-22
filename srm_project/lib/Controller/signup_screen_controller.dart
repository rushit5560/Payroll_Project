import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srm_project/Models/sign_up_model.dart';
import 'package:srm_project/Utils/api_url.dart';

import '../Utils/extension_methods/user_preference.dart';

class SignUpScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();

  /// User Registration
  Future<void> registerFunction(BuildContext context) async {
    isLoading(true);
    String url = ApiUrl.registerApi;
    log("Register Api Url : $url");

    try {
      Map<String, dynamic> registerdata = {
        "user_name": nameController.text.trim(),
        "email": signUpEmailController.text.trim(),
        "full_name": fullNameController.text.trim(),
        "phoneno": mobileNoController.text.trim(),
      };
      log("Body Data : $registerdata");

      http.Response response =
          await http.post(Uri.parse(url), body: registerdata);
      log("registerFunction response  : ${response.body}");

      RegisterModel registerModel =
          RegisterModel.fromJson(json.decode(response.body));
      isSuccessStatus = registerModel.success.obs;

      if (isSuccessStatus.value) {
        log("isSuccessStatus : ${isSuccessStatus.value}");
        Fluttertoast.showToast(msg: registerModel.messege);
         UserPreference().setUserDetails(
          // selfId: logInDetails.data.id,
          userId: registerModel.data.id,
          userName: registerModel.data.userName,
          userEmail: registerModel.data.email,
          // userProfileImage: registerModel.data.photo,
          // token: token,
          roleId: registerModel.data.roleId,
          userFullName: registerModel.data.fullName,
          userActivate: registerModel.data.isActive,
          // shopName: logInDetails.data.data.s
          // userAddress: registerModel.data.address,
          userPhoneNo: registerModel.data.phoneno,
          // userCreatedAt: registerModel.data.createdAt,
          // userUpdatedAt: registerModel.data.updatedAt,
        );

        // Get.to(() => LoginScreen());
        Get.back();

        // signUpEmailController.clear();
        // nameController.clear();
        // fullNameController.clear();
        // mobileNoController.clear();
        formKey.currentState!.reset();

        // Going to Login Screen
        // Get.offAndToNamed(AppRouteNames.loginRoute);
        Fluttertoast.showToast(msg: 'Check Your Email');
      } else {
        Fluttertoast.showToast(msg: 'Enter valid details');
      }
    } catch (e) {
      log("User Registration Error ::: $e");
    } finally {
      isLoading(false);
    }
  }
}
