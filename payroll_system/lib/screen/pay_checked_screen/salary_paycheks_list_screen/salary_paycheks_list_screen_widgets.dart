import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/common_modules/new/web_url_launcher_function.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/salary_paycheks_list_screen_controller.dart';
import 'package:payroll_system/models/Pay_checkes_list_model/pay_checkes_list_screen_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';


class SalaryPaychecksListModule extends StatelessWidget {
  SalaryPaychecksListModule({Key? key}) : super(key: key);
  final screenController = Get.find<SalaryPaychecksListScreenController>();

  final userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: screenController.salaryPayChecksList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          PayCheckesListData singleItem = screenController.salaryPayChecksList[i];
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
                          await userPreference.getBoolPermissionFromPrefs(
                              keyId: UserPreference.payChecksDownloadKey);

                          if (payChecksDownloadPermission == true) {
                            await WebUrlLauncher().launchPdfInBrowser(
                                "${ApiUrl.downloadPayrollApi}${singleItem.id}");
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
                    textValue: singleItem.paydate.toString().split(" ")[0],
                    image: AppImages.calendarIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.employeeName,
                    textValue:
                    "${singleItem.firstName} ${singleItem.middleName} ${singleItem.lastName}",
                    image: AppImages.employeeIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.companyLabelName,
                    textValue: singleItem.companyid,
                    image: AppImages.companyIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.startDate,
                    textValue: singleItem.startdate
                        .toString()
                        .split(" ")[0],
                    image: AppImages.calendarIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.endDate,
                    textValue: singleItem.enddate.toString().split(" ")[0],
                    image: AppImages.calendarIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.totalDays,
                    textValue:
                    "${singleItem.days} ${AppMessage.days}",
                    image: AppImages.totalDaysIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.payPeriod,
                    textValue: singleItem.payPeriod,
                    image: AppImages.payPeriodIcon,
                  ),
                  const SizedBox(height: 5),
                  /*SingleListTileModuleCustom(
                    textKey: AppMessage.hours,
                    textValue: singleItem.type,
                    image: AppImages.hoursIcon,
                  ),
                  const SizedBox(height: 5),*/
                  SingleListTileModuleCustom(
                    textKey: AppMessage.salaryText,
                    textValue: "\$ ${singleItem.salary}",
                    image: AppImages.salaryIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.subTotal,
                    textValue:
                    "\$ ${singleItem.subTotal.toString()}",
                    image: AppImages.netAmountIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.netAmount,
                    textValue: "\$ ${singleItem.finalAmount}",
                    image: AppImages.netAmountIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textValue: singleItem.approvepaychecks == "0"
                        ? AppMessage.notApproved
                        : AppMessage.approved,
                    image: AppImages.verifyIcon,
                    textKey: AppMessage.status,
                    valueColor: singleItem.approvepaychecks == "0"
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
