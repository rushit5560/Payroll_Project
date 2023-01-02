import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/controllers/employee_list_screen_controller.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/enums.dart';
import 'employee_list_screen_widgets.dart';

class EmployeeListScreen extends StatelessWidget {
  EmployeeListScreen({super.key});

  final employeeListScreenController = Get.put(EmployeeListScreenController());
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(employeeListScreenController.companyName),
          centerTitle: true,
          actions: [
            FloatingActionButton(
              onPressed: () async {
                bool employeeCreatePermission =
                    await userPreference.getBoolPermissionFromPrefs(
                        keyId: UserPreference.employeeAddKey);

                if (employeeCreatePermission == true) {
                  Get.to(
                    () => EmployeeManageScreen(),
                    arguments: [
                      EmployeeOption.create,
                      AppMessage.empty,
                      employeeListScreenController.companyId,
                      employeeListScreenController.companyName,
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
          () => employeeListScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : employeeListScreenController.allEmployeeList.isEmpty
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
                        Expanded(child: EmployeeListScreenWidgets()),
                      ],
                    ),
        ),
      ),
    );
  }
}
