import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/payroll_manage_screen_controller.dart';
import 'package:payroll_system/screen/payroll_screen/payroll_manage_widgets_screen.dart';
import 'package:payroll_system/utils/messaging.dart';

class PayRollManageScreen extends StatelessWidget {
  PayRollManageScreen({super.key});
  final payRollScreenController = Get.put(PayRollScreenController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            // payRollScreenController.payrollOption == PayrollOption.create
            //     ? AppMessage.payRoll
            //     :

            AppMessage.payRoll,
          ),
        ),
        body: Obx(() => payRollScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : PayRollManageWidgetsScreen()),
      ),
    );
  }
}
