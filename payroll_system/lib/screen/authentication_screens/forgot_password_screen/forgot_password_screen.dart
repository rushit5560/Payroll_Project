import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/forgot_password_screen_controller.dart';
import 'package:sizer/sizer.dart';

import 'forgot_password_screen_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final forgotPasswordScreenController =
      Get.put(ForgotPasswordScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.blackColor,
          ),
        ),
      ),
      body: Obx(
        () => forgotPasswordScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 5.h),
                        ForgotPassTextModule(),
                        SizedBox(height: 6.h),
                        EmailFieldModule(),
                        SizedBox(height: 5.h),
                        SubmitButtonModule(),
                        SizedBox(height: 3.h),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
