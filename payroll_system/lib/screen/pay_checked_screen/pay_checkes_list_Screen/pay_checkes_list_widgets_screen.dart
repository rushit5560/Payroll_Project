import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:payroll_system/common_modules/download_button_module.dart';
import 'package:payroll_system/common_modules/single_item_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/pay_checkes_list_screen_controller.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class PayCheckesListWidgetsScreen extends StatelessWidget {
  PayCheckesListWidgetsScreen({super.key});
  final payCheckesListScreenController =
      Get.find<PayCheckesListScreenController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: payCheckesListScreenController.payCheckesListData.length,
        itemBuilder: (context, index) {
          final payrollListDataListvalue =
              payCheckesListScreenController.payCheckesListData[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.greyColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.date,
                    textValue: payrollListDataListvalue.paydate
                        .toString()
                        .split(" ")[0],
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.name,
                    textValue: payrollListDataListvalue.firstName +
                        payrollListDataListvalue.middleName +
                        payrollListDataListvalue.lastName,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.company,
                    textValue: payrollListDataListvalue.bonus,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.startDate,
                    textValue: payrollListDataListvalue.startdate
                        .toString()
                        .split(" ")[0],
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.endDate,
                    textValue: payrollListDataListvalue.enddate
                        .toString()
                        .split(" ")[0],
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.totalDays,
                    textValue: payrollListDataListvalue.days,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.payPeriod,
                    textValue: payrollListDataListvalue.payPeriod,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.hours,
                    textValue: payrollListDataListvalue.type,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.salaryHourlyRate,
                    textValue: payrollListDataListvalue.salary,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.subTotal,
                    textValue: payrollListDataListvalue.subTotal,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.netAmount,
                    textValue: payrollListDataListvalue.finalAmount,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DownloadButtonModule(
                          onDownloadTap: () {},
                          downloadLabelText: AppMessage.download),
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
