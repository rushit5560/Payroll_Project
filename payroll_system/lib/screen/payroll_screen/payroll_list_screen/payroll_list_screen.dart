import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/payroll_list_screen_controller.dart';
import 'package:payroll_system/screen/payroll_screen/payroll_list_manage_screen/payroll_manage_screen.dart';
import 'package:payroll_system/screen/payroll_screen/payroll_list_screen/payroll_list_screen_widgets.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class PayRollListScreen extends StatelessWidget {
  PayRollListScreen({super.key});
  final pyRollListScreenController = Get.put(PayRollListScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMessage.payRollList),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => PayRollManageScreen(),
                arguments: [
                  PayrollOption.create,
                  pyRollListScreenController.companyId,
                  pyRollListScreenController.companyName,
                ],
              );

              log(" pyRollListScreenController.companyId  ::${pyRollListScreenController.companyId}");
              log(" pyRollListScreenController.companyName  ::${pyRollListScreenController.companyName}");
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  AppMessage.payRollList,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                  flex: 5,
                  child: Container(
                    // width: Get.width,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.greyColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: pyRollListScreenController.selectedValue.value,
                          items: pyRollListScreenController.isPayperList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            pyRollListScreenController.isLoading(true);
                            pyRollListScreenController.selectedValue.value =
                                value!;
                            pyRollListScreenController.isLoading(false);
                          },
                        ).commonOnlyPadding(left: 10, right: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ).commonSymmetricPadding(horizontal: 10),
          const SizedBox(height: 5),
          PayRollListScreenWidgets(),
        ],
      ).commonOnlyPadding(bottom: 5, top: 10),
    );
  }
}
