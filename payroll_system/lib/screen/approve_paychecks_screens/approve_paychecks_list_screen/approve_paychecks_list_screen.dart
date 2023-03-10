import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/approve_paychecks_list_screen_controller.dart';
import 'package:payroll_system/screen/approve_paychecks_screens/approve_paychecks_list_screen/approve_paychecks_list_screen_widgets.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class ApprovePaychecksListScreen extends StatelessWidget {
  ApprovePaychecksListScreen({Key? key}) : super(key: key);
  final approvePaychecksListScreenController =
      Get.put(ApprovePaychecksListScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.colorWhite,
        title: Text(
          approvePaychecksListScreenController.companyName,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
      ),
      body: Obx(
        () => approvePaychecksListScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : approvePaychecksListScreenController.approvePaychecksList.isEmpty
                ? Center(child: Text(AppMessage.noApprovalPayCheckesListFound))
                : Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppMessage.approvalPaycheckesList,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: AppColors.colorBlack,
                            ),
                          ),
                        ],
                      ).commonAllSidePadding(10),
                      ApprovePaychecksListWidgetsScreen(),
                    ],
                  ),
      ),
    );
  }
}
