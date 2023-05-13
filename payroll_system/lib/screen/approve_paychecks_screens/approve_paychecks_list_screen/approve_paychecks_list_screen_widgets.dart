import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/approve_paychecks_list_screen_controller.dart';
import 'package:payroll_system/screen/approve_paychecks_screens/approve_pay_checkes_details_manage_screen/approve_pay_checkes_details_manage_screen.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/date_format_changer.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';

class ApprovePaychecksListWidgetsScreen extends StatelessWidget {
  ApprovePaychecksListWidgetsScreen({super.key});
  final approvePaychecksListScreenController =
      Get.find<ApprovePaychecksListScreenController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount:
            approvePaychecksListScreenController.searchApprovePayCheckList.length,

        itemBuilder: (context, index) {
          final approvePayrollListDataListvalue =
              approvePaychecksListScreenController
                  .searchApprovePayCheckList[index];

          // Total days
          DateTime endDate = DateTime.parse(approvePayrollListDataListvalue.enddate);
          DateTime startDate = DateTime.parse(approvePayrollListDataListvalue.startdate);
          int daysCount = endDate.difference(startDate).inDays + 1;

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
                  SingleListTileModuleCustom(
                      textValue: DateFormater().changeDateFormat(
                          DateTime.parse(approvePayrollListDataListvalue.paydate),
                          approvePaychecksListScreenController.prefsDateFormat),
                      // textValue: approvePayrollListDataListvalue.paydate
                      //     .toString()
                      //     .split(" ")[0],
                      image: AppImages.calendarIcon,
                      textKey: AppMessage.payDate),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: "${approvePayrollListDataListvalue.firstName} ${approvePayrollListDataListvalue.middleName} ${approvePayrollListDataListvalue.lastName}",
                      image: AppImages.employeeIcon,
                      textKey: AppMessage.employeeName),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: approvePayrollListDataListvalue.companyname,
                      image: AppImages.companyIcon,
                      textKey: AppMessage.companyLabelName),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textValue: DateFormater().changeDateFormat(
                      DateTime.parse(approvePayrollListDataListvalue.startdate),
                        approvePaychecksListScreenController.prefsDateFormat),
                      // textValue: approvePayrollListDataListvalue.startdate
                      //     .toString()
                      //     .split(" ")[0],
                      image: AppImages.calendarIcon,
                      textKey: AppMessage.startDate),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: DateFormater().changeDateFormat(
                          DateTime.parse(approvePayrollListDataListvalue.enddate),
                          approvePaychecksListScreenController.prefsDateFormat),
                      // textValue: approvePayrollListDataListvalue.enddate
                      //     .toString()
                      //     .split(" ")[0],
                      image: AppImages.calendarIcon,
                      textKey: AppMessage.endDate),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: "$daysCount ${AppMessage.days}",
                      image: AppImages.totalDaysIcon,
                      textKey: AppMessage.totalDays),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: approvePayrollListDataListvalue.payPeriod,
                      image: AppImages.payPeriodIcon,
                      textKey: AppMessage.payPeriod),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue:
                          approvePayrollListDataListvalue.payPeriod == "salary"
                              ? "\$ ${approvePayrollListDataListvalue.salary}"
                              : approvePayrollListDataListvalue.ragularhour.toString(),
                      image: AppImages.salaryIcon,
                      textKey: AppMessage.salaryHourlyRate),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: "\$ ${approvePayrollListDataListvalue.subTotal}",
                      image: AppImages.netAmountIcon,
                      textKey: AppMessage.subTotal),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue: "\$ ${approvePayrollListDataListvalue.finalAmount}",
                      image: AppImages.netAmountIcon,
                      textKey: AppMessage.netAmount),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                      textValue:
                          approvePayrollListDataListvalue.approvepaychecks ==
                                  "0"
                              ? AppMessage.notApproved
                              : AppMessage.approved,
                      image: AppImages.verifyIcon,
                      textKey: AppMessage.status,
                    valueColor: approvePayrollListDataListvalue.approvepaychecks ==
                        "0" ? AppColors.colorRed : AppColors.greenColor,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ApprovePayCheckesDetailsManageScreen(),
                              arguments: [
                                approvePaychecksListScreenController.companyId,
                                approvePaychecksListScreenController
                                    .companyName,
                                approvePayrollListDataListvalue
                              ])!.then((value) async {
                            // approvePaychecksListScreenController.isLoading(true);
                            await approvePaychecksListScreenController.approvePaycheckesListFunction();
                            // approvePaychecksListScreenController.isLoading(false);
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              AppMessage.approvePaycheckesDetails,
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
                  )
                ],
              ).commonAllSidePadding(10),
            ),
          );
        },
      ),
    );
  }
}
