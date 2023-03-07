import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/company_home_screen_controller.dart';
import 'package:payroll_system/drawer_menu/company_home_drawer/company_home_drawer.dart';
import 'package:payroll_system/screen/company_employee_screens/company_employee_manage_screen/company_employee_manage_screen.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';

import 'company_home_widgets_screen.dart';

class CompanyHomeScreen extends StatelessWidget {
  CompanyHomeScreen({super.key});

  final companyHomeScreenController = Get.put(CompanyHomeScreenController());
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return const HomeCustomMobileBackPressAlertDialog();
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        key: companyHomeScreenController.scaffoldKey,
        backgroundColor: AppColors.colorLightPurple2,
        drawer: CompanyHomeDrawer(),
        appBar: AppBar(
          title: Obx(
            () => companyHomeScreenController.isLoading.value
                ? Container()
                : Text(
                    companyHomeScreenController.companyName,
                    style: TextStyle(
                      color: AppColors.colorBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                    ),
                  ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => companyHomeScreenController.scaffoldKey.currentState!
                .openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Image.asset(
                AppImages.menuDrawerImg,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                bool employeeCreatePermission =
                    await userPreference.getBoolPermissionFromPrefs(
                        keyId: UserPreference.employeeAddKey);

                if (employeeCreatePermission == true) {
                  Get.to(
                    () => CompanyEmployeeManageScreen(),
                    arguments: [
                      EmployeeOption.create,
                      AppMessage.empty,
                      companyHomeScreenController.companyId.toString(),
                      companyHomeScreenController.companyName,
                    ],
                  );
                } else {
                  Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                }
              },
              icon: const Icon(
                Icons.add_rounded,
                size: 30,
              ),
              highlightColor: Colors.transparent,
            ),
          ],
        ),
        body: Obx(
          () => companyHomeScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : companyHomeScreenController.isEmployeeShowPermission.value ==
                      false
                  ? Center(child: Text(AppMessage.deniedPermission))
                  : companyHomeScreenController
                          .allCompanyWiseEmployeeList.isEmpty
                      ? Center(child: Text(AppMessage.noEmpFound))
                      : Column(
                          children: [
                            TextFormField(
                              controller: companyHomeScreenController
                                  .textSearchEditingController,
                              onChanged: (value) {
                                companyHomeScreenController.isLoading(true);

                                companyHomeScreenController.searchEmployeeList =
                                    companyHomeScreenController
                                        .allCompanyWiseEmployeeList
                                        .where((element) =>
                                            element.firstName
                                                .toLowerCase()
                                                .contains(value) ||
                                            element.middleName
                                                .toLowerCase()
                                                .contains(value) ||
                                            element.lastName
                                                .toLowerCase()
                                                .contains(value) ||
                                            element.email
                                                .toLowerCase()
                                                .contains(value) ||
                                            element.mobileNumber
                                                .toLowerCase()
                                                .contains(value) ||
                                            element.departmentId
                                                .toLowerCase()
                                                .contains(value) ||
                                            element.companyid
                                                .toLowerCase()
                                                .contains(value))
                                        .toList();
                                companyHomeScreenController
                                    .selectedFilterValue.value = "All";
                                companyHomeScreenController.isLoading(false);
                                log("searchEmployeeList : ${companyHomeScreenController.searchEmployeeList}");
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputFieldStyles().inputBorder(),
                                focusedBorder: InputFieldStyles().inputBorder(),
                                errorBorder: InputFieldStyles().inputBorder(),
                                focusedErrorBorder:
                                    InputFieldStyles().inputBorder(),
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
                                suffixIcon: companyHomeScreenController
                                        .textSearchEditingController
                                        .text
                                        .isEmpty
                                    ? null
                                    : IconButton(
                                        onPressed: () {
                                          companyHomeScreenController
                                              .isLoading(true);
                                          companyHomeScreenController
                                                  .searchEmployeeList =
                                              companyHomeScreenController
                                                  .allCompanyWiseEmployeeList;
                                          companyHomeScreenController
                                              .textSearchEditingController
                                              .clear();
                                          companyHomeScreenController
                                              .isLoading(false);
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                              ),
                            ).commonOnlyPadding(left: 10, right: 10, top: 15),
                            Row(
                              children: [
                                Text(
                                  AppMessage.employeeList,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: AppColors.colorBlack),
                                ).commonAllSidePadding(10),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.transparent),
                                        ),
                                        child: Center(
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration:
                                                const InputDecoration.collapsed(
                                                    hintText: ''),
                                            value: companyHomeScreenController
                                                .selectedFilterValue.value,
                                            items: companyHomeScreenController
                                                .filterList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            icon: Image.asset(
                                              AppImages.arrowDownIcon,
                                              height: 15,
                                              width: 15,
                                            ).commonSymmetricPadding(
                                                horizontal: 10),
                                            onChanged: (String? value) {
                                              companyHomeScreenController
                                                  .isLoading(true);
                                              companyHomeScreenController
                                                  .selectedFilterValue
                                                  .value = value!;
                                              companyHomeScreenController
                                                  .textSearchEditingController
                                                  .clear();
                                              companyHomeScreenController
                                                  .filterDropdownWiseFunction(
                                                      value);
                                              companyHomeScreenController
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
                                  ).commonOnlyPadding(
                                      left: 10, right: 10, top: 5),
                                ),
                              ],
                            ),
                            Expanded(
                              child: companyHomeScreenController
                                      .searchEmployeeList.isEmpty
                                  ? Center(child: Text(AppMessage.noEmpFound))
                                  : CompanyHomeScreenWidgets(),
                            ),
                          ],
                        ),
        ),
      ),
    );
  }
}
