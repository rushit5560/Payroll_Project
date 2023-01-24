import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/sub_admin_manage_screen_controller.dart';

class SubAdminManageScreen extends StatelessWidget {
  SubAdminManageScreen({super.key});

  final subAdminManageScreenController =
      Get.put(SubAdminManageScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
