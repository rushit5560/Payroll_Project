import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/custom_button_module.dart';
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
            PermissionContainerModule(
                labelText: AppMessage.company,
                isViewValue: subAdminPermissionScreenController
                    .companyInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .companyInIsViewChecked.value = value!;
                },
                isAddValue: subAdminPermissionScreenController
                    .companyInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .companyInIsAddChecked.value = value!;
                },
                isEditValue: subAdminPermissionScreenController
                    .companyInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .companyInIsEditChecked.value = value!;
                },
                isDeleteValue: subAdminPermissionScreenController
                    .companyIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .companyIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.department,
                isViewValue: subAdminPermissionScreenController
                    .departmentInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .departmentInIsViewChecked.value = value!;
                },
                isAddValue: subAdminPermissionScreenController
                    .departmentInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .departmentInIsAddChecked.value = value!;
                },
                isEditValue: subAdminPermissionScreenController
                    .departmentInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .departmentInIsEditChecked.value = value!;
                },
                isDeleteValue: subAdminPermissionScreenController
                    .departmentIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .departmentIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.employee,
                isViewValue: subAdminPermissionScreenController
                    .employeeInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .employeeInIsViewChecked.value = value!;
                },
                isAddValue: subAdminPermissionScreenController
                    .employeeInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .employeeInIsAddChecked.value = value!;
                },
                isEditValue: subAdminPermissionScreenController
                    .employeeInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .employeeInIsEditChecked.value = value!;
                },
                isDeleteValue: subAdminPermissionScreenController
                    .employeeIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .employeeIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.location,
                isViewValue: subAdminPermissionScreenController
                    .locationInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .locationInIsViewChecked.value = value!;
                },
                isAddValue: subAdminPermissionScreenController
                    .locationInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .locationInIsAddChecked.value = value!;
                },
                isEditValue: subAdminPermissionScreenController
                    .locationInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .locationInIsEditChecked.value = value!;
                },
                isDeleteValue: subAdminPermissionScreenController
                    .locationIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .locationIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.payRoll,
                isViewValue: subAdminPermissionScreenController
                    .payrollInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .payrollInIsViewChecked.value = value!;
                },
                isAddValue: subAdminPermissionScreenController
                    .payrollInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .payrollInIsAddChecked.value = value!;
                },
                isEditValue: subAdminPermissionScreenController
                    .payrollInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .payrollInIsEditChecked.value = value!;
                },
                isDeleteValue: subAdminPermissionScreenController
                    .payrollIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  subAdminPermissionScreenController
                      .payrollIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 22),
            subAdminBackSubmitButton(context),
            const SizedBox(height: 5)
          ],
        ).commonSymmetricPadding(horizontal: 10, vertical: 10),
      ),
    );
  }

  subAdminBackSubmitButton(context) {
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
