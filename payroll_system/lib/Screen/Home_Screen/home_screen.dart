import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Controller/home_screen_controller.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/messaging.dart';
import '../../Utils/style.dart';
import '../../drawer_menu/admin_drawer/admin_drawer.dart';
import '../profile_screens/user_profile_screen.dart';

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
          AppMessage.adminName,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => UserProfileScreen());
            },
            icon: const Icon(Icons.person_rounded),
          ),
        ],
      ),
    );
  }
}
