import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/company_employee_manage_screen_controller.dart';
import 'package:payroll_system/controllers/employee_manage_screen_controller.dart';
import 'package:payroll_system/screen/company_employee_screens/company_employee_manage_screen/company_employee_manage_widget_screen.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen_widget.dart';
import '../../../Utils/messaging.dart';
import '../../../common_modules/common_loader.dart';
import '../../../common_modules/custom_alert_dialog_module.dart';

class CompanyEmployeeManageScreen extends StatelessWidget {
  CompanyEmployeeManageScreen({super.key});
  final companyEmployeeManageScreenController =
      Get.put(CompanyEmployeeManageScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (companyEmployeeManageScreenController.employeeOption ==
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
              companyEmployeeManageScreenController.employeeOption ==
                      EmployeeOption.create
                  ? AppMessage.employeeCreate
                  : AppMessage.employeeUpdate,
            ),
          ),
          body: Obx(
            () => companyEmployeeManageScreenController.isLoading.value
                ? CommonLoader().showLoader()
                : CompanyEmployeeManageWidgetsScreen(),
          ),
        ),
      ),
    );
  }
}
