import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'Screen/splash_Screen/splash_screen.dart';
import 'constants/colors.dart';

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
          title: 'Payroll System',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: "Roboto",
            appBarTheme: const AppBarTheme(
              color: AppColors.colorWhite,
              elevation: 0.0,
              iconTheme: IconThemeData(color: AppColors.colorBlack),
            ),
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
