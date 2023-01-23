import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/edit_and_delete_button_module.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/common_modules/single_item_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/company_home_screen_controller.dart';
import 'package:payroll_system/screen/company_employee_screens/company_employee_manage_screen/company_employee_manage_screen.dart';
import 'package:payroll_system/screen/employee_screens/employee_upload_document_screen/employee_upload_document_screen.dart';
import 'package:payroll_system/utils/app_images.dart';

import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
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
          padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                              () => CompanyEmployeeManageScreen(),
                              arguments: [
                                EmployeeOption.update,
                                value.id.toString(),
                                companyHomeScreenController.companyId
                                    .toString(),
                                companyHomeScreenController.companyName,
                              ],
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: AppMessage.deniedPermission);
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
                              textContent:
                                  AppMessage.deleteEmployeeAlertMessage,
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
                            Fluttertoast.showToast(
                                msg: AppMessage.deniedPermission);
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
                  SizedBox(height: 1.h),
                  SingleListTileModuleCustom(
                    image: AppImages.employeeIcon,
                    textKey: AppMessage.employeeName,
                    textValue:
                        value.firstName + value.middleName + value.lastName,
                  ),
                  SizedBox(height: 1.h),
                  SingleListTileModuleCustom(
                    image: AppImages.emailIcon,
                    textKey: AppMessage.employeeEmail,
                    textValue: value.email,
                  ),
                  SizedBox(height: 1.h),
                  SingleListTileModuleCustom(
                    image: AppImages.phoneIcon,
                    textKey: AppMessage.phoneNumber,
                    textValue: value.mobileNumber,
                  ),
                  SizedBox(height: 1.h),
                  SingleListTileModuleCustom(
                    image: AppImages.departmentIcon,
                    textKey: AppMessage.employeeDepartmentName,
                    textValue: value.departmentId.toString(),
                  ),
                  SizedBox(height: 1.h),
                  SingleListTileModuleCustom(
                    image: AppImages.companyIcon,
                    textKey: AppMessage.employeeCompanyName,
                    textValue: value.companyid.toString(),
                  ),
                  SizedBox(height: 1.h),
                  SingleListTileModuleCustom(
                    image: AppImages.verifyIcon,
                    textKey: AppMessage.employeeStatus,
                    textValue: value.isActive == AppMessage.value
                        ? AppMessage.active
                        : AppMessage.inActive,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => EmployeeUploadDocumentScreen(),
                            arguments: [
                              // "${value.firstName} ${value.middleName} ${value.lastName}",
                              companyHomeScreenController.companyName,
                              value.id.toString(),
                              companyHomeScreenController.companyId.toString(),
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

                  /* SizedBox(height: 2.h),
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
                  )*/
                ],
              ).commonAllSidePadding(5),
            ),
          ),
        );
      },
    );
  }
}
