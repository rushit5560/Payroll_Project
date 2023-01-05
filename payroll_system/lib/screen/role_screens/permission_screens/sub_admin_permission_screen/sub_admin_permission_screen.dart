import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/subadmin_permission_screen_controller.dart';
import 'package:payroll_system/utils/messaging.dart';

import 'sub_admin_permission_widgets_screen.dart';

class SubAdminPermissionScreen extends StatelessWidget {
   SubAdminPermissionScreen({super.key});
final subAdminPermissionScreenController =Get.put(SubAdminPermissionScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMessage.subAdminPermission),
      ),


      body:SubadminPermissionWidgetScreen() ,
    );
  }
}