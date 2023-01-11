import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/logout_drawer_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/company_view_screen_controller.dart';
import 'package:payroll_system/screen/authentication_screens/login_screen/login_screen.dart';
import 'package:payroll_system/screen/department_screens/department_list_screen/department_list_screen.dart';
import 'package:payroll_system/screen/employee_screens/employee_list_screen/employee_list_screen.dart';
import 'package:payroll_system/screen/locatioon_screen/location_list_screen/location_list_screen.dart';
import 'package:payroll_system/screen/pay_checked_screen/pay_checkes_manage_screen/pay_checkes_manage_screen.dart';
import 'package:payroll_system/screen/payroll_screen/payroll_list_screen/payroll_list_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';

import '../../screen/pay_checked_screen/pay_checkes_list_Screen/pay_checkes_list_screen.dart';

class CompanyViewDrawerMenu extends StatelessWidget {
  CompanyViewDrawerMenu({Key? key}) : super(key: key);
  // final companyDrawerController = Get.put(CompanyDrawerController());
  final companyViewScreenController = Get.find<CompanyViewScreenController>();
  // final companyViewScreenController = Get.put(CompanyViewScreenController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Obx(
          () => companyViewScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CompanyDrawerTile(
                              onTap: () {
                                Get.back();
                                Get.to(() => DepartmentListScreen(),
                                    arguments: [
                                      companyViewScreenController.companyId
                                          .toString(),
                                      companyViewScreenController.companyName,
                                    ]);
                              },
                              title: AppMessage.departmentNameDrawer,
                            ),
                            CompanyDrawerTile(
                              onTap: () {
                                Get.back();
                                Get.to(() => EmployeeListScreen(), arguments: [
                                  companyViewScreenController.companyId
                                      .toString(),
                                  companyViewScreenController.companyName,
                                ]);
                              },
                              title: AppMessage.employeeNameDrawer,
                            ),
                            CompanyDrawerTile(
                              onTap: () {
                                Get.back();
                                Get.to(() => LocationListScreen(), arguments: [
                                  companyViewScreenController.companyId
                                      .toString(),
                                  companyViewScreenController.companyName,
                                ]);
                              },
                              title: AppMessage.location,
                            ),
                            CompanyDrawerTile(
                              onTap: () {
                                Get.back();
                                Get.to(() => PayCheckesListScreen(),
                                    arguments: [
                                      companyViewScreenController.companyId
                                          .toString(),
                                      companyViewScreenController.companyName,
                                    ]);
                              },
                              title: AppMessage.paycheckes,
                            ),
                            /*CompanyDrawerTile(
                              onTap: () {
                                Get.back();
                                Get.to(() => PayRollManageScreen(), arguments: [
                                  companyViewScreenController.companyId
                                      .toString(),
                                  companyViewScreenController.companyName,
                                ]);
                              },
                              title: AppMessage.payRoll,
                            ),*/
                            /*CompanyDrawerTile(
                              onTap: () {
                                Get.back();
                                Get.to(() => ChangePasswordScreen());
                              },
                              title: AppMessage.changePassword,
                            ),*/
                          ],
                        ),
                      ),
                    ),

                    /// Getting from common module
                    LogOutDrawerTileModule(
                      onTap: () async {
                        log('Logout');

                        CustomAlertDialog().showAlertDialog(
                          context: context,
                          textContent: AppMessage.logoutMessage,
                          onYesTap: () async {
                            await UserPreference()
                                .logoutRemoveUserDetailsFromPrefs()
                                .then(
                              (value) {
                                Get.offAll(() => LoginScreen());
                              },
                            );
                          },
                          onCancelTap: () {
                            Get.back();
                          },
                        );

                        // await UserPreference()
                        //     .logoutRemoveUserDetailsFromPrefs()
                        //     .then(
                        //   (value) {
                        //     Get.offAll(() => LoginScreen());
                        //   },
                        // );
                      },
                      title: AppMessage.logOutNameDrawer,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class CompanyDrawerTile extends StatelessWidget {
  Function() onTap;
  String title;

  CompanyDrawerTile({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading:
                const Icon(Icons.person_rounded, color: AppColors.blackColor),
            title: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyleConfig.drawerTextStyle(),
            ),
          ),
          const Divider(height: 1, thickness: 1, indent: 10, endIndent: 10),
        ],
      ),
    );
  }
}