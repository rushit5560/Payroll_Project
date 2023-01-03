import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/company_view_screen_controller.dart';
import 'package:payroll_system/controllers/employee_view_screen_controller.dart';
import 'package:payroll_system/drawer_menu/company_drawer/company_drawer.dart';

class EmployeeViewScreen extends StatelessWidget {
  EmployeeViewScreen({Key? key}) : super(key: key);
  final employeeViewScreenController = Get.put(EmployeeViewScreenController());
  // final companyViewScreenController = Get.find<CompanyViewScreenController>();
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
              // Get.offAll(()=> HomeScreen());
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
