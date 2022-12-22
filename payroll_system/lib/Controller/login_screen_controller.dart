import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/Screen/Authentication/Login_Screen/login_screen.dart';
import 'package:payroll_system/Screen/Employe_Details/employe_details_form_screen.dart';
import 'package:payroll_system/Utils/api_url.dart';
import 'package:payroll_system/Utils/extension_methods/user_details.dart';
import 'package:payroll_system/Utils/extension_methods/user_preference.dart';
import '../Models/log_in_model.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  TextEditingController loginEmailController = TextEditingController();

  // text: 'khatranireshma@gmail.com');
  TextEditingController loginPasswordController = TextEditingController();

  // text: 'abc@1234');

  //User login
  Future<void> loginFunction(BuildContext context) async {
    isLoading(true);
    String url = ApiUrl.loginApi;
    log("login Api url : $url");

    try {
      Map<String, dynamic> logindata = {
        "email": loginEmailController.text.trim(),
        "password": loginPasswordController.text.trim()
      };
      log("Body Data :  $logindata");

      http.Response response = await http.post(Uri.parse(url), body: logindata);
      log("loginFunction response :  ${response.body}");

      LogInDetails logInDetails =
          LogInDetails.fromJson(json.decode(response.body));
      isSuccessStatus = logInDetails.success.obs;

      if (isSuccessStatus.value) {
        log("isSuccessStatus :  ${isSuccessStatus.value}");
        Fluttertoast.showToast(msg: logInDetails.messege);
        UserPreference().setUserDetails(
          // selfId: logInDetails.data.id,
          userId: logInDetails.data.data.id,
          userName: logInDetails.data.data.userName,
          userEmail: logInDetails.data.data.email,
          userProfileImage: logInDetails.data.data.photo,
          // token: token,
          roleId: logInDetails.data.data.roleId,
          userFullName: logInDetails.data.data.fullName,
          userActivate: logInDetails.data.data.isActive,
          // shopName: logInDetails.data.data.s
          userAddress: logInDetails.data.data.address,
          userPhoneNo: logInDetails.data.data.phoneno,
          userCreatedAt: logInDetails.data.data.createdAt,
          userUpdatedAt: logInDetails.data.data.updatedAt,
        );

        Get.off(() => EmployeDetailsScreen());

        formKey.currentState!.reset();
        Fluttertoast.showToast(msg: 'You are successfully login');
      } else {
        Fluttertoast.showToast(msg: 'You are not able to login');
      }
    } catch (e) {
      log("user login error : $e");
    } finally {
      isLoading(false);
    }
  }

  startTimer() async {
    // var sharedPref = await SharedPreferences.getInstance();
    // var isLoggedIn = sharedPref.getBool(UserDetails.userName);

    Timer(const Duration(seconds: 1), () async {
      //if admin is loggedin already
      if (UserDetails.isUserLoggedIn != null) {
        if (UserDetails.isUserLoggedIn) {
          Get.off(() => EmployeDetailsScreen());
        } else {
          Get.off(() => LoginScreen());
        }
      } else {
        Get.off(() => LoginScreen());
      }
    });
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }
}
