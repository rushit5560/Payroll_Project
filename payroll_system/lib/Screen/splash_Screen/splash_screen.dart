import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Controller/login_screen_controller.dart';

import 'splash_screen_widget.dart';


class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
  final signUpScreenController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: SplashScreenWidget()),
    );
  }
}
