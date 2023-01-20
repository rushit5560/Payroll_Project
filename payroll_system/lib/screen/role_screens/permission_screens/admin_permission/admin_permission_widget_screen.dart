import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/common_modules/permission_container_module.dart';
import 'package:payroll_system/controllers/admin_permission_screen_controller.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import '../../../company_employee_screens/company_employee_manage_screen/company_employee_manage_widget_screen.dart';

class AdminPermissionWidgetsScreen extends StatelessWidget {
  AdminPermissionWidgetsScreen({super.key});
  final adminPermissionScreenController =
      Get.find<AdminPermissionScreenController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: [
            // Sub Admin
            PermissionBoxModule(
              labelText: AppMessage.subAdminText,

              isViewShow: true,
              isViewValue: adminPermissionScreenController.subAdminIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                adminPermissionScreenController.subAdminIsViewChecked.value =
                value!;
                adminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: adminPermissionScreenController.subAdminIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                // adminPermissionScreenController.subAdminIsAddChecked.value = value!;
              },

              isEditShow: true,
              isEditValue: adminPermissionScreenController.subAdminIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                adminPermissionScreenController.subAdminIsEditChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },


              isDeleteShow: true,
              isDeleteValue: adminPermissionScreenController.subAdminIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                // adminPermissionScreenController.subAdminIsDeleteChecked.value = value!;
              },

              isDownloadShow: false,
            ),
            const SizedBox(height: 15),

            // Company
            PermissionBoxModule(
              labelText: AppMessage.company,

              isViewShow: true,
              isViewValue: adminPermissionScreenController.companyInIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                // adminPermissionScreenController.companyInIsViewChecked.value = value!;
              },

              isAddShow: true,
              isAddValue: adminPermissionScreenController.companyInIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                adminPermissionScreenController.companyInIsAddChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: adminPermissionScreenController.companyInIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                adminPermissionScreenController.companyInIsEditChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },


              isDeleteShow: true,
              isDeleteValue: adminPermissionScreenController.companyIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                // adminPermissionScreenController.companyIsDeleteChecked.value = value!;
              },

              isDownloadShow: false,

            ),
            const SizedBox(height: 15),

            // Department
            PermissionBoxModule(
              labelText: AppMessage.companyDepartment,

              isViewShow: true,
              isViewValue: adminPermissionScreenController.departmentInIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                adminPermissionScreenController.departmentInIsViewChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: adminPermissionScreenController.departmentInIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                adminPermissionScreenController.departmentInIsAddChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: adminPermissionScreenController.departmentInIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                adminPermissionScreenController.departmentInIsEditChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },


              isDeleteShow: true,
              isDeleteValue: adminPermissionScreenController.departmentIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                adminPermissionScreenController.departmentIsDeleteChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isDownloadShow: false,

            ),
            const SizedBox(height: 15),

            // Location
            PermissionBoxModule(
              labelText: AppMessage.companyLocation,

              isViewShow: true,
              isViewValue: adminPermissionScreenController.locationInIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                adminPermissionScreenController.locationInIsViewChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: adminPermissionScreenController.locationInIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                adminPermissionScreenController.locationInIsAddChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: adminPermissionScreenController.locationInIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                adminPermissionScreenController.locationInIsEditChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },


              isDeleteShow: true,
              isDeleteValue: adminPermissionScreenController.locationIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                adminPermissionScreenController.locationIsDeleteChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isDownloadShow: false,
            ) ,
             const SizedBox(height: 15),

            // Employee
           PermissionBoxModule(
              labelText: AppMessage.companyEmployee,

              isViewShow: true,
              isViewValue: adminPermissionScreenController.employeeInIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                adminPermissionScreenController.employeeInIsViewChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: adminPermissionScreenController.employeeInIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                adminPermissionScreenController.employeeInIsAddChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: adminPermissionScreenController.employeeInIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                adminPermissionScreenController.employeeInIsEditChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },


              isDeleteShow: true,
              isDeleteValue: adminPermissionScreenController.employeeIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                adminPermissionScreenController.employeeIsDeleteChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isDownloadShow: false,
            ),
             const SizedBox(height: 15) ,

            // Employee Document
            PermissionBoxModule(
              labelText: AppMessage.companyEmployeeDocument,

              isViewShow: true,
              isViewValue: adminPermissionScreenController.employeeDocumentIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                adminPermissionScreenController.employeeDocumentIsViewChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: adminPermissionScreenController.employeeDocumentIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                adminPermissionScreenController.employeeDocumentIsAddChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: adminPermissionScreenController.employeeDocumentIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                // adminPermissionScreenController.employeeDocumentIsEditChecked.value = value!;
              },


              isDeleteShow: true,
              isDeleteValue: adminPermissionScreenController.employeeDocumentIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                adminPermissionScreenController.employeeDocumentIsDeleteChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isDownloadShow: true,
              isDownloadValue: adminPermissionScreenController.employeeDocumentIsDownloadChecked.value,
              isDownloadOnChanged: (bool? value) {
                adminPermissionScreenController.employeeDocumentIsDownloadChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },
            ) ,
             const SizedBox(height: 15) ,

            // Company PayChecks
             PermissionBoxModule(
              labelText: AppMessage.companyPaycheckes,

              isViewShow: true,
              isViewValue: adminPermissionScreenController.companyPayChecksIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                adminPermissionScreenController.companyPayChecksIsViewChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: adminPermissionScreenController.companyPayChecksIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                adminPermissionScreenController.companyPayChecksIsAddChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: adminPermissionScreenController.companyPayChecksIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                // adminPermissionScreenController.companyPayChecksIsEditChecked.value = value!;
              },


              isDeleteShow: true,
              isDeleteValue: adminPermissionScreenController.companyPayChecksIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                // adminPermissionScreenController.companyPayChecksIsDeleteChecked.value = value!;
              },

              isDownloadShow: true,
              isDownloadValue: adminPermissionScreenController.companyPayChecksIsDownloadChecked.value,
              isDownloadOnChanged: (bool? value) {
                adminPermissionScreenController.companyPayChecksIsDownloadChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },
            ) ,
             const SizedBox(height: 15),

            // Approve PayChecks
            PermissionBoxModule(
              labelText: AppMessage.approvePaycheckes,

              isViewShow: true,
              isViewValue: adminPermissionScreenController.approvePayChecksIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                adminPermissionScreenController.approvePayChecksIsViewChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: adminPermissionScreenController.approvePayChecksIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                // adminPermissionScreenController.approvePayChecksIsAddChecked.value = value!;
              },

              isEditShow: true,
              isEditValue: adminPermissionScreenController.approvePayChecksIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                adminPermissionScreenController.approvePayChecksIsEditChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },


              isDeleteShow: true,
              isDeleteValue: adminPermissionScreenController.approvePayChecksIsDeleteChecked.value,
              isDeleteOnChanged: (bool? value) {
                adminPermissionScreenController.approvePayChecksIsDeleteChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isDownloadShow: false,
            ) ,
           const SizedBox(height: 15),

            // Email Template
             PermissionBoxModule(
              labelText: AppMessage.emailTemplate,

              isViewShow: true,
              isViewValue: adminPermissionScreenController.emailTemplateIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                adminPermissionScreenController.emailTemplateIsViewChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isAddShow: true,
              isAddValue: adminPermissionScreenController.emailTemplateIsAddChecked.value,
              isAddOnChanged: (bool? value) {
                adminPermissionScreenController.emailTemplateIsAddChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isEditShow: true,
              isEditValue: adminPermissionScreenController.emailTemplateIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                adminPermissionScreenController.emailTemplateIsEditChecked.value = value!;
                adminPermissionScreenController.loadUI();
              },

              isDeleteShow: false,
              isDownloadShow: false,
            ) ,
             const SizedBox(height: 15),

            // Role
            PermissionBoxModule(
              labelText: AppMessage.role,

              isViewShow: true,
              isViewValue: adminPermissionScreenController.roleIsViewChecked.value,
              isViewOnChanged: (bool? value) {
                // adminPermissionScreenController.roleIsViewChecked.value = value!;
              },

              isEditShow: true,
              isEditValue: adminPermissionScreenController.roleIsEditChecked.value,
              isEditOnChanged: (bool? value) {
                // adminPermissionScreenController.roleIsEditChecked.value = value!;
              },

              isAddShow: false,
              isDeleteShow: false,
              isDownloadShow: false,
            ) ,
             const SizedBox(height: 15),


            CustomSubmitButtonModule(
              labelText: AppMessage.submit,
              onPress: () async {
                await adminPermissionScreenController.saveUserPermissionFunction();
              },
            ),
            const SizedBox(height: 5)
          ],
        ).commonSymmetricPadding(horizontal: 10, vertical: 10),
    );
  }

  adminBackSubmitButton(context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ButtonCustom(
            onPressed: () {},
            text: AppMessage.submit,
            textsize: 15.sp,
          ),
        ),
        const SizedBox(width: 10),
        const Divider(),
        Expanded(
          flex: 5,
          child: ButtonCustom(
            onPressed: () => CustomAlertDialog().showAlertDialog(
              context: context,
              textContent: AppMessage.permissionMessage,
              onYesTap: () {
                Get.back();
                Get.back();
              },
              onCancelTap: () => Get.back(),
            ),
            text: AppMessage.back,
            textsize: 15.sp,
          ),
        ),
      ],
    );
  }
}
