import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/admin_permission_screen_controller.dart';
import 'package:payroll/screen/role_screens/permission_screens/admin_permission/admin_permission_widget_screen.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class AdminPermissionScreen extends StatelessWidget {
  AdminPermissionScreen({super.key});

  final adminPermissionScreenController =
      Get.put(AdminPermissionScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppMessage.adminPermission,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
      ),
      body: Obx(
        () => adminPermissionScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : AdminPermissionWidgetsScreen(),
      ),
    );
  }
}
