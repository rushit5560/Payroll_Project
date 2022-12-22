import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Controller/company_list_screen_controller.dart';
import 'package:payroll_system/Utils/messaging.dart';

import 'company_list_screen_widgets.dart';

class CompanyListScreen extends StatelessWidget {
  CompanyListScreen({Key? key}) : super(key: key);
  final companyListScreenController = Get.put(CompanyListScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(AppMessage.companiesName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),


      body: CompanyListModule(),


    );
  }
}
