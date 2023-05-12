// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:payroll_system/models/success_models/success_model.dart';
// import '../utils/api_url.dart';

// class ForgotPasswordScreenController extends GetxController {
//   RxBool isLoading = false.obs;
//   RxBool isSuccessStatus = false.obs;

//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();

// //User login
//   Future<void> forgotPasswordFunction() async {
//     isLoading(true);
//     String url = ApiUrl.forgetPasswordApi;
//     // log("forgotPasswordFunction Api url : $url");

//     try {
//       Map<String, dynamic> bodyData = {
//         "email": emailController.text.trim(),
//       };

//       // log("forgotPasswordFunction passing Data :  $bodyData");

//       http.Response response = await http.post(
//         Uri.parse(url),
//         body: bodyData,
//       );

//       // log("forgotPasswordFunction response :  ${response.body}");

//       SuccessModel successModel =
//           SuccessModel.fromJson(json.decode(response.body));
//       isSuccessStatus = successModel.success.obs;

//       if (isSuccessStatus.value) {
//         log("forgotPasswordFunction isSuccessStatus :  ${isSuccessStatus.value}");

//         Fluttertoast.showToast(msg: "E-mail has been sent Successfully");
//         Get.back();
//       } else {
//         log("forgotPasswordFunction else case ");
//       }
//     } catch (e) {
//       log("forgotPasswordFunction error : $e");

//       rethrow;
//     } finally {
//       isLoading(false);
//     }
//   }
// }
