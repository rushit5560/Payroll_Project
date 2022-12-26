import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/controllers/profile_screens_controller/company_profile_screen_controller.dart';
import 'package:payroll_system/controllers/profile_screens_controller/sub_admin_profile_screen_controller.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import 'company_profile_screen_widgets.dart';

class CompanyProfileScreen extends StatelessWidget {
  CompanyProfileScreen({super.key});

  final companyProfileScreenController =
      Get.put(CompanyProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          () => companyProfileScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.h),
                        CompanyImageModule(),
                        SizedBox(height: 4.h),
                        CompanyFormModule(),
                        SizedBox(height: 6.h),
                        CompanySubmitButtonModule(),
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
