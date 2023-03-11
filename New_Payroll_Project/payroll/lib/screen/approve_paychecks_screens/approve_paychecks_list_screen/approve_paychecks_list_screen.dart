import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/approve_paychecks_list_screen_controller.dart';
import 'package:payroll/screen/approve_paychecks_screens/approve_paychecks_list_screen/approve_paychecks_list_screen_widgets.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/style.dart';
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

                      TextFormField(
                        controller: approvePaychecksListScreenController
                            .textSearchEditingController,
                        onChanged: (value) {
                          approvePaychecksListScreenController.isLoading(true);
                          approvePaychecksListScreenController.searchListFromSearchTextFunction(value);
                          approvePaychecksListScreenController.isLoading(false);
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
                          suffixIcon: approvePaychecksListScreenController
                              .textSearchEditingController.text.isEmpty
                              ? null
                              : IconButton(
                            onPressed: () {
                              approvePaychecksListScreenController.isLoading(true);
                              approvePaychecksListScreenController.searchApprovePayCheckList
                              = approvePaychecksListScreenController.approvePaychecksList;
                              approvePaychecksListScreenController.textSearchEditingController.clear();
                              approvePaychecksListScreenController.isLoading(false);
                            },
                            icon: const Icon(Icons.close,
                                color: AppColors.colorLightHintPurple2),
                          ),
                        ),
                      ).commonOnlyPadding(left: 10, right: 10, top: 15),

                      approvePaychecksListScreenController.searchApprovePayCheckList.isEmpty
                      ? Center(child: Text(AppMessage.noApprovalPayCheckesListFound))
                      : ApprovePaychecksListWidgetsScreen(),
                    ],
                  ),
      ),
    );
  }
}
