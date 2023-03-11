import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll/common_modules/new/custom_approval_button_modual.dart';
import 'package:payroll/common_modules/new/single_list_tile_module.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/approve_paycheckes_detail_manage_screen_controller.dart';
import 'package:payroll/utils/app_images.dart';
import 'package:payroll/utils/date_format_changer.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/messaging.dart';
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
    return Obx(
      () => approvePayCheckesDetailsScreenController.isLoading.value
          ? Container()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
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
                                      await userPreference
                                          .getBoolPermissionFromPrefs(
                                              keyId: UserPreference
                                                  .approvePayChecksDeleteKey);

                                  if (payChecksDeletePermission == true) {
                                    CustomAlertDialog().showAlertDialog(
                                      context: context,
                                      textContent: AppMessage
                                          .deletePaychecksAlertMessage,
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
                          const SizedBox(height: 10),
                          SingleListTileModuleCustom(
                              textValue: DateFormater().changeDateFormat(
                                  DateTime.parse(approvalDataValue.paydate
                                      .split(" ")[0]),
                                  approvePayCheckesDetailsScreenController
                                      .prefsDateFormat),
                              // textValue:
                              //     approvalDataValue.paydate.toString().split(" ")[0],
                              image: AppImages.calendarIcon,
                              textKey: AppMessage.payDate),
                          const SizedBox(height: 5),
                          SingleListTileModuleCustom(
                              textValue:
                                  "${approvalDataValue.firstName} ${approvalDataValue.middleName} ${approvalDataValue.lastName}",
                              image: AppImages.employeeIcon,
                              textKey: AppMessage.employeeName),
                          const SizedBox(height: 5),
                          approvalDataValue.payPeriod == "salary"
                              ? SingleListTileModuleCustom(
                                  textValue: "\$ ${approvalDataValue.salary}",
                                  image: AppImages.salaryIcon,
                                  textKey: AppMessage.salaryText)
                              : SingleListTileModuleCustom(
                                  textValue:
                                      "\$ ${approvalDataValue.hourlyRate}",
                                  image: AppImages.salaryIcon,
                                  textKey: AppMessage.hoursRate),
                          const SizedBox(height: 5),
                          approvalDataValue.payPeriod == "salary"
                              ? Container()
                              : SingleListTileModuleCustom(
                                  textValue:
                                      "${approvalDataValue.ragularhour} Hours",
                                  image: AppImages.salaryIcon,
                                  textKey: AppMessage.regularHour),
                          approvalDataValue.payPeriod == "salary"
                              ? Container()
                              : const SizedBox(height: 5),
                          approvalDataValue.payPeriod == "salary"
                              ? Container()
                              : SingleListTileModuleCustom(
                                  textValue:
                                      "${approvalDataValue.overtime} Hours",
                                  image: AppImages.salaryIcon,
                                  textKey: AppMessage.overTime),
                          approvalDataValue.payPeriod == "salary"
                              ? Container()
                              : const SizedBox(height: 5),
                          approvalDataValue.payPeriod == "salary"
                              ? Container()
                              : SingleListTileModuleCustom(
                                  textValue:
                                      "${approvalDataValue.holidaypay} Hours",
                                  image: AppImages.salaryIcon,
                                  textKey: AppMessage.holidayPay),
                          approvalDataValue.payPeriod == "salary"
                              ? Container()
                              : const SizedBox(height: 5),
                          SingleListTileModuleCustom(
                            textValue: "\$ ${approvalDataValue.bonus}",
                            image: AppImages.salaryIcon,
                            textKey: AppMessage.bonusText,
                          ),
                          const SizedBox(height: 5),
                          SingleListTileModuleCustom(
                            textValue: "\$ ${approvalDataValue.otherearning}",
                            image: AppImages.salaryIcon,
                            textKey: AppMessage.otherEarningText,
                          ),
                          const SizedBox(height: 5),
                          SingleListTileModuleCustom(
                            textValue: "\$ ${approvalDataValue.sickpay}",
                            image: AppImages.salaryIcon,
                            textKey: AppMessage.sickPayText,
                          ),
                          const SizedBox(height: 5),
                          SingleListTileModuleCustom(
                            textValue: "\$ ${approvalDataValue.vacationhours}",
                            image: AppImages.salaryIcon,
                            textKey: AppMessage.vacationHourText,
                          ),
                          const SizedBox(height: 5),
                          SingleListTileModuleCustom(
                            textValue: "\$ ${approvalDataValue.commission}",
                            image: AppImages.salaryIcon,
                            textKey: AppMessage.commissionText,
                          ),
                          const SizedBox(height: 5),
                          SingleListTileModuleCustom(
                            textValue: "\$ ${approvalDataValue.tip}",
                            image: AppImages.salaryIcon,
                            textKey: AppMessage.tipText,
                          ),
                          const SizedBox(height: 5),
                          // SingleListTileModuleCustom(
                          //   textValue: "\$ ${approvalDataValue.tax}",
                          //   image: AppImages.salaryIcon,
                          //   textKey: AppMessage.taxText,
                          // ),
                          // const SizedBox(height: 5),

                          /*SingleListTileModuleCustom(
                        textValue: "\$ ${approvalDataValue.finalAmount}",
                        image: AppImages.netAmountIcon,
                        textKey: AppMessage.netPay),
                    const SizedBox(height: 5),
                    SingleListTileModuleCustom(
                        textValue: approvalDataValue.tax.toString(),
                        image: AppImages.netAmountIcon,
                        textKey: AppMessage.totalTax),
                    const SizedBox(height: 5),*/

                          SingleListTileModuleCustom(
                              textValue: AppMessage.no,
                              image: AppImages.netAmountIcon,
                              textKey: AppMessage.directDeposit),
                          const SizedBox(height: 5),
                        ],
                      ).commonAllSidePadding(10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
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
                                  ? "\$ ${approvalDataValue.subTotal}"
                                  : "\$ ${approvalDataValue.subTotal.toString()}",
                              image: AppImages.salaryIcon,
                              textKey: approvalDataValue.payPeriod == "salary"
                                  ? AppMessage.subTotal
                                  : AppMessage.hourlySubTotal),
                          const SizedBox(height: 5),
                          SingleListTileModuleCustom(
                            textValue: "\$ ${approvalDataValue.tax}",
                            image: AppImages.salaryIcon,
                            textKey: AppMessage.taxText,
                          ),
                          const SizedBox(height: 5),
                          SingleListTileModuleCustom(
                              textValue:
                                  "\$ ${approvalDataValue.finalAmount.toString()}",
                              image: AppImages.netAmountIcon,
                              textKey: AppMessage.totalPayable),
                        ],
                      ).commonAllSidePadding(10),
                    ),
                  ),
                  const SizedBox(height: 15),
                  approvalDataValue.approvepaychecks == "0"
                      ? ApprovalPaycheckesButtonModule(
                              onPress: () async {

                                approvePayCheckesDetailsScreenController.approvePayChecksEditPermission =
                                await userPreference
                                    .getBoolPermissionFromPrefs(
                                    keyId: UserPreference
                                        .approvePayChecksEditKey);
                                if(approvePayCheckesDetailsScreenController.approvePayChecksEditPermission == true) {
                                  await approvePayCheckesDetailsScreenController
                                      .payrollApproveApiFunction(
                                    approvalDataValue.id.toString(),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: AppMessage.deniedPermission);
                                }
                              },
                              labelText: AppMessage.approvePaycheckes)
                          .commonSymmetricPadding(horizontal: 10)
                      : Container(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
    );
    //     },
    //   ),
    // );
  }
}
