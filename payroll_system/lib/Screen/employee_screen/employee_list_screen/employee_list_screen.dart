import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Screen/Employee_Screen/employee_manage_screen/employee_manage_screen.dart';
import 'package:payroll_system/Screen/employee_screen/Employee_list_screen/employee_list_screen_widgets.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/controllers/employee_list_screen_controller.dart';

import '../../../constants/anums.dart';
import '../../company_manage_screen/company_manage_screen.dart';

class EmployeeListScreen extends StatelessWidget {
  EmployeeListScreen({super.key});

  final employeeListScreenController = Get.put(EmployeeListScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppMessage.employeeList),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(
                  () => EmployeeManageScreen(),
                  arguments: [CompanyOption.create, ""],
                );
              },
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
        body: Obx(
          () => employeeListScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : EmployeeListScreenWidgets(),
        ),
      ),
    );
  }
}
