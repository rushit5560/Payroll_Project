import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/company_view_screen_controller.dart';
import 'package:payroll_system/drawer_menu/company_view_drawer/company_view_drawer.dart';

class CompanyViewScreen extends StatelessWidget {
  CompanyViewScreen({Key? key}) : super(key: key);
  final companyViewScreenController = Get.put(CompanyViewScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyViewDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(companyViewScreenController.companyName),
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
