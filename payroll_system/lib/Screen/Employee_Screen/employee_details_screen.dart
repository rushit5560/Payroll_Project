import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Controller/employee_details_screen_controller.dart';
import 'package:payroll_system/constants/colors.dart';

import 'employee_details_screen_widget.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  EmployeeDetailsScreen({super.key});
  final employeDetailsFormController = Get.put(EmployeDetailsScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.mainBackWhitegroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.blackColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.close,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
        body: EmployeeDetailsScreenWidgets(),
      ),
    );
  }
}
