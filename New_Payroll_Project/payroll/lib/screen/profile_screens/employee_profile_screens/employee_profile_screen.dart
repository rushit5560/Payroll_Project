import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/profile_screens_controller/employee_profile_screen_controller.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:sizer/sizer.dart';
import 'employee_profile_screen_widgets.dart';

class EmployeeProfileScreen extends StatelessWidget {
  EmployeeProfileScreen({super.key});

  final employeeProfileScreenController =
      Get.put(EmployeeProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Obx(
          () => employeeProfileScreenController.isLoading.value
              ? Container()
              : Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  employeeProfileScreenController.firstNameController.text +
                      " ${employeeProfileScreenController.lastNameController.text}",
                  style: TextStyle(
                    color: AppColors.colorBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => employeeProfileScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.h),
                        EmployeeImageModule(),
                        SizedBox(height: 4.h),
                        EmployeeFormModule(),
                        SizedBox(height: 6.h),

                        CustomSubmitButtonModule(
                            onPress: () async {
                              if (employeeProfileScreenController
                                  .formKey.currentState!
                                  .validate()) {
                                await employeeProfileScreenController
                                    .updateEmployeeProfileFunction();
                              }
                            },
                            labelText: AppMessage.submit),
                        // EmployeeSubmitButtonModule(),
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
