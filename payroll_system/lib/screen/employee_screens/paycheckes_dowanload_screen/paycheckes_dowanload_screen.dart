import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/pay_checkes_dowanload_screen_controller.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import 'paycheckes_dowanload_widgets_screen.dart';

class PayCheckesDowanloadListScreen extends StatelessWidget {
  PayCheckesDowanloadListScreen({super.key});

  final payCheckesDowanloadScreenController =
      Get.put(PayCheckesDowanloadScreenController());

  @override
  Widget build(BuildContext context) {
    log("payChecksDownloadScreenController employeeId  ${payCheckesDowanloadScreenController.employeeId}");
    log("payChecksDownloadScreenController employeeName  ${payCheckesDowanloadScreenController.employeeName}");

    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        title: Text(
          AppMessage.paycheckesDownload,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Get.to(
        //         () => PayCheckedManageScreen(),
        //         arguments: [
        //           payCheckesDowanloadScreenController.companyId.toString(),
        //           payCheckesDowanloadScreenController.companyName,
        //         ],
        //       );
        //     },
        //     icon: const Icon(Icons.add_rounded),
        //   ),
        // ],
      ),
      body: Obx(
        () => payCheckesDowanloadScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : payCheckesDowanloadScreenController
                    .payCheckDwanloadListData.isEmpty
                ? Center(
                    child: Text(AppMessage.noPayChecksListFound),
                  )
                : Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppMessage.paycheckesList,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: AppColors.colorBlack),
                          ),
                        ],
                      ).commonAllSidePadding(10),
                      // const SizedBox(height: 5),
                      PayCheckesDowanloadWidgetsListScreen(),
                    ],
                  ),
      ),
    );
  }
}
