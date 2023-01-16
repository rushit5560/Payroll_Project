import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/logout_drawer_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/company_view_screen_controller.dart';
import 'package:payroll_system/screen/approve_paychecks_screens/approve_paychecks_list_screen/approve_paychecks_list_screen.dart';
import 'package:payroll_system/screen/authentication_screens/login_screen/login_screen.dart';
import 'package:payroll_system/screen/department_screens/department_list_screen/department_list_screen.dart';
import 'package:payroll_system/screen/employee_screens/employee_list_screen/employee_list_screen.dart';
import 'package:payroll_system/screen/locatioon_screen/location_list_screen/location_list_screen.dart';
import 'package:payroll_system/screen/pay_checked_screen/pay_checkes_manage_screen/pay_checkes_manage_screen.dart';
import 'package:payroll_system/screen/payroll_screen/payroll_list_screen/payroll_list_screen.dart';
import 'package:payroll_system/utils/app_images.dart';
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
                              imageStatus: true,
                              image: AppImages.departmentIcon,
                            ),
                            CompanyDrawerTile(
                              onTap: () {
                                Get.back();
                                Get.to(() => EmployeeListScreen(),
                                    arguments: [
                                  companyViewScreenController.companyId
                                      .toString(),
                                  companyViewScreenController.companyName,
                                ]);
                              },
                              title: AppMessage.employeeNameDrawer,
                              imageStatus: true,
                              image: AppImages.employeeIcon,
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
                              imageStatus: true,
                              image: AppImages.locationIcon,
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
                              imageStatus: false,
                              icon: const Icon(Icons.person, color: AppColors.colorBtBlue),
                            ),
                            CompanyDrawerTile(
                              onTap: () {
                                Get.back();
                                Get.to(() => ApprovePaychecksListScreen(),
                                    arguments: [
                                      companyViewScreenController.companyId
                                          .toString(),
                                      companyViewScreenController.companyName,
                                    ]);
                              },
                              title: AppMessage.approvePaycheckes,
                              imageStatus: false,
                              icon: const Icon(Icons.person, color: AppColors.colorBtBlue),
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
  bool imageStatus;
  Icon? icon;
  String? image;

  CompanyDrawerTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.imageStatus,
    this.icon,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: imageStatus == false
                ? icon
                : Image.asset(
                    image!,
                    height: 20,
                    width: 20,
                    color: AppColors.colorBtBlue,
                  ),
            title: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyleConfig.drawerTextStyle(),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded,
                color: AppColors.colorBtBlue),
          ),
          const Divider(height: 1, thickness: 1, indent: 10, endIndent: 10,
              color: AppColors.colorLightPurple2),
        ],
      ),
    );
  }
}
