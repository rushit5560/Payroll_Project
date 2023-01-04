import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/single_item_module.dart';
import 'package:payroll_system/common_modules/view_button_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/company_home_screen_controller.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen.dart';
import 'package:payroll_system/screen/employee_screens/employee_view_screen/employee_view_screen.dart';
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
      itemCount: companyHomeScreenController.allCompanyWiseEmployeeList.length,
      itemBuilder: (context, index) {
        final value =
            companyHomeScreenController.allCompanyWiseEmployeeList[index];
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
                ViewAndEditButtonModule(
                  onViewTap: () {
                    Get.to(
                      () => EmployeeViewScreen(),
                      arguments: [
                        value.id.toString(),
                        value.firstName.toString(),
                      ],
                    );
                  },
                  onEditTap: () async {
                    bool employeeDeletePermission =
                        await userPreference.getBoolPermissionFromPrefs(
                            keyId: UserPreference.employeeDeleteKey);

                    if (employeeDeletePermission == true) {
                      Get.to(
                        () => EmployeeManageScreen(),
                        arguments: [
                          EmployeeOption.update,
                          value.id.toString(),
                          companyHomeScreenController.companyId,
                          companyHomeScreenController.companyName,
                        ],
                      );
                    } else {
                      Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                    }
                  },
                  viewLabelText: AppMessage.view,
                  editLabelText: AppMessage.edit,
                ),
              ],
            ).commonAllSidePadding(5),
          ),
        );
      },
    );
  }
}
