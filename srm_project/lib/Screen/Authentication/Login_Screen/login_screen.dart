import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:srm_project/Screen/Authentication/Login_Screen/login_screen_widget.dart';
import 'package:srm_project/Utils/extensions.dart';
import 'package:srm_project/Utils/validator.dart';
import 'package:srm_project/constants/colors.dart';

import '../../../Controller/login_screen_controller.dart';
import '../../../Utils/messaging.dart';
import '../../../Utils/style.dart';
import '../../Employe_Details/employe_details_form_screen.dart';
import '../Forgot_Password_Screen/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final loginScreenController = Get.put(LoginController());

  bool isChecked = false;
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.mainBackWhitegroundColor,
      body: SafeArea(
        child: Scaffold(
          body: Form(
            key: loginScreenController.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppMessage.logIn,
                    style: TextStyleConfig.textStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  LogInEmailTextFieldModule(),
                  SizedBox(height: 2.h),
                  TextFormField(
                    obscureText: _isHidden,
                    validator: (value) =>
                        FieldValidation().validatePassword(value!),
                    controller: loginScreenController.loginPasswordController,
                    decoration: InputDecoration(
                      hintText: AppMessage.password,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _isHidden = !_isHidden;
                          // setState(() {
                          // });
                        },
                        icon: Icon(
                          _isHidden ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(const ForgotPasswordScreen());
                        },
                        child: const Text(
                          "Forgot password ?",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.blueAccent,
                          minimumSize: const Size(200, 50),
                          maximumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                      onPressed: () {
                        if (loginScreenController.formKey.currentState!
                            .validate()) {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => EmployeDetailsScreen(),
                          //   ),
                          // );
                          loginScreenController.loginFunction(context);
                        }
                      },
                      child: Text(
                        AppMessage.logIn,
                        style: TextStyleConfig.textStyle(
                          textColor: AppColors.whiteColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  PrivacyPolicyCustom(),
                  SizedBox(height: 10.h),
                  CompanyLogInCustom(),
                ],
              ).commonOnlyPadding(
                  top: 13.h, right: 8.w, left: 8.w, bottom: 15.h),
            ),
          ),
        ),
      ),
      // LoginScreenBody(),
    );
  }
}
