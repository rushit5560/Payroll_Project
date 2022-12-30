import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';

import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/login_screen_controller.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/messaging.dart';
import '../../../Utils/style.dart';
import '../../../common_modules/common_loader.dart';

import 'login_screen_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginScreenController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.mainBackWhitegroundColor,
      body: SafeArea(
        child: Scaffold(
          body: Obx(
            () => loginScreenController.isLoading.value
                ? CommonLoader().showLoader()
                : SingleChildScrollView(
                    child: Form(
                      key: loginScreenController.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.logoImg,
                                width: 70.w,
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
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
                          PasswordTextFieldModule(),
                          SizedBox(height: 2.h),
                          ForgotPasswordTextModule(),
                          SizedBox(height: 1.h),
                          PrivacyPolicyCustom(),
                          SizedBox(height: 2.h),
                          LoginButtonModule(),
                          SizedBox(height: 10.h),
                          // CompanyLogInCustom(),
                        ],
                      ).commonOnlyPadding(
                        top: 13.h,
                        right: 8.w,
                        left: 8.w,
                        bottom: 15.h,
                      ),
                    ),
                  ),
          ),
        ),
      ),
      // LoginScreenBody(),
    );
  }
}
