import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/pay_checkes_list_screen_controller.dart';
import 'package:payroll_system/screen/pay_checked_screen/pay_checkes_manage_screen/pay_checkes_manage_screen.dart';

import 'package:payroll_system/utils/messaging.dart';

class PayCheckesListScreen extends StatelessWidget {
  PayCheckesListScreen({super.key});

  final payCheckesListScreenController =
      Get.put(PayCheckesListScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMessage.payRollList),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => PayCheckedManageScreen(),
                arguments: [
                  payCheckesListScreenController.companyId,
                  payCheckesListScreenController.companyName,
                ],
              );
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),

      
    );
  }
}
