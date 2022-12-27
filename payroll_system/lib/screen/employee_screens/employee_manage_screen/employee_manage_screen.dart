import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/anums.dart';
import 'package:payroll_system/controllers/employee_manage_screen_controller.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen_widget.dart';
import '../../../Utils/messaging.dart';
import '../../../common_modules/common_loader.dart';
import '../../../common_modules/custom_alert_dialog_module.dart';

class EmployeeManageScreen extends StatelessWidget {
  EmployeeManageScreen({super.key});
  final employeDetailsFormController = Get.put(EmployeManageScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (employeDetailsFormController.employeeOption ==
            EmployeeOption.update) {
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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              employeDetailsFormController.employeeOption ==
                      EmployeeOption.create
                  ? AppMessage.employeeCreate
                  : AppMessage.employeeUpdate,
            ),
          ),
          body: Obx(
            () => employeDetailsFormController.isLoading.value
                ? CommonLoader().showLoader()
                : EmployeeManageScreenWidgets(),
          ),
        ),
      ),
    );
  }
}
