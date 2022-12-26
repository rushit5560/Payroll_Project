import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/home_screen_controller.dart';
import 'package:payroll_system/screen/profile_screens/admin_profile_screens/admin_profile_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_details.dart';

import '../../Utils/messaging.dart';
import '../../drawer_menu/admin_drawer/admin_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScreenController.scaffoldKey,
      drawer: AdminDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppMessage.adminText,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AdminProfileScreen());
            },
            icon: const Icon(Icons.person_rounded),
          ),
        ],
      ),
    );
  }
}
