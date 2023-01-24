import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/pay_checkes_list_screen_controller.dart';
import 'package:payroll_system/screen/pay_checked_screen/pay_checkes_list_Screen/pay_checkes_list_widgets_screen.dart';
import 'package:payroll_system/screen/pay_checked_screen/pay_checkes_manage_screen/pay_checkes_manage_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';

import 'package:payroll_system/utils/messaging.dart';
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
          AppMessage.paycheckes,
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
                    child: Text(AppMessage.noPayCheckesListFound),
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
                      PayCheckesListWidgetsScreen(),
                    ],
                  ),
      ),
    );
  }
}
