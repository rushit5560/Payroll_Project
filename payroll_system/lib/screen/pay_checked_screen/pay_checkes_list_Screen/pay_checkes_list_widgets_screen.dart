import 'dart:developer';
import 'package:dio/dio.dart';
// import 'package:ext_storage/ext_storage.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/common_modules/new/web_url_launcher_function.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/pay_checkes_list_screen_controller.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';

// ignore: must_be_immutable
class PayCheckesListWidgetsScreen extends StatelessWidget {
  PayCheckesListWidgetsScreen({super.key});

  final payCheckesListScreenController =
      Get.find<PayCheckesListScreenController>();

  UserPreference userPreference = UserPreference();
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: payCheckesListScreenController.filterPayChecksListData.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final payrollListDataListValue =
              payCheckesListScreenController.filterPayChecksListData[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                          bool payChecksDownloadPermission =
                              await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.payChecksDownloadKey);

                          if (payChecksDownloadPermission == true) {
                            await payCheckesListScreenController.downloadFile();
                            // await WebUrlLauncher().launchPdfInBrowser("${ApiUrl.downloadPayrollApi}${payrollListDataListValue.id}");
                          } else {
                            Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                          }
                        },
                        child: Image.asset(
                          AppImages.downloadIcon,
                          width: 30,
                          height: 30,
                          color: AppColors.colorBtBlue,
                        ),
                      ),
                    ],
                  ),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.payDate,
                    textValue: payrollListDataListValue.paydate
                        .toString()
                        .split(" ")[0],
                    image: AppImages.calendarIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.employeeName,
                    textValue:
                        "${payrollListDataListValue.firstName} ${payrollListDataListValue.middleName} ${payrollListDataListValue.lastName}",
                    image: AppImages.employeeIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.companyLabelName,
                    textValue: payrollListDataListValue.companyid,
                    image: AppImages.companyIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.startDate,
                    textValue: payrollListDataListValue.startdate
                        .toString()
                        .split(" ")[0],
                    image: AppImages.calendarIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.endDate,
                    textValue: payrollListDataListValue.enddate
                        .toString()
                        .split(" ")[0],
                    image: AppImages.calendarIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.totalDays,
                    textValue:
                        "${payrollListDataListValue.days} ${AppMessage.days}",
                    image: AppImages.totalDaysIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.payPeriod,
                    textValue: payrollListDataListValue.payPeriod,
                    image: AppImages.payPeriodIcon,
                  ),
                  const SizedBox(height: 5),
                  /*SingleListTileModuleCustom(
                    textKey: AppMessage.hours,
                    textValue: payrollListDataListValue.type,
                    image: AppImages.hoursIcon,
                  ),
                  const SizedBox(height: 5),*/
                  SingleListTileModuleCustom(
                    textKey: AppMessage.hourlyRateLabel,
                    textValue: "\$ ${payrollListDataListValue.ragularhour.toString()}",
                    image: AppImages.salaryIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.subTotal,
                    textValue:
                        "\$ ${payrollListDataListValue.subTotal.toString()}",
                    image: AppImages.netAmountIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.netAmount,
                    textValue: "\$ ${payrollListDataListValue.finalAmount}",
                    image: AppImages.netAmountIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textValue: payrollListDataListValue.approvepaychecks == "0"
                        ? AppMessage.notApproved
                        : AppMessage.approved,
                    image: AppImages.verifyIcon,
                    textKey: AppMessage.status,
                    valueColor: payrollListDataListValue.approvepaychecks == "0"
                        ? AppColors.colorRed
                        : AppColors.greenColor,
                  ),
                ],
              ).commonAllSidePadding(10),
            ),
          );
        },
      ),
    );
  }
}
