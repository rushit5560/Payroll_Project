import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/department_manage_screen_controller.dart';
import 'package:payroll_system/utils/messaging.dart';

import 'department_manage_screen_widgets.dart';

class DepartmentManageScreen extends StatelessWidget {
  DepartmentManageScreen({Key? key}) : super(key: key);
  final departmentManageScreenController =
      Get.put(DepartmentManageScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (departmentManageScreenController.departmentOption ==
            DepartmentOption.update) {
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
            departmentManageScreenController.departmentOption ==
                    DepartmentOption.create
                ? AppMessage.departmentCreate
                : AppMessage.departmentUpdate,
          ),
          leading: departmentManageScreenController.departmentOption ==
                  DepartmentOption.update
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

        body: Obx(() => departmentManageScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : DepartmentFormModule()),


      ),
    );
  }
}
