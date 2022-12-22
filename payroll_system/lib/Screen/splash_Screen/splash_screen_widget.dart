import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Controller/login_screen_controller.dart';
import 'package:payroll_system/Utils/style.dart';

class SplashScreenWidget extends StatelessWidget {
  SplashScreenWidget({super.key});

  final splashScreenController = Get.find<LoginController>();
  static const String KEYLOGIN='login';

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
            child: Text(
      "Splash Screen",
      style:
          TextStyleConfig.textStyle(fontSize: 50, fontWeight: FontWeight.bold),
    )));
  }
}
