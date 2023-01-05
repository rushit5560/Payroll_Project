import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/controllers/admin_permission_screen_controller.dart';
import 'package:payroll_system/screen/role_screens/permission_screens/admin_permission/admin_permission_widget_screen.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';

class AdminPermissionScreen extends StatelessWidget {
  AdminPermissionScreen({super.key});
  final adminPermissionScreenController =
      Get.put(AdminPermissionScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMessage.adminPermission),
      ),
      body: AdminPermissionWidgetsScreen(),


    );
  }
}




