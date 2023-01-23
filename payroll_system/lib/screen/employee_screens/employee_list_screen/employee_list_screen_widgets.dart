import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/employee_list_screen_controller.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen.dart';
import 'package:payroll_system/screen/employee_screens/employee_upload_document_screen/employee_upload_document_screen.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/custom_alert_dialog_module.dart';

class EmployeeListScreenWidgets extends StatelessWidget {
  EmployeeListScreenWidgets({super.key});
  final employeeListScreenController = Get.find<EmployeeListScreenController>();

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: employeeListScreenController.searchEmployeeList.length,
      itemBuilder: (context, index) {
        final employee = employeeListScreenController.searchEmployeeList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        bool employeeUpdatePermission =
                        await userPreference.getBoolPermissionFromPrefs(
                            keyId: UserPreference.employeeEditKey);

                        if (employeeUpdatePermission == true) {
                          Get.to(
                                () => EmployeeManageScreen(),
                            arguments: [
                              EmployeeOption.update,
                              employee.id.toString(),
                              employeeListScreenController.companyId,
                              employeeListScreenController.companyName,
                            ],
                          );
                        } else {
                          Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                        }
                      },
                      child: Image.asset(
                        AppImages.editIcon,
                        width: 20,
                        height: 20,
                        color: AppColors.colorBtBlue,
                      ),
                    ),
                    const SizedBox(width: 10),

                    GestureDetector(
                      onTap: () async {

                        bool employeeDeletePermission =
                        await userPreference.getBoolPermissionFromPrefs(
                            keyId: UserPreference.employeeDeleteKey);

                        if (employeeDeletePermission == true) {
                          CustomAlertDialog().showAlertDialog(
                            context: context,
                            textContent: AppMessage.deleteEmployeeAlertMessage,
                            onYesTap: () async {
                              log("Delete Employee");
                              await employeeListScreenController
                                  .deleteEmployeeFunction(
                                  employee.id.toString(), index);
                            },
                            onCancelTap: () {
                              Get.back();
                            },
                          );
                        } else {
                          Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                        }
                      },
                      child: Image.asset(
                        AppImages.deleteIcon,
                        width: 20,
                        height: 20,
                        color: AppColors.colorRed,
                      ),
                    ),
                  ],
                ),

                SingleListTileModuleCustom(
                  image: AppImages.employeeIcon,
                  textKey: AppMessage.employeeName,
                  textValue:
                      "${employee.firstName} ${employee.middleName} ${employee.lastName}",
                ),
                SizedBox(height: 1.h),
                SingleListTileModuleCustom(
                  image: AppImages.emailIcon,
                  textKey: AppMessage.employeeEmail,
                  textValue: employee.email,
                ),
                SizedBox(height: 1.h),
                SingleListTileModuleCustom(
                  image: AppImages.phoneIcon,
                  textKey: AppMessage.mobileNumber,
                  textValue: employee.mobileNumber,
                ),
                SizedBox(height: 2.h),
                SingleListTileModuleCustom(
                  image: AppImages.departmentIcon,
                  textKey: AppMessage.employeeDepartmentName,
                  textValue: employee.departmentId.toString(),
                ),
                SizedBox(height: 2.h),
                SingleListTileModuleCustom(
                  image: AppImages.companyIcon,
                    textKey: AppMessage.employeeCompanyName,
                    textValue: employee.companyid.toString()),
                SizedBox(height: 2.h),
                SingleListTileModuleCustom(
                  image: AppImages.verifyIcon,
                    textKey: AppMessage.employeeStatus,
                    textValue: employee.isActive == AppMessage.value
                        ? AppMessage.active
                        : AppMessage.inActive,
                  valueColor: employee.isActive == AppMessage.value
                  ? AppColors.greenColor
                  : AppColors.colorRed,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => EmployeeUploadDocumentScreen(),
                          arguments: [
                            "${employee.firstName} ${employee
                                .middleName} ${employee.lastName}",
                            employee.id.toString(),
                            employeeListScreenController.companyId,
                          ],
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            AppMessage.uploadDocument,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleConfig.textStyle(
                              textColor: AppColors.colorBtBlue,
                            ),
                          ).commonOnlyPadding(right: 5),
                          Image.asset(
                            AppImages.arrowRightIcon,
                            width: 20,
                            height: 20,
                            color: AppColors.colorBtBlue,
                          ),
                        ],
                      ),

                    ),
                  ],
                ),
                // SizedBox(height: 2.h),
                /*EditAndDeleteButtonModule(
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
                          await employeeListScreenController
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
                        () => EmployeeManageScreen(),
                        arguments: [
                          EmployeeOption.update,
                          ```value```.id.toString(),
                          employeeListScreenController.companyId,
                          employeeListScreenController.companyName,
                        ],
                      );
                    } else {
                      Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                    }
                  },
                )*/
              ],
            ).commonAllSidePadding(8),
          ),
        );
      },
    );
  }
}
