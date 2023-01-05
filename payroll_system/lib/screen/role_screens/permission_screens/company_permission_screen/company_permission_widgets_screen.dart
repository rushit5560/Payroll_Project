import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
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
      child: Obx(
        () => Column(
          children: [
            PermissionContainerModule(
                labelText: AppMessage.company,
                isViewValue: companyPermissionScreenController
                    .companyInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .companyInIsViewChecked.value = value!;
                },
                isAddValue: companyPermissionScreenController
                    .companyInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .companyInIsAddChecked.value = value!;
                },
                isEditValue: companyPermissionScreenController
                    .companyInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .companyInIsEditChecked.value = value!;
                },
                isDeleteValue: companyPermissionScreenController
                    .companyIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .companyIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.department,
                isViewValue: companyPermissionScreenController
                    .departmentInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .departmentInIsViewChecked.value = value!;
                },
                isAddValue: companyPermissionScreenController
                    .departmentInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .departmentInIsAddChecked.value = value!;
                },
                isEditValue: companyPermissionScreenController
                    .departmentInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .departmentInIsEditChecked.value = value!;
                },
                isDeleteValue: companyPermissionScreenController
                    .departmentIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .departmentIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.employee,
                isViewValue: companyPermissionScreenController
                    .employeeInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .employeeInIsViewChecked.value = value!;
                },
                isAddValue: companyPermissionScreenController
                    .employeeInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .employeeInIsAddChecked.value = value!;
                },
                isEditValue: companyPermissionScreenController
                    .employeeInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .employeeInIsEditChecked.value = value!;
                },
                isDeleteValue: companyPermissionScreenController
                    .employeeIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .employeeIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.location,
                isViewValue: companyPermissionScreenController
                    .locationInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .locationInIsViewChecked.value = value!;
                },
                isAddValue: companyPermissionScreenController
                    .locationInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .locationInIsAddChecked.value = value!;
                },
                isEditValue: companyPermissionScreenController
                    .locationInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .locationInIsEditChecked.value = value!;
                },
                isDeleteValue: companyPermissionScreenController
                    .locationIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .locationIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.payRoll,
                isViewValue: companyPermissionScreenController
                    .payrollInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .payrollInIsViewChecked.value = value!;
                },
                isAddValue: companyPermissionScreenController
                    .payrollInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .payrollInIsAddChecked.value = value!;
                },
                isEditValue: companyPermissionScreenController
                    .payrollInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .payrollInIsEditChecked.value = value!;
                },
                isDeleteValue: companyPermissionScreenController
                    .payrollIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  companyPermissionScreenController
                      .payrollIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 22),
            companyBackSubmitButton(context),
            const SizedBox(height: 5),
          ],
        ).commonSymmetricPadding(horizontal: 10, vertical: 10),
      ),
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
