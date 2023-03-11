import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/salary_paycheks_list_screen_controller.dart';
import 'package:payroll/screen/pay_checked_screen/salary_paycheks_manage_screen/salary_paycheks_manage_screen.dart';
import 'package:payroll/utils/app_images.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/style.dart';
import 'package:sizer/sizer.dart';

import 'salary_paycheks_list_screen_widgets.dart';

class SalaryPaychecksListScreen extends StatelessWidget {
  SalaryPaychecksListScreen({Key? key}) : super(key: key);

  final salaryPaychecksListScreenController =
      Get.put(SalaryPaychecksListScreenController());

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        title: Text(
          AppMessage.salaryPaycheckes,
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
                  () => SalaryPayChecksManageScreen(),
                  arguments: [
                    salaryPaychecksListScreenController.companyId,
                    salaryPaychecksListScreenController.companyName,
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
        () => salaryPaychecksListScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : salaryPaychecksListScreenController.salaryPayChecksList.isEmpty
                ? Center(
                    child: Text(AppMessage.noSalaryPayChecksListFound),
                  )
                : Column(
                    children: [
                      /*Row(
                        children: [
                          Text(
                            AppMessage.salaryPaycheckesList,
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
                                      value: salaryPaychecksListScreenController
                                          .selectedFilterValue.value,
                                      items: salaryPaychecksListScreenController
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
                                        salaryPaychecksListScreenController
                                            .isLoading(true);
                                        salaryPaychecksListScreenController
                                            .selectedFilterValue.value = value!;

                                        if (value == "All") {
                                          salaryPaychecksListScreenController
                                                  .filterSalaryPayChecksList =
                                              salaryPaychecksListScreenController
                                                  .salaryPayChecksList;
                                        } else if (value == "Approved") {
                                          salaryPaychecksListScreenController
                                                  .filterSalaryPayChecksList =
                                              salaryPaychecksListScreenController
                                                  .salaryPayChecksList
                                                  .where((element) =>
                                                      element
                                                          .approvepaychecks ==
                                                      "1")
                                                  .toList();
                                        } else if (value == "Not Approved") {
                                          salaryPaychecksListScreenController
                                                  .filterSalaryPayChecksList =
                                              salaryPaychecksListScreenController
                                                  .salaryPayChecksList
                                                  .where((element) =>
                                                      element
                                                          .approvepaychecks ==
                                                      "0")
                                                  .toList();
                                        }
                                        salaryPaychecksListScreenController
                                            .isLoading(false);
                                      },
                                    ).commonOnlyPadding(
                                        left: 10,
                                        right: 10,
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
                        controller: salaryPaychecksListScreenController
                            .textSearchEditingController,
                        onChanged: (value) {
                          salaryPaychecksListScreenController.isLoading(true);
                          salaryPaychecksListScreenController.searchListFromSearchTextFunction(value);
                          salaryPaychecksListScreenController.isLoading(false);
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputFieldStyles().inputBorder(),
                          focusedBorder: InputFieldStyles().inputBorder(),
                          errorBorder: InputFieldStyles().inputBorder(),
                          focusedErrorBorder: InputFieldStyles().inputBorder(),
                          fillColor: AppColors.colorWhite,
                          filled: true,
                          hintText: "${AppMessage.search} (${AppMessage.employeeName})",
                          hintStyle: const TextStyle(
                              color: AppColors.colorLightHintPurple2),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.colorLightHintPurple2,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 11),
                          suffixIcon: salaryPaychecksListScreenController
                              .textSearchEditingController.text.isEmpty
                              ? null
                              : IconButton(
                            onPressed: () {
                              salaryPaychecksListScreenController.isLoading(true);
                              salaryPaychecksListScreenController.filterSalaryPayChecksList
                              = salaryPaychecksListScreenController.salaryPayChecksList;
                              salaryPaychecksListScreenController.textSearchEditingController.clear();
                              salaryPaychecksListScreenController.isLoading(false);
                            },
                            icon: const Icon(Icons.close,
                                color: AppColors.colorLightHintPurple2),
                          ),
                        ),
                      ).commonOnlyPadding(left: 10, right: 10, top: 15),
                      salaryPaychecksListScreenController
                              .filterSalaryPayChecksList.isEmpty
                          ? Expanded(
                              child: Center(
                                child:
                                    Text(AppMessage.noSalaryPayChecksListFound),
                              ),
                            )
                          : SalaryPaychecksListModule(),
                    ],
                  ),
      ),
    );
  }
}
