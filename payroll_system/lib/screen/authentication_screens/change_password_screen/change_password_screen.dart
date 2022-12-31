import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/change_password_screen_controller.dart';
import 'package:payroll_system/screen/authentication_screens/change_password_screen/change_password_screen_widgets.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final changePasswordScreenController = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SafeArea(
        child: Scaffold(
          body: Obx(
            () => changePasswordScreenController.isLoading.value
                ? CommonLoader().showLoader()
                : Form(
                    key: changePasswordScreenController.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppMessage.changePassword,
                            style: TextStyleConfig.textStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.sp,
                            ),
                          ),
                          const SizedBox(height: 50),
                          CurrentPasswordTextFieldModule(),
                          SizedBox(height: 2.h),
                          NewPasswordTextFieldModule(),
                          SizedBox(height: 2.h),
                          NewConfirmPasswordTextFieldModule(),
                          SizedBox(height: 5.h),
                          ChangePasswordButtonModule(),
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
    );
  }
}
