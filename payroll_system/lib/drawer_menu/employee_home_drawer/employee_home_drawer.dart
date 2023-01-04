import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/drawer_list_tile_module.dart';
import 'package:payroll_system/common_modules/logout_drawer_tile_module.dart';
import 'package:payroll_system/controllers/employee_home_screen_controller.dart';
import 'package:payroll_system/screen/authentication_screens/change_password_screen/change_password_screen.dart';
import 'package:payroll_system/screen/authentication_screens/login_screen/login_screen.dart';
import 'package:payroll_system/screen/profile_screens/employee_profile_screens/employee_profile_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/messaging.dart';


class EmployeeHomeDrawerMenu extends StatelessWidget {
  EmployeeHomeDrawerMenu({Key? key}) : super(key: key);
  final employeeHomeScreenController = Get.find<EmployeeHomeScreenController>();

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
                        Get.to(() => EmployeeProfileScreen());
                      },
                      title: AppMessage.profile,
                    ),

                    DrawerListTileModule(
                      onTap: () {
                        Get.back();
                        Get.to(() => ChangePasswordScreen());
                      },
                      title: AppMessage.changePassword,
                    ),
                  ],
                ),
              ),
            ),
            /// Getting from common module
            LogOutDrawerTileModule(
              onTap: () async {
                CustomAlertDialog().showAlertDialog(
                  context: context,
                  textContent:
                  AppMessage.logoutMessage,
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
              title: AppMessage.logOutNameDrawer,
            ),
          ],
        ),
      ),
    );
  }
}



