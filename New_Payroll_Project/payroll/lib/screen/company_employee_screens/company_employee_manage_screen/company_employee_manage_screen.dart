import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/constants/enums.dart';
import 'package:payroll/controllers/company_employee_manage_screen_controller.dart';
import 'package:payroll/screen/company_employee_screens/company_employee_manage_screen/company_employee_manage_widget_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/messaging.dart';
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
        if (companyEmployeeManageScreenController.employeeOption == EmployeeOption.update) {
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
        backgroundColor: AppColors.colorLightPurple2,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            companyEmployeeManageScreenController.employeeOption ==
                    EmployeeOption.create
                ? AppMessage.employeeCreate
                : AppMessage.employeeUpdate,
            style: TextStyle(
              color: AppColors.colorBlack,
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            ),
          ),
        ),
        body: Obx(
          () => companyEmployeeManageScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : CompanyEmployeeManageWidgetsScreen(),
        ),
      ),
    );
  }
}
