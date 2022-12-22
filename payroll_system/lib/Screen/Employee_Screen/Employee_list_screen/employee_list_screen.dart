import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Screen/Employee_Screen/Employee_list_screen/employee_list_screen_widgets.dart';
import 'package:payroll_system/Screen/Employee_Screen/employee_details_screen.dart';
import 'package:payroll_system/Utils/messaging.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

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
                  () => EmployeeDetailsScreen(),
                );
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: EmployeeListScreenWidgets(),
      ),
    );
  }
}
