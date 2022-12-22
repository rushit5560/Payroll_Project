import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srm_project/Controller/login_screen_controller.dart';
import 'package:srm_project/Screen/splash_Screen/splash_screen_widget.dart';


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
