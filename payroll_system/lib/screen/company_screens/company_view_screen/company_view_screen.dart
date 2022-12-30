import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/company_view_screen_controller.dart';
import 'package:payroll_system/drawer_menu/company_drawer/company_drawer.dart';

class CompanyViewScreen extends StatelessWidget {
  CompanyViewScreen({Key? key}) : super(key: key);
  final companyViewScreenController = Get.put(CompanyViewScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyDrawerMenu(),
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Welcome To ${companyViewScreenController.companyName}'
        ),
      ),
    );
  }
}
