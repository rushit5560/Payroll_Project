import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
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
      child: Obx(
        () => Column(
          children: [
            PermissionContainerModule(
                labelText: AppMessage.subAdminText,
                isViewValue:
                    adminPermissionScreenController.subAdminIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  adminPermissionScreenController.subAdminIsViewChecked.value =
                      value!;
                },
                isAddValue:
                    adminPermissionScreenController.subAdminIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  adminPermissionScreenController.subAdminIsAddChecked.value =
                      value!;
                },
                isEditValue:
                    adminPermissionScreenController.subAdminIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  adminPermissionScreenController.subAdminIsEditChecked.value =
                      value!;
                },
                isDeleteValue: adminPermissionScreenController
                    .subAdminIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  adminPermissionScreenController
                      .subAdminIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.company,
                isViewValue: adminPermissionScreenController
                    .companyInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  adminPermissionScreenController.companyInIsViewChecked.value =
                      value!;
                },
                isAddValue:
                    adminPermissionScreenController.companyInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  adminPermissionScreenController.companyInIsAddChecked.value =
                      value!;
                },
                isEditValue: adminPermissionScreenController
                    .companyInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  adminPermissionScreenController.companyInIsEditChecked.value =
                      value!;
                },
                isDeleteValue: adminPermissionScreenController
                    .companyIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  adminPermissionScreenController.companyIsDeleteChecked.value =
                      value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.department,
                isViewValue: adminPermissionScreenController
                    .departmentInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  adminPermissionScreenController
                      .departmentInIsViewChecked.value = value!;
                },
                isAddValue: adminPermissionScreenController
                    .departmentInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  adminPermissionScreenController
                      .departmentInIsAddChecked.value = value!;
                },
                isEditValue: adminPermissionScreenController
                    .departmentInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  adminPermissionScreenController
                      .departmentInIsEditChecked.value = value!;
                },
                isDeleteValue: adminPermissionScreenController
                    .departmentIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  adminPermissionScreenController
                      .departmentIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.employee,
                isViewValue: adminPermissionScreenController
                    .employeeInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  adminPermissionScreenController
                      .employeeInIsViewChecked.value = value!;
                },
                isAddValue: adminPermissionScreenController
                    .employeeInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  adminPermissionScreenController.employeeInIsAddChecked.value =
                      value!;
                },
                isEditValue: adminPermissionScreenController
                    .employeeInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  adminPermissionScreenController
                      .employeeInIsEditChecked.value = value!;
                },
                isDeleteValue: adminPermissionScreenController
                    .employeeIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  adminPermissionScreenController
                      .employeeIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.location,
                isViewValue: adminPermissionScreenController
                    .locationInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  adminPermissionScreenController
                      .locationInIsViewChecked.value = value!;
                },
                isAddValue: adminPermissionScreenController
                    .locationInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  adminPermissionScreenController.locationInIsAddChecked.value =
                      value!;
                },
                isEditValue: adminPermissionScreenController
                    .locationInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  adminPermissionScreenController
                      .locationInIsEditChecked.value = value!;
                },
                isDeleteValue: adminPermissionScreenController
                    .locationIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  adminPermissionScreenController
                      .locationIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.role,
                isViewValue:
                    adminPermissionScreenController.roleInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  adminPermissionScreenController.roleInIsViewChecked.value =
                      value!;
                },
                isAddValue:
                    adminPermissionScreenController.roleInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  adminPermissionScreenController.roleInIsAddChecked.value =
                      value!;
                },
                isEditValue:
                    adminPermissionScreenController.roleInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  adminPermissionScreenController.roleInIsEditChecked.value =
                      value!;
                },
                isDeleteValue:
                    adminPermissionScreenController.roleIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  adminPermissionScreenController.roleIsDeleteChecked.value =
                      value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.payRoll,
                isViewValue: adminPermissionScreenController
                    .payrollInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  adminPermissionScreenController.payrollInIsViewChecked.value =
                      value!;
                },
                isAddValue:
                    adminPermissionScreenController.payrollInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  adminPermissionScreenController.payrollInIsAddChecked.value =
                      value!;
                },
                isEditValue: adminPermissionScreenController
                    .payrollInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  adminPermissionScreenController.payrollInIsEditChecked.value =
                      value!;
                },
                isDeleteValue: adminPermissionScreenController
                    .payrollIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  adminPermissionScreenController.payrollIsDeleteChecked.value =
                      value!;
                }),
            const SizedBox(height: 22),
            adminBackSubmitButton(context),
            const SizedBox(height: 5)
          ],
        ).commonSymmetricPadding(horizontal: 10, vertical: 10),
      ),
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
