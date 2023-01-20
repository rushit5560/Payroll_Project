import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/new/custom_approval_button_modual.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/approve_paycheckes_detail_manage_screen_controller.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class ApprovePayCheckesDetailsManageWidgetsScreen extends StatelessWidget {
  ApprovePayCheckesDetailsManageWidgetsScreen({super.key});

  final approvePayCheckesDetailsScreenController =
      Get.find<ApprovePayCheckesDetailsScreenController>();

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    final approvalDataValue =
        approvePayCheckesDetailsScreenController.approvalData;
    return
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: 1,
        //     itemBuilder: (context, index) {
        //       return

        Column(
      children: [
        Padding(
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
                        bool payChecksDeletePermission =
                        await userPreference.getBoolPermissionFromPrefs(
                            keyId: UserPreference.approvePayChecksDeleteKey);

                        if (payChecksDeletePermission == true) {
                        CustomAlertDialog().showAlertDialog(
                          context: context,
                          textContent: AppMessage.deleteEmployeeAlertMessage,
                          onYesTap: () async {
                            log("Delete Employee");
                            await approvePayCheckesDetailsScreenController
                                .deleteApprovalFunction(
                              approvalDataValue.id.toString(),
                            );
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
                const SizedBox(height: 10),
                SingleListTileModuleCustom(
                    textValue:
                        approvalDataValue.paydate.toString().split(" ")[0],
                    image: AppImages.calendarIcon,
                    textKey: AppMessage.payDate),
                const SizedBox(height: 5),
                SingleListTileModuleCustom(
                    textValue: approvalDataValue.firstName +
                        approvalDataValue.middleName +
                        approvalDataValue.lastName,
                    image: AppImages.employeeIcon,
                    textKey: AppMessage.employeeName),
                const SizedBox(height: 5),
                SingleListTileModuleCustom(
                    textValue: approvalDataValue.payPeriod == "salary"
                        ? approvalDataValue.salary
                        : approvalDataValue.ragularhour.toString(),
                    image: AppImages.salaryIcon,
                    textKey: AppMessage.hours),
                const SizedBox(height: 5),
                SingleListTileModuleCustom(
                    textValue: approvalDataValue.finalAmount,
                    image: AppImages.netAmountIcon,
                    textKey: AppMessage.netPay),
                const SizedBox(height: 5),
                SingleListTileModuleCustom(
                    textValue: approvalDataValue.tax.toString(),
                    image: AppImages.netAmountIcon,
                    textKey: AppMessage.totalTax),
                const SizedBox(height: 5),
                SingleListTileModuleCustom(
                    textValue: approvalDataValue.tax.toString(),
                    image: AppImages.netAmountIcon,
                    textKey: AppMessage.diractDeposit),
                const SizedBox(height: 5),
              ],
            ).commonAllSidePadding(10),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      AppMessage.total,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                        color: AppColors.colorBlack,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SingleListTileModuleCustom(
                    textValue: approvalDataValue.payPeriod == "salary"
                        ? approvalDataValue.salary
                        : approvalDataValue.ragularhour.toString(),
                    image: AppImages.salaryIcon,
                    textKey: AppMessage.hours),
                const SizedBox(height: 5),
                SingleListTileModuleCustom(
                    textValue: approvalDataValue.finalAmount,
                    image: AppImages.netAmountIcon,
                    textKey: AppMessage.netPay),
                const SizedBox(height: 5),
                SingleListTileModuleCustom(
                    textValue: approvalDataValue.tax.toString(),
                    image: AppImages.netAmountIcon,
                    textKey: AppMessage.totalTax),
              ],
            ).commonAllSidePadding(10),
          ),
        ),
        const SizedBox(height: 15),
        approvalDataValue.approvepaychecks == "0"
            ? ApprovalPaycheckesButtonModule(
                    onPress: () async {
                      await approvePayCheckesDetailsScreenController
                          .payrollapproveApiFunction(
                              approvalDataValue.id.toString());
                    },
                    labelText: AppMessage.approvePaycheckes)
                .commonSymmetricPadding(horizontal: 10)
            : Container(),
      ],
    );
    //     },
    //   ),
    // );
  }
}
