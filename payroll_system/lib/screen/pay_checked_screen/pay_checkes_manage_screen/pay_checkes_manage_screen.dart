import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/controllers/pay_checked_manage_screen_controller.dart';
import 'package:payroll_system/screen/pay_checked_screen/pay_checkes_manage_screen/pay_checks_manage_widgets_screen.dart';
import 'package:payroll_system/utils/messaging.dart';



class PayCheckedManageScreen extends StatelessWidget {
  PayCheckedManageScreen({super.key});

  final payCheckedManageScreenController =
      Get.put(PayCheckedManageScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppMessage.createPaychecks),
      ),
      body: Obx(() => payCheckedManageScreenController.isLoading.value
          ? CommonLoader().showLoader()
          : PayChecksWidgetsScreen()),
    );
  }
}
