import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:srm_project/Controller/signup_screen_controller.dart';
import 'package:srm_project/Screen/Authentication/Login_Screen/login_screen.dart';
import 'package:srm_project/Screen/Authentication/Sign_Up_Screen/sign_up_screen_widget.dart';
import 'package:srm_project/Utils/extensions.dart';
import 'package:srm_project/constants/colors.dart';
import '../../../Utils/messaging.dart';
import '../../../Utils/style.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final signUpScreenController = Get.put(SignUpScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.mainBackWhitegroundColor,
        body: Form(
          key: signUpScreenController.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppMessage.companyLogin,
                  style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                NameTextFieldModule(),
                SizedBox(height: 2.h),
                FullNameTextFieldModule(),
                SizedBox(height: 2.h),
                EmailTextFieldModule(),
                SizedBox(height: 2.h),
                MobileNumberTextFieldModule(),
                SizedBox(height: 5.h),
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
                      if (signUpScreenController.formKey.currentState!
                          .validate()) {
                        signUpScreenController.registerFunction(context);
                      }
                    },
                    child: Text(
                      AppMessage.companyLogin,
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.whiteColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppMessage.haveAlreadyAnAccount,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          LoginScreen(),
                        );
                      },
                      child: Text(
                        AppMessage.logIn,
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                )
              ],
            ).commonOnlyPadding(top: 13.h, right: 8.w, left: 8.w, bottom: 2.h),
          ),
        ),

        // SignUpScreenBody(),
      ),
    );
  }
}
