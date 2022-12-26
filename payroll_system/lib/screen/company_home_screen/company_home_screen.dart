import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/drawer_menu/company_drawer/company_drawer.dart';
import 'package:payroll_system/utils/messaging.dart';

class CompanyHomeScreen extends StatelessWidget {
  const CompanyHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppMessage.companyNameDrawer,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Get.to(() => CompanyProfileScreen());
        //     },
        //     icon: const Icon(Icons.person_rounded),
        //   ),
        // ],
      ),
    );
  }
}
