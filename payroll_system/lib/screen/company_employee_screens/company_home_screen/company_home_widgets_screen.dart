import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/edit_and_delete_button_module.dart';
import 'package:payroll_system/common_modules/single_item_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/company_home_screen_controller.dart';
import 'package:payroll_system/screen/company_employee_screens/company_employee_manage_screen/company_employee_manage_screen.dart';

import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class CompanyHomeScreenWidgets extends StatelessWidget {
  CompanyHomeScreenWidgets({super.key});
  final companyHomeScreenController = Get.find<CompanyHomeScreenController>();
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: companyHomeScreenController.searchEmployeeList.length,
      itemBuilder: (context, index) {
        final value = companyHomeScreenController.searchEmployeeList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.greyColor,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 1.h),
                SingleListTileCustom(
                  textKey: AppMessage.employeeName,
                  textValue:
                      value.firstName + value.middleName + value.lastName,
                ),
                SizedBox(height: 1.h),
                SingleListTileCustom(
                  textKey: AppMessage.employeeEmail,
                  textValue: value.email,
                ),
                SizedBox(height: 1.h),
                SingleListTileCustom(
                  textKey: AppMessage.phoneNumber,
                  textValue: value.mobileNumber,
                ),
                SizedBox(height: 2.h),
                SingleListTileCustom(
                  textKey: AppMessage.employeeDepartmentName,
                  textValue: value.departmentId.toString(),
                ),
                SizedBox(height: 2.h),
                SingleListTileCustom(
                    textKey: AppMessage.employeeCompanyName,
                    textValue: value.companyid.toString()),
                SizedBox(height: 2.h),
                SingleListTileCustom(
                    textKey: AppMessage.employeeStatus,
                    textValue: value.isActive == AppMessage.value
                        ? AppMessage.active
                        : AppMessage.inActive),
                SizedBox(height: 2.h),
                EditAndDeleteButtonModule(
                  onDeleteTap: () async {
                    bool employeeUpdatePermission =
                        await userPreference.getBoolPermissionFromPrefs(
                            keyId: UserPreference.employeeEditKey);

                    if (employeeUpdatePermission == true) {
                      CustomAlertDialog().showAlertDialog(
                        context: context,
                        textContent: AppMessage.deleteEmployeeAlertMessage,
                        onYesTap: () async {
                          log("Delete Employee");
                          await companyHomeScreenController
                              .deleteEmployeeFunction(
                                  value.id.toString(), index);
                        },
                        onCancelTap: () {
                          Get.back();
                        },
                      );
                    } else {
                      Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                    }
                  },
                  onEditTap: () async {
                    bool employeeDeletePermission =
                        await userPreference.getBoolPermissionFromPrefs(
                            keyId: UserPreference.employeeDeleteKey);

                    if (employeeDeletePermission == true) {
                      Get.to(
                        () => CompanyEmployeeManageScreen(),
                        arguments: [
                          EmployeeOption.update,
                          value.id.toString(),
                          companyHomeScreenController.companyId.toString(),
                          companyHomeScreenController.companyName,
                        ],
                      );
                    } else {
                      Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                    }
                  },
                )
              ],
            ).commonAllSidePadding(5),
          ),
        );
      },
    );
  }
}