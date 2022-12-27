import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/company_home_screen_controller.dart';
import 'package:payroll_system/drawer_menu/company_drawer/company_drawer.dart';
import 'package:payroll_system/screen/profile_screens/company_profile_screens/company_profile_screen.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/extension_methods/user_preference.dart';

class CompanyHomeScreen extends StatelessWidget {
  CompanyHomeScreen({Key? key}) : super(key: key);
  final companyHomeScreenController = Get.put(CompanyHomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppMessage.companyNameDrawer,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              var roleId = prefs.getInt(UserPreference.roleIdKey) ?? 0;

              log("roleId :: ${roleId}");

              if (roleId == 3) {
                Get.to(() => CompanyProfileScreen());
              }
            },
            icon: const Icon(Icons.person_rounded),
          ),
        ],
      ),
    );
  }
}
