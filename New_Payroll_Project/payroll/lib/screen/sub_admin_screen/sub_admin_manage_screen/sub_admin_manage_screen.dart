import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/sub_admin_manage_screen_controller.dart';
import 'package:payroll/screen/pay_checked_screen/pay_checkes_manage_screen/pay_checks_manage_widgets_screen.dart';
import 'package:payroll/screen/sub_admin_screen/sub_admin_manage_screen/sub_admin_manage_widgets_screen.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class SubAdminManageScreen extends StatelessWidget {
  SubAdminManageScreen({super.key});

  final subAdminManageScreenController =
      Get.put(SubAdminManageScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppMessage.subAdminUpdate,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
      ),
      body: Obx(() => subAdminManageScreenController.isLoading.value
          ? CommonLoader().showLoader()
          : SubAdminManageWidgetsScreen()),
    );
  }
}
