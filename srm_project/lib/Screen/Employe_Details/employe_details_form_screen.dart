import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srm_project/Controller/employe_details_form_screen_controller.dart';
import 'package:srm_project/Screen/Employe_Details/employe_details_form_screen_widget.dart';
import 'package:srm_project/constants/colors.dart';

class EmployeDetailsScreen extends StatelessWidget {
  EmployeDetailsScreen({super.key});
  final employeDetailsFormController = Get.put(EmployeDetailsFormScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.mainBackWhitegroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.blackColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.close,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
        body: EmployeDetailsScreenBody(),
      ),
    );
  }
}
