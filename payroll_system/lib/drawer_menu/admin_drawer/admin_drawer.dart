import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Screen/Authentication/Login_Screen/login_screen.dart';
import 'package:payroll_system/Screen/company_list_screen/company_list_screen.dart';
import 'package:payroll_system/Utils/extension_methods/user_preference.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';

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
                        Get.to(() => CompanyListScreen());
                      },
                      title: AppMessage.companyNameDrawer,
                    ),
                    AdminDrawerTile(
                      onTap: () {
                        log('Department');
                      },
                      title: AppMessage.departmentNameDrawer,
                    ),
                    AdminDrawerTile(
                      onTap: () {
                        log('Employee');
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
