import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:payroll_system/Controller/user_profile_screen_controller.dart';
import 'package:payroll_system/common_modules/common_loader.dart';

import '../../Utils/style.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  final userProfileScreenController = Get.put(UserProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => userProfileScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                ),
        ),
      ),
    );
  }
}
