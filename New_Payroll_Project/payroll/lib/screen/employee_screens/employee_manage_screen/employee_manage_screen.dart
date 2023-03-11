import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/constants/enums.dart';
import 'package:payroll/controllers/employee_manage_screen_controller.dart';
import 'package:payroll/screen/employee_screens/employee_manage_screen/employee_manage_screen_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/messaging.dart';
import '../../../common_modules/common_loader.dart';
import '../../../common_modules/custom_alert_dialog_module.dart';

class EmployeeManageScreen extends StatelessWidget {
  EmployeeManageScreen({super.key});

  final employeeDetailsFormController = Get.put(EmployeeManageScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (employeeDetailsFormController.employeeOption ==
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
          backgroundColor: AppColors.colorLightPurple2,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              employeeDetailsFormController.employeeOption ==
                      EmployeeOption.create
                  ? AppMessage.employeeCreate
                  : AppMessage.employeeUpdate,
              style: TextStyle(
                color: AppColors.colorBlack,
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
              ),
            ),
            leading: employeeDetailsFormController.employeeOption ==
                    EmployeeOption.update
                ? IconButton(
                    onPressed: () => CustomAlertDialog().showAlertDialog(
                      context: context,
                      textContent: AppMessage.permissionMessage,
                      onYesTap: () {
                        Get.back();
                        Get.back();
                      },
                      onCancelTap: () => Get.back(),
                    ),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  )
                : null,
          ),
          body: Obx(
            () => employeeDetailsFormController.isLoading.value
                ? CommonLoader().showLoader()
                : EmployeeManageScreenWidgets(),
          ),
        ),
      ),
    );
  }
}
