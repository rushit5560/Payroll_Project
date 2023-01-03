import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/company_home_screen_controller.dart';
import 'package:payroll_system/screen/company_employee_screens/company_employee_manage_screen/company_employee_manage_screen.dart';
import 'package:payroll_system/screen/company_employee_screens/company_home_screen/company_home_widgets_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import '../../employee_screens/employee_manage_screen/employee_manage_screen.dart';

class CompanyHomeScreen extends StatelessWidget {
  CompanyHomeScreen({super.key});

  final companyHomeScreenController = Get.put(CompanyHomeScreenController());
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: CompanyDrawerMenu(),
      appBar: AppBar(
        title: Text(AppMessage.company),
        centerTitle: true,
        actions: [
          FloatingActionButton(
            onPressed: () async {
              bool employeeCreatePermission =
                  await userPreference.getBoolPermissionFromPrefs(
                      keyId: UserPreference.employeeAddKey);

              if (employeeCreatePermission == true) {
                Get.to(
                  () => CompanyEmployeeManageScreen(),
                  arguments: [
                    EmployeeOption.create,
                    AppMessage.empty,
                    companyHomeScreenController.companyId.toString(),
                    companyHomeScreenController.companyName,
                  ],
                );
              } else {
                Fluttertoast.showToast(msg: AppMessage.deniedPermission);
              }
            },
            tooltip: "Add Employee",
            elevation: 0.0,
            child: const Icon(
              Icons.add_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      body: Obx(
        () => companyHomeScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : companyHomeScreenController.allCompanyWiseEmployeeList.isEmpty
                ? Center(child: Text(AppMessage.noEmpFound))
                : Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppMessage.employeeList,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ).commonAllSidePadding(10)
                        ],
                      ),
                      Expanded(child: CompanyHomeScreenWidgets()),
                    ],
                  ),
      ),
    );
  }
}
