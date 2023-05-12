import 'package:flutter/material.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/screen/role_screens/role_manage_screen/role_list_widgets_screen.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/messaging.dart';

class RoleListScreen extends StatelessWidget {
  const RoleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppMessage.role,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),),
      ),
      body: Column(
        children: const [
          AdminPermissionContainer(),
          SizedBox(height: 15),
          SubAdminPermissionContainer(),
          SizedBox(height: 15),
          CompanyPermissionContainer(),
          SizedBox(height: 15),
          EmployeePermissionContainer(),

        ],
      ).commonOnlyPadding(top: 20, right: 20, left: 20, bottom: 20),
    );
  }
}
