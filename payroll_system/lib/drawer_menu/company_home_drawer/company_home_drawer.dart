import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/drawer_list_tile_module.dart';
import 'package:payroll_system/common_modules/logout_drawer_tile_module.dart';
import 'package:payroll_system/controllers/company_home_screen_controller.dart';
import 'package:payroll_system/screen/authentication_screens/change_password_screen/change_password_screen.dart';
import 'package:payroll_system/screen/authentication_screens/login_screen/login_screen.dart';
import 'package:payroll_system/screen/department_screens/department_list_screen/department_list_screen.dart';
import 'package:payroll_system/screen/locatioon_screen/location_list_screen/location_list_screen.dart';
import 'package:payroll_system/screen/profile_screens/company_profile_screens/company_profile_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/messaging.dart';

class CompanyHomeDrawer extends StatelessWidget {
  CompanyHomeDrawer({Key? key}) : super(key: key);
  final companyHomeScreenController = Get.put(CompanyHomeScreenController());

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
                    DrawerListTileModule(
                      onTap: () {
                        Get.back();
                        Get.to(() => CompanyProfileScreen());
                      },
                      title: AppMessage.profile,
                    ),
                    DrawerListTileModule(
                      onTap: () {
                        Get.back();
                        Get.to(() => DepartmentListScreen(),
                        
                         arguments: [
                          companyHomeScreenController.companyId.toString(),
                          companyHomeScreenController.companyName,
                        ]);
                      },
                      title: AppMessage.departmentNameDrawer,
                    ),
                    DrawerListTileModule(
                      onTap: () {
                        Get.back();
                        Get.to(() => LocationListScreen());
                      },
                      title: AppMessage.location,
                    ),
                    DrawerListTileModule(
                      title: AppMessage.changePasswordDrawer,
                      onTap: () {
                        Get.back();
                        Get.to(() => ChangePasswordScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// Getting from common module
            LogOutDrawerTileModule(
              title: AppMessage.logOutNameDrawer,
              onTap: () async {
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
