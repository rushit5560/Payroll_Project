import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll/controllers/employee_permission_screen_controller.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/messaging.dart';
import '../../../../common_modules/permission_container_module.dart';


class EmployeePermissionWidgetScreen extends StatelessWidget {
  EmployeePermissionWidgetScreen({super.key});
  final employeePermissionScreenController =
      Get.find<EmployeePermissionScreenController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            // Employee Document
            PermissionBoxModule(
              labelText: AppMessage.employeeDocument,
              isViewShow: true,
              isViewValue: employeePermissionScreenController.empDocumentIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                employeePermissionScreenController.empDocumentIsViewChecked.value = value!;
              },
              isAddShow: true,
              isAddValue: employeePermissionScreenController.empDocumentIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                employeePermissionScreenController.empDocumentIsAddChecked.value = value!;
              },
              isEditShow: true,
              isEditValue: employeePermissionScreenController.empDocumentIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                // employeePermissionScreenController.empDocumentIsEditChecked.value = value!;
              },
              isEditFillColor: MaterialStateProperty.all(Colors.grey.shade300),
              isDeleteShow: true,
              isDeleteValue: employeePermissionScreenController.empDocumentIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                // employeePermissionScreenController.empDocumentIsDeleteChecked.value = value!;
              },
              isDeleteFillColor: MaterialStateProperty.all(Colors.grey.shade300),

              isDownloadShow: true,
              isDownloadValue: employeePermissionScreenController.empDocumentIsDownloadChecked.value,
              isDownloadOnChanged: (bool? value) {
                employeePermissionScreenController.empDocumentIsDownloadChecked.value = value!;
              },
            ),
            const SizedBox(height: 15),

            // Employee Paychecks
            PermissionBoxModule(
              labelText: AppMessage.employeePaycheckes,

              isViewShow: true,
              isViewValue: employeePermissionScreenController.employeePayChecksIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                employeePermissionScreenController.employeePayChecksIsViewChecked.value = value!;
              },

              isAddShow: true,
              isAddValue: employeePermissionScreenController.employeePayChecksIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                // employeePermissionScreenController.employeePayChecksIsAddChecked.value = value!;
              },
              isAddFillColor: MaterialStateProperty.all(Colors.grey.shade300),

              isEditShow: true,
              isEditValue: employeePermissionScreenController.employeePayChecksIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                // employeePermissionScreenController.employeePayChecksIsEditChecked.value = value!;
              },
              isEditFillColor: MaterialStateProperty.all(Colors.grey.shade300),


              isDeleteShow: true,
              isDeleteValue: employeePermissionScreenController.employeePayChecksIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                // employeePermissionScreenController.employeePayChecksIsDeleteChecked.value = value!;
              },
              isDeleteFillColor: MaterialStateProperty.all(Colors.grey.shade300),

              isDownloadShow: true,
              isDownloadValue: employeePermissionScreenController.employeePayChecksIsDownloadChecked.value,
              isDownloadOnChanged: (bool? value) {
                employeePermissionScreenController.employeePayChecksIsDownloadChecked.value = value!;
              },
            ) ,
            const SizedBox(height: 22),
            CustomSubmitButtonModule(
              labelText: AppMessage.submit,
              onPress: () async {
                await employeePermissionScreenController.saveUserPermissionFunction();
              },
            ),
            const SizedBox(height: 5),
          ],
        ).commonSymmetricPadding(horizontal: 10, vertical: 10),
      ),
    );
  }


}
