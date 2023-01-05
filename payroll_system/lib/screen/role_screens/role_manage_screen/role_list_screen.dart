import 'package:flutter/material.dart';
import 'package:payroll_system/screen/role_screens/role_manage_screen/role_list_widgets_screen.dart';
import 'package:payroll_system/utils/extensions.dart';

import '../../../../utils/messaging.dart';

class RoleListScreen extends StatelessWidget {
  const RoleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppMessage.role),
      ),
      body: Column(
        children: const [
          AdminPermissionContainer(),
          SizedBox(height: 15),
          CompanyPermissionContainer(),
          SizedBox(height: 15),
          EmployeePermissionContainer(),
          SizedBox(height: 15),
          SubAdminPermissionContainer(),
        ],
      ).commonOnlyPadding(top: 20, right: 20, left: 20, bottom: 20),
    );
  }
}
