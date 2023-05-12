import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/salary_paycheks_manage_screen_controller.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import 'salary_paycheks_manage_screen_widgets.dart';

class SalaryPayChecksManageScreen extends StatelessWidget {
  SalaryPayChecksManageScreen({Key? key}) : super(key: key);
  final salaryPayChecksManageScreenController = Get.put(SalaryPayChecksManageScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppMessage.createPaychecks,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
      ),

      body: Obx(() => salaryPayChecksManageScreenController.isLoading.value
          ? CommonLoader().showLoader()
          : SalaryPayChecksFormModule(),
      ),


    );
  }
}
