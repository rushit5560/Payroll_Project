import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/custom_button_module.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/common_modules/permission_container_module.dart';
import 'package:payroll_system/controllers/subadmin_permission_screen_controller.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class SubadminPermissionWidgetScreen extends StatelessWidget {
  SubadminPermissionWidgetScreen({super.key});
  final subAdminPermissionScreenController =
      Get.find<SubAdminPermissionScreenController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [

            // Company
            PermissionBoxModule(
              labelText: AppMessage.company,

              isViewShow: true,
              isViewValue: subAdminPermissionScreenController.companyInIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                subAdminPermissionScreenController.companyInIsViewChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: subAdminPermissionScreenController.companyInIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                subAdminPermissionScreenController.companyInIsAddChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: subAdminPermissionScreenController.companyInIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                subAdminPermissionScreenController.companyInIsEditChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },


              isDeleteShow: true,
              isDeleteValue: subAdminPermissionScreenController.companyIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                // subAdminPermissionScreenController.companyIsDeleteChecked.value = value!;
              },

              isDownloadShow: false,

            ),
            const SizedBox(height: 15),

            // Department
            PermissionBoxModule(
              labelText: AppMessage.companyDepartment,

              isViewShow: true,
              isViewValue: subAdminPermissionScreenController.departmentInIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                subAdminPermissionScreenController.departmentInIsViewChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: subAdminPermissionScreenController.departmentInIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                subAdminPermissionScreenController.departmentInIsAddChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: subAdminPermissionScreenController.departmentInIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                subAdminPermissionScreenController.departmentInIsEditChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },


              isDeleteShow: true,
              isDeleteValue: subAdminPermissionScreenController.departmentIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                subAdminPermissionScreenController.departmentIsDeleteChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isDownloadShow: false,

            ),
            const SizedBox(height: 15),

            // Location
            PermissionBoxModule(
              labelText: AppMessage.companyLocation,

              isViewShow: true,
              isViewValue: subAdminPermissionScreenController.locationInIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                subAdminPermissionScreenController.locationInIsViewChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: subAdminPermissionScreenController.locationInIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                subAdminPermissionScreenController.locationInIsAddChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: subAdminPermissionScreenController.locationInIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                subAdminPermissionScreenController.locationInIsEditChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },


              isDeleteShow: true,
              isDeleteValue: subAdminPermissionScreenController.locationIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                subAdminPermissionScreenController.locationIsDeleteChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isDownloadShow: false,
            ) ,
            const SizedBox(height: 15),

            // Employee
            PermissionBoxModule(
              labelText: AppMessage.companyEmployee,

              isViewShow: true,
              isViewValue: subAdminPermissionScreenController.employeeInIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                subAdminPermissionScreenController.employeeInIsViewChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: subAdminPermissionScreenController.employeeInIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                subAdminPermissionScreenController.employeeInIsAddChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: subAdminPermissionScreenController.employeeInIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                subAdminPermissionScreenController.employeeInIsEditChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },


              isDeleteShow: true,
              isDeleteValue: subAdminPermissionScreenController.employeeIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                subAdminPermissionScreenController.employeeIsDeleteChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isDownloadShow: false,
            ),
            const SizedBox(height: 15) ,

            // Employee Document
            PermissionBoxModule(
              labelText: AppMessage.companyEmployeeDocument,

              isViewShow: true,
              isViewValue: subAdminPermissionScreenController.employeeDocumentIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                subAdminPermissionScreenController.employeeDocumentIsViewChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: subAdminPermissionScreenController.employeeDocumentIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                subAdminPermissionScreenController.employeeDocumentIsAddChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: subAdminPermissionScreenController.employeeDocumentIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                // subAdminPermissionScreenController.employeeDocumentIsEditChecked.value = value!;
              },


              isDeleteShow: true,
              isDeleteValue: subAdminPermissionScreenController.employeeDocumentIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                subAdminPermissionScreenController.employeeDocumentIsDeleteChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isDownloadShow: true,
              isDownloadValue: subAdminPermissionScreenController.employeeDocumentIsDownloadChecked.value,
              isDownloadOnChanged: (bool? value) {
                subAdminPermissionScreenController.employeeDocumentIsDownloadChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },
            ) ,
            const SizedBox(height: 15) ,

            // Company PayChecks
            PermissionBoxModule(
              labelText: AppMessage.companyPaycheckes,

              isViewShow: true,
              isViewValue: subAdminPermissionScreenController.companyPayChecksIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                subAdminPermissionScreenController.companyPayChecksIsViewChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: subAdminPermissionScreenController.companyPayChecksIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                subAdminPermissionScreenController.companyPayChecksIsAddChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: subAdminPermissionScreenController.companyPayChecksIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                // subAdminPermissionScreenController.companyPayChecksIsEditChecked.value = value!;
              },


              isDeleteShow: true,
              isDeleteValue: subAdminPermissionScreenController.companyPayChecksIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                // subAdminPermissionScreenController.companyPayChecksIsDeleteChecked.value = value!;
              },

              isDownloadShow: true,
              isDownloadValue: subAdminPermissionScreenController.companyPayChecksIsDownloadChecked.value,
              isDownloadOnChanged: (bool? value) {
                subAdminPermissionScreenController.companyPayChecksIsDownloadChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },
            ) ,
            const SizedBox(height: 15),

            // Approve PayChecks
            PermissionBoxModule(
              labelText: AppMessage.approvePaycheckes,

              isViewShow: true,
              isViewValue: subAdminPermissionScreenController.approvePayChecksIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                subAdminPermissionScreenController.approvePayChecksIsViewChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: subAdminPermissionScreenController.approvePayChecksIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                // subAdminPermissionScreenController.approvePayChecksIsAddChecked.value = value!;
              },

              isEditShow: true,
              isEditValue: subAdminPermissionScreenController.approvePayChecksIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                subAdminPermissionScreenController.approvePayChecksIsEditChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },


              isDeleteShow: true,
              isDeleteValue: subAdminPermissionScreenController.approvePayChecksIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                subAdminPermissionScreenController.approvePayChecksIsDeleteChecked.value = value!;
                subAdminPermissionScreenController.loadUI();
              },

              isDownloadShow: false,
            ) ,
            const SizedBox(height: 15),




            const SizedBox(height: 22),
            CustomSubmitButtonModule(
              labelText: AppMessage.submit,
              onPress: () async {
                await subAdminPermissionScreenController.saveUserPermissionFunction();
              },
            ),
            const SizedBox(height: 5)
          ],
        ).commonSymmetricPadding(horizontal: 10, vertical: 10),
      ),
    );
  }

}
