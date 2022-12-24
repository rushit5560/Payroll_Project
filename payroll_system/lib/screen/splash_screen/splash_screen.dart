import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/splash_screen_controller.dart';
import 'package:sizer/sizer.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Image.asset(
          "assets/images/logo.png",
          width: 70.w,
        )

            // Text(
            //   "Splash Screen",
            //   style: TextStyleConfig.textStyle(
            //     fontSize: 50,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            ),
      ),
    );
  }
}
