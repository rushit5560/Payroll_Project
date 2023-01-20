import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/sub_admin_list_screen_controller.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';

class SubAdminListWidgetsScreen extends StatelessWidget {
  SubAdminListWidgetsScreen({super.key});

  final subAdminListScreenController = Get.find<SubAdminListScreenController>();
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
                          // Get.to(
                          //   () => LocationManageScreen(),

                          // );
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
                          CustomAlertDialog().showAlertDialog(
                            context: context,
                            textContent:
                                'Are youe sure you want to delete location ?',
                            onYesTap: () async {
                              // await subAdminListScreenController.deleteLocationFunction(
                              //     value.id.toString(), index);
                            },
                            onCancelTap: () {
                              Get.back();
                            },
                          );
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
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: subAdminValue.userName,
                      image: AppImages.payPeriodIcon,
                      textKey: AppMessage.name),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: subAdminValue.phoneno,
                      image: AppImages.payPeriodIcon,
                      textKey: AppMessage.mobileNumber),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: subAdminValue.isActive == "1"
                          ? AppMessage.active
                          : AppMessage.isActive,
                      image: AppImages.payPeriodIcon,
                      textKey: AppMessage.varifiedStatus),
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
