import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:payroll/constants/enums.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll/controllers/payroll_manage_screen_controller.dart';
import 'package:payroll/screen/payroll_screen/payroll_list_manage_screen/payroll_manage_widgets_screen.dart';

class PayRollManageScreen extends StatelessWidget {
  PayRollManageScreen({super.key});
  final payRollManageScreenController =
      Get.put(PayRollManageScreenController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (payRollManageScreenController.payrollOption ==
            PayrollOption.update) {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return CustomMobileBackPressAlertDialog();
            },
          );
          return shouldPop!;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            payRollManageScreenController.payrollOption == PayrollOption.create
                ? AppMessage.payRollCreate
                : AppMessage.payRollUpdate,
          ),
        ),
        body: Obx(() => payRollManageScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : PayRollManageWidgetsScreen()),
      ),
    );
  }
}
