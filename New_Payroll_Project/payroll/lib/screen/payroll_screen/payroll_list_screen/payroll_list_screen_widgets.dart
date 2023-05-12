import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/common_modules/single_item_module.dart';
import 'package:payroll/controllers/payroll_list_screen_controller.dart';

class PayRollListScreenWidgets extends StatelessWidget {
  PayRollListScreenWidgets({super.key});
  final payRollListScreenController = Get.find<PayRollListScreenController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: payRollListScreenController.payrollListDataList.length,
        itemBuilder: (context, index) {
          final payrollListDataListvalue =
              payRollListScreenController.payrollListDataList[index];
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
                    textKey: AppMessage.employeeName,
                    textValue: payrollListDataListvalue.firstName +
                        payrollListDataListvalue.middleName +
                        payrollListDataListvalue.lastName,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.company,
                    textValue: payrollListDataListvalue.companyname,
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
                    textKey: AppMessage.finalAmount,
                    textValue: payrollListDataListvalue.finalAmount,
                  ),
                  SizedBox(height: 2.h),
                ],
              ).commonAllSidePadding(5),
            ),
          );
        },
      ),
    );
  }
}
