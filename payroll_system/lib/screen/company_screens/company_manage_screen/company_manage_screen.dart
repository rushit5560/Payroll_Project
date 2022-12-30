import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/company_manage_screen_controller.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/constants/enums.dart';

import 'company_manage_screen_widgets.dart';

class CompanyManageScreen extends StatelessWidget {
  CompanyManageScreen({Key? key}) : super(key: key);
  final companyManageScreenController =
      Get.put(CompanyManageScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (companyManageScreenController.companyOption ==
            CompanyOption.update) {
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
            companyManageScreenController.companyOption == CompanyOption.create
                ? AppMessage.companyCreate
                : AppMessage.companyEdit,
          ),
          leading: companyManageScreenController.companyOption ==
                  CompanyOption.update
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

        body: Obx(() => companyManageScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : CompanyFormModule()),
      ),
    );
  }
}
