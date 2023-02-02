import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/common_modules/permission_container_module.dart';
import 'package:payroll_system/controllers/company_Permission_Screen_Controller.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import '../../../company_employee_screens/company_employee_manage_screen/company_employee_manage_widget_screen.dart';

class CompanyPermissionWidgetScreen extends StatelessWidget {
  CompanyPermissionWidgetScreen({super.key});

  final companyPermissionScreenController =
      Get.find<CompanyPermissionScreenController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Column(
                children: [
                  // Department
                  PermissionBoxModule(
                    labelText: AppMessage.companyDepartmentNameDrawer,
                    isViewShow: true,
                    isViewValue: companyPermissionScreenController.departmentInIsViewChecked.value,
                    isViewOnChanged: (bool? value) {
                      companyPermissionScreenController.departmentInIsViewChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isAddShow: true,
                    isAddValue: companyPermissionScreenController.departmentInIsAddChecked.value,
                    isAddOnChanged: (bool? value) {
                      companyPermissionScreenController.departmentInIsAddChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isEditShow: true,
                    isEditValue: companyPermissionScreenController.departmentInIsEditChecked.value,
                    isEditOnChanged: (bool? value) {
                      companyPermissionScreenController.departmentInIsEditChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isDeleteShow: true,
                    isDeleteValue: companyPermissionScreenController.departmentIsDeleteChecked.value,
                    isDeleteOnChanged: (bool? value) {
                      companyPermissionScreenController.departmentIsDeleteChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isDownloadShow: false,

                  ),

                  // Location
                  const SizedBox(height: 15),
                  PermissionBoxModule(
                    labelText: AppMessage.companyLocation,
                    isViewShow: true,
                    isViewValue: companyPermissionScreenController.locationInIsViewChecked.value,
                    isViewOnChanged: (bool? value) {
                      companyPermissionScreenController.locationInIsViewChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isAddShow: true,
                    isAddValue: companyPermissionScreenController.locationInIsAddChecked.value,
                    isAddOnChanged: (bool? value) {
                      companyPermissionScreenController.locationInIsAddChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isEditShow: true,
                    isEditValue: companyPermissionScreenController.locationInIsEditChecked.value,
                    isEditOnChanged: (bool? value) {
                      companyPermissionScreenController.locationInIsEditChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isDeleteShow: true,
                    isDeleteValue: companyPermissionScreenController.locationIsDeleteChecked.value,
                    isDeleteOnChanged: (bool? value) {
                      companyPermissionScreenController.locationIsDeleteChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isDownloadShow: false,

                  ),

                  // Employee
                  const SizedBox(height: 15),
                  PermissionBoxModule(
                    labelText: AppMessage.companyEmployee,
                    isViewShow: true,
                    isViewValue: companyPermissionScreenController.employeeInIsViewChecked.value,
                    isViewOnChanged: (bool? value) {
                      companyPermissionScreenController.employeeInIsViewChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isAddShow: true,
                    isAddValue: companyPermissionScreenController.employeeInIsAddChecked.value,
                    isAddOnChanged: (bool? value) {
                      companyPermissionScreenController.employeeInIsAddChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isEditShow: true,
                    isEditValue: companyPermissionScreenController.employeeInIsEditChecked.value,
                    isEditOnChanged: (bool? value) {
                      companyPermissionScreenController.employeeInIsEditChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isDeleteShow: true,
                    isDeleteValue: companyPermissionScreenController.employeeIsDeleteChecked.value,
                    isDeleteOnChanged: (bool? value) {
                      companyPermissionScreenController.employeeIsDeleteChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                    isDownloadShow: false,

                  ),

                  // Employee Document
                  const SizedBox(height: 15),
                  PermissionBoxModule(
                    labelText: AppMessage.companyEmployeeDocument,

                    isViewShow: true,
                    isViewValue: companyPermissionScreenController.employeeDocumentIsViewChecked.value,
                    isViewOnChanged: (bool? value) {
                      companyPermissionScreenController.employeeDocumentIsViewChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },

                    isAddShow: true,
                    isAddValue: companyPermissionScreenController.employeeDocumentIsAddChecked.value,
                    isAddOnChanged: (bool? value) {
                      companyPermissionScreenController.employeeDocumentIsAddChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },

                    isEditShow: true,
                    isEditValue: companyPermissionScreenController.employeeDocumentIsEditChecked.value,
                    isEditOnChanged: (bool? value) {
                      // companyPermissionScreenController.employeeDocumentIsEditChecked.value = value!;
                    },
                    isEditFillColor: MaterialStateProperty.all(Colors.grey.shade300),

                    isDeleteShow: true,
                    isDeleteValue: companyPermissionScreenController.employeeDocumentIsDeleteChecked.value,
                    isDeleteOnChanged: (bool? value) {
                      companyPermissionScreenController.employeeDocumentIsDeleteChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },

                    isDownloadShow: true,
                    isDownloadValue: companyPermissionScreenController.employeeDocumentIsDownloadChecked.value,
                    isDownloadOnChanged: (bool? value) {
                      companyPermissionScreenController.employeeDocumentIsDownloadChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                  ) ,

                  // Paychecks
                  const SizedBox(height: 15),
                  PermissionBoxModule(
                    labelText: AppMessage.companyPaycheckes,

                    isViewShow: true,
                    isViewValue: companyPermissionScreenController.companyPayChecksIsViewChecked.value,
                    isViewOnChanged: (bool? value) {
                      companyPermissionScreenController.companyPayChecksIsViewChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },

                    isAddShow: true,
                    isAddValue: companyPermissionScreenController.companyPayChecksIsAddChecked.value,
                    isAddOnChanged: (bool? value) {
                      companyPermissionScreenController.companyPayChecksIsAddChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },

                    isEditShow: true,
                    isEditValue: companyPermissionScreenController.companyPayChecksIsEditChecked.value,
                    isEditOnChanged: (bool? value) {
                      // companyPermissionScreenController.companyPayChecksIsEditChecked.value = value!;
                    },
                    isEditFillColor: MaterialStateProperty.all(Colors.grey.shade300),


                    isDeleteShow: true,
                    isDeleteValue: companyPermissionScreenController.companyPayChecksIsDeleteChecked.value,
                    isDeleteOnChanged: (bool? value) {
                      // companyPermissionScreenController.companyPayChecksIsDeleteChecked.value = value!;
                    },
                    isDeleteFillColor: MaterialStateProperty.all(Colors.grey.shade300),

                    isDownloadShow: true,
                    isDownloadValue: companyPermissionScreenController.companyPayChecksIsDownloadChecked.value,
                    isDownloadOnChanged: (bool? value) {
                      companyPermissionScreenController.companyPayChecksIsDownloadChecked.value = value!;
                      companyPermissionScreenController.loadUI();
                    },
                  ) ,

                  const SizedBox(height: 22),
                  CustomSubmitButtonModule(
                    labelText: AppMessage.submit,
                    onPress: () async {
                      await companyPermissionScreenController.saveUserPermissionFunction();
                    },
                  ),
                  const SizedBox(height: 5),
                ],
              ).commonSymmetricPadding(horizontal: 10, vertical: 10),
    );
  }

  companyBackSubmitButton(context) {
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
