import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/screen/authentication_screens/login_screen/login_screen.dart';
import 'package:payroll_system/screen/company_screens/company_list_screen/company_list_screen.dart';

import 'package:payroll_system/screen/department_screens/department_list_screen/department_list_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';

import '../../screen/employee_screens/employee_list_screen/employee_list_screen.dart';



class AdminDrawerMenu extends StatelessWidget {
  const AdminDrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AdminDrawerTile(
                      onTap: () {
                        Get.back();
                        Get.to(() => CompanyListScreen());
                      },
                      title: AppMessage.companyNameDrawer,
                    ),
                    AdminDrawerTile(
                      onTap: () {
                        Get.back();
                        Get.to(() => DepartmentListScreen());
                      },
                      title: AppMessage.departmentNameDrawer,
                    ),
                    AdminDrawerTile(
                      onTap: () {
                        Get.back();
                        Get.to(() => EmployeeListScreen());
                      },
                      title: AppMessage.employeeNameDrawer,
                    ),
                  ],
                ),
              ),
            ),
            AdminDrawerLogOutTile(
              onTap: () async {
                log('Logout');

                await UserPreference().logoutRemoveUserDetailsFromPrefs().then(
                  (value) {
                    Get.offAll(() => LoginScreen());
                  },
                );
              },
              title: AppMessage.logOutNameDrawer,
            ),
          ],
        ),
      ),
    );
  }
}

class AdminDrawerTile extends StatelessWidget {
  Function() onTap;
  String title;
  AdminDrawerTile({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyleConfig.drawerTextStyle(),
          ).commonSymmetricPadding(horizontal: 10, vertical: 10),
          const Divider(height: 1, thickness: 1, indent: 10, endIndent: 10),
        ],
      ),
    );
    /*return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.greyColor,
        ),
      ),

      child: Text(
        AppMessage.companyNameDrawer,
        textAlign: TextAlign.left,
        style: TextStyleConfig.drawerTextStyle(),
      ).commonSymmetricPadding(horizontal: 10, vertical: 5),

    ).commonSymmetricPadding(horizontal: 20, vertical: 10);*/
  }
}

class AdminDrawerLogOutTile extends StatelessWidget {
  Function() onTap;
  String title;
  AdminDrawerLogOutTile({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1, thickness: 1, indent: 10, endIndent: 10),
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyleConfig.drawerTextStyle(),
          ).commonSymmetricPadding(horizontal: 10, vertical: 10),
          const Divider(height: 1, thickness: 1, indent: 10, endIndent: 10),
        ],
      ),
    );
    /*return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.greyColor,
        ),
      ),

      child: Text(
        AppMessage.companyNameDrawer,
        textAlign: TextAlign.left,
        style: TextStyleConfig.drawerTextStyle(),
      ).commonSymmetricPadding(horizontal: 10, vertical: 5),

    ).commonSymmetricPadding(horizontal: 20, vertical: 10);*/
  }
}
