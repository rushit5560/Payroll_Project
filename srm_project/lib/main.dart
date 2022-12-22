import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';
import 'package:srm_project/Screen/splash_Screen/splash_screen.dart';
import 'Screen/Authentication/Login_Screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: LoginScreen(),
          // home: const EmployeDetailsScreen(),
          // home: ImagePickerCustom(),
          home: SplashScreen()
        );
      },
    );
  }
}


// https://payroll.omdemo.co.in/api/getpermission/2