import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll/common_modules/logout_drawer_tile_module.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/company_view_screen_controller.dart';
import 'package:payroll/screen/approve_paychecks_screens/approve_paychecks_list_screen/approve_paychecks_list_screen.dart';
import 'package:payroll/screen/authentication_screens/login_screen/login_screen.dart';
import 'package:payroll/screen/department_screens/department_list_screen/department_list_screen.dart';
import 'package:payroll/screen/employee_screens/employee_list_screen/employee_list_screen.dart';
import 'package:payroll/screen/locatioon_screen/location_list_screen/location_list_screen.dart';
import 'package:payroll/screen/pay_checked_screen/salary_paycheks_list_screen/salary_paycheks_list_screen.dart';
import 'package:payroll/utils/app_images.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/style.dart';

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
              : SingleChildScrollView(
            child: Column(
              children: [
                /*companyViewScreenController.isDepartmentShowPermission.value == true
                              ? CompanyDrawerTile(
                                  onTap: () {
                                    Get.back();
                                    Get.to(() => DepartmentListScreen(),
                                        arguments: [
                                          companyViewScreenController.companyId.toString(),
                                          companyViewScreenController.companyName,
                                        ]);
                                  },
                                  title: AppMessage.departmentNameDrawer,
                                  imageStatus: true,
                                )
                              : const SizedBox(),*/
                companyViewScreenController.isLocationShowPermission.value == true
                    ? CompanyDrawerTile(
                  onTap: () {
                    Get.back();
                    Get.to(() => LocationListScreen(),
                        arguments: [
                          companyViewScreenController.companyId.toString(),
                          companyViewScreenController.companyName,
                        ]);
                  },
                  title: AppMessage.location,
                  imageStatus: true,
                  image: AppImages.locationIcon,
                )
                    : const SizedBox(),
                companyViewScreenController.isEmployeeShowPermission.value == true
                    ? CompanyDrawerTile(
                  onTap: () {
                    Get.back();
                    Get.to(() => EmployeeListScreen(),
                        arguments: [
                          companyViewScreenController.companyId.toString(),
                          companyViewScreenController.companyName,
                        ]);
                  },
                  title: AppMessage.employeeNameDrawer,
                  imageStatus: true,
                  image: AppImages.employeeIcon,
                )
                    : const SizedBox(),
                companyViewScreenController.isPayChecksShowPermission.value == true
                    ? CompanyDrawerTile(
                  onTap: () {
                    Get.back();
                    Get.to(() => PayCheckesListScreen(),
                        arguments: [
                          companyViewScreenController.companyId.toString(),
                          companyViewScreenController.companyName,
                        ]);
                  },
                  title: AppMessage.hourlyPaycheckes,
                  imageStatus: true,
                  image: AppImages.paycheckIcon,
                )
                    : const SizedBox(),

                companyViewScreenController.isPayChecksShowPermission.value == true
                    ? CompanyDrawerTile(
                  onTap: () {
                    Get.back();
                    Get.to(() => SalaryPaychecksListScreen(),
                        arguments: [
                          companyViewScreenController.companyId.toString(),
                          companyViewScreenController.companyName,
                        ]);
                  },
                  title: AppMessage.salaryPaycheckes,
                  imageStatus: true,
                  image: AppImages.paycheckIcon,
                )
                    : const SizedBox(),

                companyViewScreenController.isApprovePayChecksShowPermission.value == true
                    ? CompanyDrawerTile(
                  onTap: () {
                    Get.back();
                    Get.to(() => ApprovePaychecksListScreen(),
                        arguments: [
                          companyViewScreenController.companyId.toString(),
                          companyViewScreenController.companyName,
                        ]);
                  },
                  title: AppMessage.approvePaycheckes,
                  imageStatus: true,
                  image: AppImages.approveIcon,
                )
                    : const SizedBox(),

              ],
            ),
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
          const Divider(
              height: 1,
              thickness: 1,
              indent: 10,
              endIndent: 10,
              color: AppColors.colorLightPurple2),
        ],
      ),
    );
  }
}