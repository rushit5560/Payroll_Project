import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/splash_screen_controller.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBlue,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            AppImages.logoWhiteImg,
            width: 70.w,
          ),
        ),
      ),
    );
  }
}
