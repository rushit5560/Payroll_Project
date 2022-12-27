import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/controllers/employee_list_screen_controller.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen.dart';

import '../../../constants/enums.dart';
import 'employee_list_screen_widgets.dart';

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
                  arguments: [EmployeeOption.create, ""],
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
