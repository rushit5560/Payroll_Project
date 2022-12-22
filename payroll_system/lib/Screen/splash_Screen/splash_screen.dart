import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Controller/splash_screen_controller.dart';

import '../../Utils/style.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "Splash Screen",
            style: TextStyleConfig.textStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
