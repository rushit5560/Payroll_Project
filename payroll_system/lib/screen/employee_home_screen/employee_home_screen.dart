import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/pay_checkes_dowanload_screen_controller.dart';
import 'package:payroll_system/drawer_menu/employee_home_drawer/employee_home_drawer.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/employee_home_screen_controller.dart';

class EmployeeHomeScreen extends StatelessWidget {
  EmployeeHomeScreen({Key? key}) : super(key: key);

  final employeeHomeScreenController = Get.put(EmployeeHomeScreenController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: employeeHomeScreenController.scaffoldKey,
      backgroundColor: AppColors.colorLightHintPurple2,
      drawer: EmployeeHomeDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => employeeHomeScreenController.scaffoldKey.currentState!
              .openDrawer(),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Image.asset(
              AppImages.menuDrawerImg,
            ),
          ),
        ),
        title: Text(
          AppMessage.employeeNameDrawer,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),

        /*actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              var roleId = prefs.getInt(UserPreference.roleIdKey) ?? 0;

              log("roleId :: ${roleId}");

              if (roleId == 4) {
                Get.to(() => EmployeeProfileScreen());
              }
            },
            icon: const Icon(Icons.person_rounded),
          ),
        ],*/
      ),
    );
  }
}
