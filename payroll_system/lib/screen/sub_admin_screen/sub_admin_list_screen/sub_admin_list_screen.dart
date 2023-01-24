import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/sub_admin_list_screen_controller.dart';
import 'package:payroll_system/screen/sub_admin_screen/sub_admin_list_screen/sub_admin_list_widget_screen.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';

class SubAdminListScreen extends StatelessWidget {
  SubAdminListScreen({super.key});

  final subAdminListScreenController = Get.put(SubAdminListScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        title: Text(
          AppMessage.subAdminText,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body:
          // const Center(
          //   child: Text("Comming soon"),
          // )

          Obx(
        () => subAdminListScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : subAdminListScreenController.subadminListData.isEmpty
                ? Center(
                    child: Text(AppMessage.noSubAdminListFound),
                  )
                : Column(
                    children: [
                      TextFormField(
                        controller: subAdminListScreenController
                            .textSearchEditingController,
                        onChanged: (value) {
                          subAdminListScreenController.isLoading(true);

                          subAdminListScreenController.searchSubadminDataList =
                              subAdminListScreenController.subadminListData
                                  .where((element) => element.fullName
                                      .toLowerCase()
                                      .contains(value))
                                  .toList();

                          subAdminListScreenController.isLoading(false);
                          log("searchEmployeeList : ${subAdminListScreenController.searchSubadminDataList}");
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputFieldStyles().inputBorder(),
                          focusedBorder: InputFieldStyles().inputBorder(),
                          errorBorder: InputFieldStyles().inputBorder(),
                          focusedErrorBorder: InputFieldStyles().inputBorder(),
                          hintText: AppMessage.search,
                          fillColor: AppColors.colorWhite,
                          filled: true,
                          hintStyle: const TextStyle(
                              color: AppColors.colorLightHintPurple2),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 11),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.colorLightHintPurple2,
                          ),
                          suffixIcon: subAdminListScreenController
                                  .textSearchEditingController.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    subAdminListScreenController
                                        .isLoading(true);
                                    subAdminListScreenController
                                            .searchSubadminDataList =
                                        subAdminListScreenController
                                            .subadminListData;
                                    subAdminListScreenController
                                        .textSearchEditingController
                                        .clear();
                                    subAdminListScreenController
                                        .isLoading(false);
                                  },
                                  icon: const Icon(Icons.close,
                                      color: AppColors.colorLightHintPurple2),
                                ),
                        ),
                      ).commonOnlyPadding(left: 10, right: 10, top: 15),
                      Row(
                        children: [
                          Text(
                            AppMessage.subAdminListText,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: AppColors.colorBlack),
                          ),
                        ],
                      ).commonAllSidePadding(10),
                      // const SizedBox(height: 5),
                      Expanded(child: SubAdminListWidgetsScreen()),
                    ],
                  ),
      ),
    );
  }
}
