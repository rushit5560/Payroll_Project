import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/company_view_screen_controller.dart';
import 'package:payroll/drawer_menu/company_view_drawer/company_view_drawer.dart';
import 'package:payroll/utils/app_images.dart';
import 'package:sizer/sizer.dart';

class CompanyViewScreen extends StatelessWidget {
  CompanyViewScreen({Key? key}) : super(key: key);
  final companyViewScreenController = Get.put(CompanyViewScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: companyViewScreenController.scaffoldKey,
      backgroundColor: AppColors.colorLightPurple2,
      drawer: CompanyViewDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => companyViewScreenController.scaffoldKey.currentState!
              .openDrawer(),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Image.asset(
              AppImages.menuDrawerImg,
            ),
          ),
        ),
        title: Text(
          companyViewScreenController.companyName,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Get.offAll(()=> HomeScreen());
              Get.back();
            },
            icon: const Icon(Icons.home_rounded),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome To ${companyViewScreenController.companyName}'),
      ),
    );
  }
}
