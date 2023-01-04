import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/employee_view_screen_controller.dart';

class EmployeeViewScreen extends StatelessWidget {
  EmployeeViewScreen({Key? key}) : super(key: key);
  final employeeViewScreenController = Get.put(EmployeeViewScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: CompanyDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(employeeViewScreenController.companyName),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.home_rounded),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome To ${employeeViewScreenController.companyName}'),
      ),
    );
  }
}
