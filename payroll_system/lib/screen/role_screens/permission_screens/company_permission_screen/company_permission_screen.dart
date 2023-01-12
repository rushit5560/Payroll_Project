import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/company_Permission_Screen_Controller.dart';
import 'package:payroll_system/screen/role_screens/permission_screens/company_permission_screen/company_permission_widgets_screen.dart';

import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class CompanyPermissionScreen extends StatelessWidget {
   CompanyPermissionScreen({super.key});


   final companyPermissionScreenController =Get.put(CompanyPermissionScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        title: Text(AppMessage.companyPermission,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
      ),
      body: CompanyPermissionWidgetScreen(),
    );
  }
}
