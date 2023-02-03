import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/screen/approve_paychecks_screens/approve_pay_checkes_details_manage_screen/approve_pay_checkes_details_manage_widgets_screen.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/approve_paycheckes_detail_manage_screen_controller.dart';


class ApprovePayCheckesDetailsManageScreen extends StatelessWidget {
  ApprovePayCheckesDetailsManageScreen({
    super.key,
  });

  final approvePayCheckesDetailsScreenController =
      Get.put(ApprovePayCheckesDetailsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.colorWhite,
        title: Text(
          approvePayCheckesDetailsScreenController.companyName,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
      ),
      body: Obx(
        () => approvePayCheckesDetailsScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppMessage.approvalPaycheckes,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: AppColors.colorBlack,
                        ),
                      ),
                    ],
                  ).commonAllSidePadding(10),
                  Expanded(
                    child: ApprovePayCheckesDetailsManageWidgetsScreen(),
                  ),
                ],
              ),
      ),
    );
  }
}
