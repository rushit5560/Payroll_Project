import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/profile_screens_controller/company_profile_screen_controller.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import 'company_profile_screen_widgets.dart';

class CompanyProfileScreen extends StatelessWidget {
  CompanyProfileScreen({super.key});

  final companyProfileScreenController =
      Get.put(CompanyProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          AppMessage.updateProfile,
          style: TextStyle(fontSize: 13.sp, color: Colors.black),
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
                      children: [
                        SizedBox(height: 5.h),
                        CompanyImageModule(),
                        SizedBox(height: 4.h),
                        CompanyFormModule(),
                        SizedBox(height: 6.h),

                        CustomSubmitButtonModule(
                            onPress: () async {
                              if (companyProfileScreenController
                                  .formKey.currentState!
                                  .validate()) {
                                await companyProfileScreenController
                                    .updateCompanyProfileFunction();
                              }
                            },
                            labelText: AppMessage.submit),

                        // CompanySubmitButtonModule(),
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
