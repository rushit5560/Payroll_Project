import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/profile_screens_controller/admin_profile_screen_controller.dart';

import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/screen/profile_screens/admin_profile_screens/admin_profile_screen_widgets.dart';
import 'package:sizer/sizer.dart';

class AdminProfileScreen extends StatelessWidget {
  AdminProfileScreen({super.key});

  final adminProfileScreenController = Get.put(AdminProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          AppMessage.editProfileText,
          style: TextStyle(
            fontSize: 13.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => adminProfileScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 5.h),
                        AdminImageModule(),
                        SizedBox(height: 4.h),
                        AdminNameFieldModule(),
                        SizedBox(height: 6.h),

                        CustomSubmitButtonModule(
                            onPress: () async {
                              if (adminProfileScreenController
                                  .formKey.currentState!
                                  .validate()) {
                                await adminProfileScreenController
                                    .updateAdminProfileFunction();
                              }
                            },
                            labelText: AppMessage.submit),
                        // AdminSubmitButtonModule(),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
