import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/pay_checkes_list_screen_controller.dart';
import 'package:payroll_system/screen/pay_checked_screen/pay_checkes_list_Screen/pay_checkes_list_widgets_screen.dart';
import 'package:payroll_system/screen/pay_checked_screen/pay_checkes_manage_screen/pay_checkes_manage_screen.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';

import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class PayCheckesListScreen extends StatelessWidget {
  PayCheckesListScreen({super.key});

  final payCheckesListScreenController =
      Get.put(PayCheckesListScreenController());

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        title: Text(
          AppMessage.hourlyPaycheckes,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              bool payChecksAddPermission =
                  await userPreference.getBoolPermissionFromPrefs(
                      keyId: UserPreference.payChecksAddKey);
              if (payChecksAddPermission == true) {
                Get.to(
                  () => PayCheckedManageScreen(),
                  arguments: [
                    payCheckesListScreenController.companyId,
                    payCheckesListScreenController.companyName,
                  ],
                );
              } else {
                Fluttertoast.showToast(msg: AppMessage.deniedPermission);
              }
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Obx(
        () => payCheckesListScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : payCheckesListScreenController.payCheckesListData.isEmpty
                ? Center(
                    child: Text(AppMessage.noHourlyPayChecksListFound),
                  )
                : Column(
                    children: [
                      /*Row(
                        children: [
                          Text(
                            AppMessage.hourlyPaycheckesList,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: AppColors.colorBlack),
                          ).commonOnlyPadding(right: 20),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.transparent),
                                  ),
                                  child: Center(
                                    child: DropdownButtonFormField<String>(
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: ''),
                                      value: payCheckesListScreenController
                                          .selectedFilterValue.value,
                                      items: payCheckesListScreenController
                                          .filterList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      borderRadius: BorderRadius.circular(10),
                                      icon: Image.asset(
                                        AppImages.arrowDownIcon,
                                        height: 15,
                                        width: 15,
                                      ).commonSymmetricPadding(horizontal: 10),
                                      onChanged: (String? value) {
                                        payCheckesListScreenController
                                            .isLoading(true);
                                        payCheckesListScreenController
                                            .selectedFilterValue.value = value!;

                                        if (value == "All") {
                                          payCheckesListScreenController
                                                  .filterPayChecksListData =
                                              payCheckesListScreenController
                                                  .payCheckesListData;
                                        } else if (value == "Approved") {
                                          payCheckesListScreenController
                                                  .filterPayChecksListData =
                                              payCheckesListScreenController
                                                  .payCheckesListData
                                                  .where((element) =>
                                                      element
                                                          .approvepaychecks ==
                                                      "1")
                                                  .toList();
                                        } else if (value == "Not Approved") {
                                          payCheckesListScreenController
                                                  .filterPayChecksListData =
                                              payCheckesListScreenController
                                                  .payCheckesListData
                                                  .where((element) =>
                                                      element
                                                          .approvepaychecks ==
                                                      "0")
                                                  .toList();
                                        }
                                        payCheckesListScreenController
                                            .isLoading(false);
                                      },
                                    ).commonOnlyPadding(
                                        left: 10,
                                        right: 5,
                                        top: 10,
                                        bottom: 10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).commonAllSidePadding(10),*/
                      TextFormField(
                        controller: payCheckesListScreenController
                            .textSearchEditingController,
                        onChanged: (value) {
                          payCheckesListScreenController.isLoading(true);
                          payCheckesListScreenController.searchListFromSearchTextFunction(value);
                          payCheckesListScreenController.isLoading(false);
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputFieldStyles().inputBorder(),
                          focusedBorder: InputFieldStyles().inputBorder(),
                          errorBorder: InputFieldStyles().inputBorder(),
                          focusedErrorBorder: InputFieldStyles().inputBorder(),
                          fillColor: AppColors.colorWhite,
                          filled: true,
                          hintText: AppMessage.search,
                          hintStyle: const TextStyle(
                              color: AppColors.colorLightHintPurple2),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.colorLightHintPurple2,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 11),
                          suffixIcon: payCheckesListScreenController
                                  .textSearchEditingController.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    payCheckesListScreenController.isLoading(true);
                                    payCheckesListScreenController.filterPayChecksListData
                                    = payCheckesListScreenController.payCheckesListData;
                                    payCheckesListScreenController.textSearchEditingController.clear();
                                    payCheckesListScreenController.isLoading(false);
                                  },
                                  icon: const Icon(Icons.close,
                                      color: AppColors.colorLightHintPurple2),
                                ),
                        ),
                      ).commonOnlyPadding(left: 10, right: 10, top: 15),
                      payCheckesListScreenController
                              .filterPayChecksListData.isEmpty
                          ? Expanded(
                              child: Center(
                                child:
                                    Text(AppMessage.noHourlyPayChecksListFound),
                              ),
                            )
                          : PayCheckesListWidgetsScreen(),
                    ],
                  ),
      ),
    );
  }
}
