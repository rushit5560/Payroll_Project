import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/single_item_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/payroll_list_screen_controller.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class PayRollListScreenWidgets extends StatelessWidget {
  PayRollListScreenWidgets({super.key});
  final payRollListScreenController = Get.find<PayRollListScreenController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
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
                    textValue: "employeeName",
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.company,
                    textValue: "company",
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.startDate,
                    textValue: "2022-10-8",
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.endDate,
                    textValue: "2023-10-8",
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.totalDays,
                    textValue: "15Days",
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.payPeriod,
                    textValue: "hourly",
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.salaryHourlyRate,
                    textValue: "22",
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.subTotal,
                    textValue: "\$ 1500.00",
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.finalAmount,
                    textValue: "\$ 15000.00",
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
