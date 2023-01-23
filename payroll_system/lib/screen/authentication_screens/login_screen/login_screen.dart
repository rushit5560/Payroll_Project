import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/common_modules/new/auth_screen_text_field_module.dart';

import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/login_screen_controller.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/validator.dart';
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
      backgroundColor: AppColors.colorLightPurple2,
      body: SafeArea(
        child: Obx(
          () => loginScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : SingleChildScrollView(
                  child: Form(
                    key: loginScreenController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
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
                        SizedBox(height: 6.h),
                        Text(
                          AppMessage.logIn,
                          style: TextStyleConfig.textStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                            textColor: AppColors.colorBtBlue,
                          ),
                        ),
                        SizedBox(height: 4.h),

                        /// Getting from common modules
                        AuthScreenTextFieldModule(
                          fieldController:
                              loginScreenController.loginEmailController,
                          hintText: AppMessage.emailAddress,
                          validate: (value) =>
                              FieldValidation().validateEmail(value!),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        // LogInEmailTextFieldModule(),
                        SizedBox(height: 2.h),

                        /// Getting from common modules
                        AuthScreenTextFieldModule(
                          fieldController:
                              loginScreenController.loginPasswordController,
                          hintText: AppMessage.password,
                          validate: (value) =>
                              FieldValidation().validatePassword(value!),
                          keyboardType: TextInputType.text,
                          obscureText:
                              loginScreenController.isPasswordVisible.value,
                          suffixIcon: IconButton(
                            onPressed: () {
                              loginScreenController.isPasswordVisible.value =
                                  !loginScreenController
                                      .isPasswordVisible.value;
                            },
                            icon: Icon(
                              loginScreenController.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.colorLightHintPurple2,
                            ),
                          ),
                        ),
                        // PasswordTextFieldModule(),
                        SizedBox(height: 1.h),
                        // ForgotPasswordTextModule(),
                        // SizedBox(height: 2.h),
                        PrivacyPolicyCustom(),
                        // SizedBox(height: 2.h),
                        LoginButtonModule(),
                        // SizedBox(height: 10.h),
                        // CompanyLogInCustom(),
                      ],
                    ).commonSymmetricPadding(horizontal: 3.h, vertical: 8.h),
                  ),
                ),
        ),
      ),
    );
  }
}
