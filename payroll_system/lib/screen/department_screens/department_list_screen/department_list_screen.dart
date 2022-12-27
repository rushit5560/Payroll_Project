import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/department_list_screen_controller.dart';
import 'package:payroll_system/screen/department_screens/department_manage_screen/department_manage_screen.dart';
import 'package:payroll_system/utils/messaging.dart';

import '../../../utils/extension_methods/user_preference.dart';
import 'department_list_screen_widgets.dart';

class DepartmentListScreen extends StatelessWidget {
  DepartmentListScreen({Key? key}) : super(key: key);

  DepartmentListScreenController departmentListScreenController
  = Get.put(DepartmentListScreenController());

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(AppMessage.departmentList),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              bool departmentAddPermission = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.departmentEditKey);

              if (departmentAddPermission == true) {
                Get.to(() => DepartmentManageScreen(),
                  arguments: [DepartmentOption.create, ""],
                );
              } else {
                Fluttertoast.showToast(msg: AppMessage.deniedPermission);
              }
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),

      body: Obx(
            () => departmentListScreenController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : DepartmentListModule(),
      ),

    );
  }
}
