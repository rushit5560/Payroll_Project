import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/employee_manage_screen_controller.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen_widget.dart';
import '../../../Utils/messaging.dart';
import '../../../common_modules/common_loader.dart';

class EmployeeManageScreen extends StatelessWidget {
  EmployeeManageScreen({super.key});
  final employeDetailsFormController = Get.put(EmployeManageScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppMessage.createEmployee),
        ),
        body: Obx(
          () => employeDetailsFormController.isLoading.value
              ? CommonLoader().showLoader()
              : EmployeeManageScreenWidgets(),
        ),
      ),
    );
  }
}
