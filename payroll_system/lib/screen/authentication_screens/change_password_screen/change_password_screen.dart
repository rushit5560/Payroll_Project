import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/controllers/change_password_screen_controller.dart';
import 'package:payroll_system/screen/authentication_screens/change_password_screen/change_password_screen_widgets.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final ChangePasswordScreenController = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ChangePasswordScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : Form(
                key: ChangePasswordScreenController.formKey,
                child: Column(
                  children: [
                    Text(
                      AppMessage.changePassword,
                      style: TextStyleConfig.textStyle(
                          fontSize: 21.sp, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 50),
                    LogInCurrentPasswordTextFieldModule(),
                    SizedBox(height: 2.h),
                    LogInNewPasswordTextFieldModule(),
                  ],
                ).commonOnlyPadding(
                  top: 13.h,
                  right: 8.w,
                  left: 8.w,
                  bottom: 15.h,
                ),
              ),
      ),
    );
  }
}
