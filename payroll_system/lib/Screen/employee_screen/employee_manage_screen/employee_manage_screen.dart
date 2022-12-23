import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controller/employee_details_screen_controller.dart';
import '../../../Utils/messaging.dart';
import 'employee_manage_screen_widget.dart';

class EmployeeManageScreen extends StatelessWidget {
  EmployeeManageScreen({super.key});
  final employeDetailsFormController =
      Get.put(EmployeDetailsScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppMessage.createEmployee),
        ),
        body: EmployeeDetailsScreenWidgets(),
      ),
    );
  }
}
