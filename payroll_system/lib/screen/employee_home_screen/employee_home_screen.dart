import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/drawer_menu/employee_drawer/employee_drawer.dart';
import 'package:payroll_system/screen/profile_screens/employee_profile_screens/employee_profile_screen.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/employee_home_screen_controller.dart';
import '../../utils/extension_methods/user_preference.dart';

class EmployeeHomeScreen extends StatelessWidget {
  EmployeeHomeScreen({Key? key}) : super(key: key);

  final employeeHomeScreenController = Get.put(EmployeeHomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: EmployeeDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppMessage.employeeNameDrawer,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              var roleId = prefs.getInt(UserPreference.roleIdKey) ?? 0;

              log("roleId :: ${roleId}");

              if (roleId == 4) {
                Get.to(() => EmployeeProfileScreen());
              }
            },
            icon: const Icon(Icons.person_rounded),
          ),
        ],
      ),
    );
  }
}
