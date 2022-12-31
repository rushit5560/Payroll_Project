import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/department_list_screen_controller.dart';
import 'package:payroll_system/screen/department_screens/department_manage_screen/department_manage_screen.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

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
        title: Text(departmentListScreenController.companyName),
        centerTitle: true,
        actions: [
          FloatingActionButton(
            onPressed: () async {
              bool departmentAddPermission = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.departmentEditKey);

              if (departmentAddPermission == true) {
                Get.to(() => DepartmentManageScreen(),
                  arguments: [
                    DepartmentOption.create,
                    AppMessage.empty,
                    departmentListScreenController.companyId,
                  ],
                );
              } else {
                Fluttertoast.showToast(msg: AppMessage.deniedPermission);
              }
            },
            tooltip: AppMessage.departmentCreate,
            elevation: 0.0,
            child: const Icon(
              Icons.add_rounded,
              size: 30,
            ),
          ),
        ],

      ),

      body: Obx(
        () => departmentListScreenController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : departmentListScreenController.allDepartmentList.isEmpty
                ? Center(child: Text(AppMessage.noDeptFound))
                : Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppMessage.departmentList,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ).commonAllSidePadding(10)
                        ],
                      ),
                      Expanded(child: DepartmentListModule()),
                    ],
                  ),
      ),
    );
  }
}
