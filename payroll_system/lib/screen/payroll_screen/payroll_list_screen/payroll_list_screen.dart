import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/controllers/payroll_list_screen_controller.dart';
import 'package:payroll_system/screen/payroll_screen/payroll_list_screen/payroll_list_screen_widgets.dart';
import 'package:payroll_system/screen/payroll_screen/payroll_list_manage_screen/payroll_manage_screen.dart';

class PayRollListScreen extends StatelessWidget {
  PayRollListScreen({super.key});
  final payRollListScreenController = Get.put(PayRollListScreenController());
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
                  payRollListScreenController.companyId,
                  payRollListScreenController.companyName,
                ],
              );
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Obx(
        () => payRollListScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : payRollListScreenController.payrollListDataList.isEmpty
                ? Center(
                    child: Text(AppMessage.noLocationFound),
                  )
                : Column(
                    children: [
                      TextFormField(
                        controller: payRollListScreenController
                            .textSearchEditingController,
                        onChanged: (value) {
                          payRollListScreenController.isLoading(true);

                          payRollListScreenController.isLoading(false);
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: const Icon(Icons.search),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          suffixIcon: payRollListScreenController
                                  .textSearchEditingController.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.close),
                                ),
                        ),
                      ).commonOnlyPadding(left: 10, right: 10, top: 15),
                      const SizedBox(height: 10),
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
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.greyColor),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: payRollListScreenController
                                        .selectedValue.value,
                                    items: payRollListScreenController
                                        .isPayperList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      payRollListScreenController
                                          .isLoading(true);
                                      payRollListScreenController
                                          .selectedValue.value = value!;
                                      payRollListScreenController
                                          .isLoading(false);
                                    },
                                  ).commonOnlyPadding(left: 10, right: 10),
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
      ),
    );
  }
}
