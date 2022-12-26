import 'package:flutter/material.dart';
import 'package:payroll_system/drawer_menu/employee_drawer/employee_drawer.dart';
import 'package:payroll_system/utils/messaging.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: EmployeeDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppMessage.employeeNameDrawer,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Get.to(() => CompanyProfileScreen());
        //     },
        //     icon: const Icon(Icons.person_rounded),
        //   ),
        // ],
      ),
    );
  }
}
