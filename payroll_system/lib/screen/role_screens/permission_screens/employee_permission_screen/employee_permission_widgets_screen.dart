import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_button_module.dart';
import 'package:payroll_system/controllers/employee_permission_screen_controller.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';
import '../../../../common_modules/custom_alert_dialog_module.dart';
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
            PermissionContainerModule(
                labelText: AppMessage.company,
                isViewValue: employeePermissionScreenController
                    .companyInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .companyInIsViewChecked.value = value!;
                },
                isAddValue: employeePermissionScreenController
                    .companyInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .companyInIsAddChecked.value = value!;
                },
                isEditValue: employeePermissionScreenController
                    .companyInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .companyInIsEditChecked.value = value!;
                },
                isDeleteValue: employeePermissionScreenController
                    .companyIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .companyIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.department,
                isViewValue: employeePermissionScreenController
                    .departmentInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .departmentInIsViewChecked.value = value!;
                },
                isAddValue: employeePermissionScreenController
                    .departmentInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .departmentInIsAddChecked.value = value!;
                },
                isEditValue: employeePermissionScreenController
                    .departmentInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .departmentInIsEditChecked.value = value!;
                },
                isDeleteValue: employeePermissionScreenController
                    .departmentIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .departmentIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.employee,
                isViewValue: employeePermissionScreenController
                    .employeeInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .employeeInIsViewChecked.value = value!;
                },
                isAddValue: employeePermissionScreenController
                    .employeeInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .employeeInIsAddChecked.value = value!;
                },
                isEditValue: employeePermissionScreenController
                    .employeeInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .employeeInIsEditChecked.value = value!;
                },
                isDeleteValue: employeePermissionScreenController
                    .employeeIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .employeeIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 15),
            PermissionContainerModule(
                labelText: AppMessage.location,
                isViewValue: employeePermissionScreenController
                    .locationInIsViewChecked.value,
                isViewOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .locationInIsViewChecked.value = value!;
                },
                isAddValue: employeePermissionScreenController
                    .locationInIsAddChecked.value,
                isAddOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .locationInIsAddChecked.value = value!;
                },
                isEditValue: employeePermissionScreenController
                    .locationInIsEditChecked.value,
                isEditOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .locationInIsEditChecked.value = value!;
                },
                isDeleteValue: employeePermissionScreenController
                    .locationIsDeleteChecked.value,
                isDeleteOnChanged: (bool? value) {
                  employeePermissionScreenController
                      .locationIsDeleteChecked.value = value!;
                }),
            const SizedBox(height: 22),
            employeeBackSubmitButton(context),
            const SizedBox(height: 5),
          ],
        ).commonSymmetricPadding(horizontal: 10, vertical: 10),
      ),
    );
  }

  employeeBackSubmitButton(context) {
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
