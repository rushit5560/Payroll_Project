import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/edit_and_delete_button_module.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/common_modules/single_item_module.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/department_list_screen_controller.dart';
import 'package:payroll_system/models/company_manage_screen_model/get_all_department_model.dart';
import 'package:payroll_system/screen/department_screens/department_manage_screen/department_manage_screen.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/extension_methods/user_preference.dart';

class DepartmentListModule extends StatelessWidget {
  DepartmentListModule({Key? key}) : super(key: key);
  final screenController = Get.find<DepartmentListScreenController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: screenController.searchDepartmentDataList.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) {
        DepartmentData singleItem =
            screenController.searchDepartmentDataList[i];
        return DepartmentListTile(singleItem: singleItem, index: i);
      },
    );
  }
}

class DepartmentListTile extends StatelessWidget {
  DepartmentData singleItem;
  int index;

  DepartmentListTile({Key? key, required this.singleItem, required this.index})
      : super(key: key);

  final screenController = Get.find<DepartmentListScreenController>();
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
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
                      bool departmentEditPermission =
                          await userPreference.getBoolPermissionFromPrefs(
                          keyId: UserPreference.departmentEditKey);
                      if (departmentEditPermission == true) {
                        Get.to(
                              () => DepartmentManageScreen(),
                          arguments: [
                            DepartmentOption.update,
                            singleItem.id.toString(),
                            screenController.companyId,
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
                      bool departmentDeletePermission =
                      await userPreference.getBoolPermissionFromPrefs(
                          keyId: UserPreference.departmentDeleteKey);

                      if (departmentDeletePermission == true) {
                        CustomAlertDialog().showAlertDialog(
                          textContent: AppMessage.deleteDepartmentAlertMessage,
                          context: context,
                          onYesTap: () async {
                            await screenController.deleteDepartmentFunction(
                                singleItem.id.toString(), index);
                          },
                          onCancelTap: () => Get.back(),
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

              /// Getting From Common Module
              SingleListTileModuleCustom(
                image: AppImages.departmentIcon,
                textKey: AppMessage.employeeDepartmentName,
                textValue: singleItem.departmentName,
              ),

              /// Getting From Common Module
              SingleListTileModuleCustom(
                image: AppImages.verifyIcon,
                textKey: AppMessage.employeeStatus,
                textValue: singleItem.isActive == AppMessage.value
                    ? AppMessage.active
                    : AppMessage.inActive,
                valueColor: singleItem.isActive == AppMessage.value ? AppColors.greenColor : AppColors.colorRed,
              ),

              SizedBox(height: 2.h),

              /// Getting From Common Module
              /*EditAndDeleteButtonModule(
                onEditTap: () async {
                  bool departmentEditPermission =
                      await userPreference.getBoolPermissionFromPrefs(
                          keyId: UserPreference.departmentEditKey);
                  if (departmentEditPermission == true) {
                    Get.to(
                      () => DepartmentManageScreen(),
                      arguments: [
                        DepartmentOption.update,
                        singleItem.id.toString(),
                        screenController.companyId,
                      ],
                    );
                  } else {
                    Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                  }
                },
                onDeleteTap: () async {
                  bool departmentDeletePermission =
                      await userPreference.getBoolPermissionFromPrefs(
                          keyId: UserPreference.departmentDeleteKey);

                  if (departmentDeletePermission == true) {
                    CustomAlertDialog().showAlertDialog(
                      textContent: AppMessage.deleteDepartmentAlertMessage,
                      context: context,
                      onYesTap: () async {
                        await screenController.deleteDepartmentFunction(
                            singleItem.id.toString(), index);
                      },
                      onCancelTap: () => Get.back(),
                    );
                  } else {
                    Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                  }
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
