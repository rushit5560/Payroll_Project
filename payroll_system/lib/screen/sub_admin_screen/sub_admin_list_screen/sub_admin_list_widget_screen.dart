import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/sub_admin_list_screen_controller.dart';
import 'package:payroll_system/screen/sub_admin_screen/sub_admin_manage_screen/sub_admin_manage_screen.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';

class SubAdminListWidgetsScreen extends StatelessWidget {
  SubAdminListWidgetsScreen({super.key});

  final subAdminListScreenController = Get.find<SubAdminListScreenController>();

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    log("len    ${subAdminListScreenController.searchSubadminDataList.length}");

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: subAdminListScreenController.searchSubadminDataList.length,
      itemBuilder: (context, index) {
        final subAdminValue =
            subAdminListScreenController.searchSubadminDataList[index];
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10.0),
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

                          bool subAdminEditPermission = await userPreference.getBoolPermissionFromPrefs(
                              keyId: UserPreference.subAdminEditKey);

                          if(subAdminEditPermission == true) {
                            Get.to(() => SubAdminManageScreen(),
                              arguments: [subAdminValue.id.toString()],
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
                      // const SizedBox(width: 10),
                      /*GestureDetector(
                        onTap: () async {

                          bool subAdminDeletePermission = await userPreference.getBoolPermissionFromPrefs(
                              keyId: UserPreference.subAdminDeleteKey);

                          if(subAdminDeletePermission == true) {
                            CustomAlertDialog().showAlertDialog(
                              context: context,
                              textContent: 'Are you sure you want to delete subadmin ?',
                              onYesTap: () async {
                                // await subAdminListScreenController.deleteLocationFunction(
                                //     value.id.toString(), index);
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
                      ),*/
                    ],
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: subAdminValue.userName,
                      image: AppImages.employeeIcon,
                      textKey: AppMessage.name),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: subAdminValue.phoneno,
                      image: AppImages.phoneIcon,
                      textKey: AppMessage.mobileNumber),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: subAdminValue.isActive == "1"
                          ? AppMessage.active
                          : AppMessage.isActive,
                      valueColor: subAdminValue.isActive == AppMessage.value
                          ? AppColors.greenColor
                          : subAdminValue.isActive == AppMessage.valueZero
                              ? AppColors.colorRed
                              : AppColors.greyColor,
                      image: AppImages.verifyIcon,
                      textKey: AppMessage.status),
                  const SizedBox(height: 5),
                ],
              ).commonAllSidePadding(5),
            ),
          ),
        );
      },
    );
  }
}
