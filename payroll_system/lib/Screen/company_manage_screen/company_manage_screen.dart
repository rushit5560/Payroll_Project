import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Controller/company_manage_screen_controller.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/anums.dart';

import 'company_manage_screen_widgets.dart';

class CompanyManageScreen extends StatelessWidget {
  CompanyManageScreen({Key? key}) : super(key: key);
  final companyManageScreenController =
      Get.put(CompanyManageScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          companyManageScreenController.companyOption == CompanyOption.create
              ? AppMessage.companyCreate
              : AppMessage.companyEdit,
        ),
      ),
      body: Obx(() => companyManageScreenController.isLoading.value
          ? CommonLoader().showLoader()
          : CompanyFormModule()),
    );
  }
}
