import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srm_project/Controller/login_screen_controller.dart';
import 'package:srm_project/Utils/style.dart';

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
