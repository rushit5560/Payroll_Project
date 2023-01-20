import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/employee_permission_screen_controller.dart';
import 'package:payroll_system/screen/role_screens/permission_screens/employee_permission_screen/employee_permission_widgets_screen.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class EmployeePermissionScreen extends StatelessWidget {
  EmployeePermissionScreen({super.key});

  final employeePermissionScreenController =
      Get.put(EmployeePermissionScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        title: Text(AppMessage.employeePermission,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
      ),
      body:  Obx(
        () => employeePermissionScreenController.isLoading.value
    ? CommonLoader().showLoader()
        : EmployeePermissionWidgetScreen(),),
    );
  }
}
