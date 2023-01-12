import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/subadmin_permission_screen_controller.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import 'sub_admin_permission_widgets_screen.dart';

class SubAdminPermissionScreen extends StatelessWidget {
   SubAdminPermissionScreen({super.key});
final subAdminPermissionScreenController =Get.put(SubAdminPermissionScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        title: Text(AppMessage.subAdminPermission,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),),
      ),


      body:SubadminPermissionWidgetScreen() ,
    );
  }
}