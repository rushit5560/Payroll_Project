import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/department_list_screen_controller.dart';
import 'package:payroll_system/screen/department_screens/department_manage_screen/department_manage_screen.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/extension_methods/user_preference.dart';
import 'department_list_screen_widgets.dart';

class DepartmentListScreen extends StatelessWidget {
  DepartmentListScreen({Key? key}) : super(key: key);

  DepartmentListScreenController departmentListScreenController = Get.put(DepartmentListScreenController());

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,

      appBar: AppBar(
        title: Text(
          departmentListScreenController.companyName,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              bool departmentAddPermission =
              await userPreference.getBoolPermissionFromPrefs(
                  keyId: UserPreference.departmentEditKey);

              if (departmentAddPermission == true) {
                Get.to(
                      () => DepartmentManageScreen(),
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
            icon: const Icon(
              Icons.add_rounded,
              size: 30,
            ),
            highlightColor: Colors.transparent,
          ),
        ],
      ),


      body: Obx(
        () => departmentListScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : departmentListScreenController.allDepartmentList.isEmpty
                ? Center(child: Text(AppMessage.noDeptFound))
                : Column(
                    children: [
                      TextFormField(
                        controller: departmentListScreenController.textSearchEditingController,
                        onChanged: (value) {
                          departmentListScreenController.isLoading(true);

                          departmentListScreenController.searchDepartmentDataList =
                              departmentListScreenController.allDepartmentList
                                  .where((element) => element.departmentName
                                      .toLowerCase().contains(value)).toList();

                          departmentListScreenController.isLoading(false);
                          log("searchEmployeeList : ${departmentListScreenController.searchDepartmentDataList}");
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputFieldStyles().inputBorder(),
                          focusedBorder: InputFieldStyles().inputBorder(),
                          errorBorder: InputFieldStyles().inputBorder(),
                          focusedErrorBorder: InputFieldStyles().inputBorder(),
                          fillColor: AppColors.colorWhite,
                          filled: true,
                          hintText: AppMessage.search,
                          hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.colorLightHintPurple2,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                          suffixIcon: departmentListScreenController.textSearchEditingController.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    departmentListScreenController.isLoading(true);
                                    departmentListScreenController.searchDepartmentDataList =
                                        departmentListScreenController.allDepartmentList;
                                    departmentListScreenController.textSearchEditingController.clear();
                                    departmentListScreenController.isLoading(false);
                                  },
                                  icon: const Icon(Icons.close,color: AppColors.colorLightHintPurple2),
                                ),
                        ),
                      ).commonOnlyPadding(left: 10, right: 10, top: 15),

                    
                      Row(
                        children: [
                          Text(
                            AppMessage.departmentList,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AppColors.colorBlack),
                          ).commonAllSidePadding(14)
                        ],
                      ),
                      Expanded(child: DepartmentListModule()),
                    ],
                  ),
      ),
    );
  }
}
