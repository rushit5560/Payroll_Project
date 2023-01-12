import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/employee_list_screen_controller.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/enums.dart';
import 'employee_list_screen_widgets.dart';

class EmployeeListScreen extends StatelessWidget {
  EmployeeListScreen({super.key});

  final employeeListScreenController = Get.put(EmployeeListScreenController());
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorLightPurple2,
        appBar: AppBar(
          title: Text(employeeListScreenController.companyName,
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
                bool employeeCreatePermission =
                await userPreference.getBoolPermissionFromPrefs(
                    keyId: UserPreference.employeeAddKey);

                if (employeeCreatePermission == true) {
                  Get.to(
                        () => EmployeeManageScreen(),
                    arguments: [
                      EmployeeOption.create,
                      AppMessage.empty,
                      employeeListScreenController.companyId,
                      employeeListScreenController.companyName,
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
           /* FloatingActionButton(
              onPressed: () async {
                bool employeeCreatePermission =
                    await userPreference.getBoolPermissionFromPrefs(
                        keyId: UserPreference.employeeAddKey);

                if (employeeCreatePermission == true) {
                  Get.to(
                    () => EmployeeManageScreen(),
                    arguments: [
                      EmployeeOption.create,
                      AppMessage.empty,
                      employeeListScreenController.companyId,
                      employeeListScreenController.companyName,
                    ],
                  );
                } else {
                  Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                }
              },
              tooltip: "Add Employee",
              elevation: 0.0,
              child: const Icon(
                Icons.add_rounded,
                size: 30,
              ),
            ),*/
          ],
        ),
        body: Obx(
          () => employeeListScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : employeeListScreenController.allCompanyWiseEmployeeList.isEmpty
                  ? Center(child: Text(AppMessage.noEmpFound))
                  : Column(
                      children: [
                        TextFormField(
                          controller: employeeListScreenController
                              .textSearchEditingController,
                          onChanged: (value) {
                            employeeListScreenController.isLoading(true);

                            employeeListScreenController.searchEmployeeList =
                                employeeListScreenController
                                    .allCompanyWiseEmployeeList
                                    .where((element) =>
                                        element.firstName
                                            .toLowerCase()
                                            .contains(value) ||
                                        element.middleName
                                            .toLowerCase()
                                            .contains(value) ||
                                        element.lastName
                                            .toLowerCase()
                                            .contains(value) ||
                                        element.email
                                            .toLowerCase()
                                            .contains(value) ||
                                        element.mobileNumber
                                            .toLowerCase()
                                            .contains(value) ||
                                        element.departmentId
                                            .toLowerCase()
                                            .contains(value) ||
                                        element.companyid
                                            .toLowerCase()
                                            .contains(value))
                                    .toList();

                            employeeListScreenController.isLoading(false);
                            log("searchEmployeeList : ${employeeListScreenController.searchEmployeeList}");
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
                            suffixIcon: employeeListScreenController
                                    .textSearchEditingController.text.isEmpty
                                ? null
                                : IconButton(
                                    onPressed: () {
                                      employeeListScreenController
                                          .isLoading(true);
                                      employeeListScreenController
                                              .searchEmployeeList =
                                          employeeListScreenController
                                              .allCompanyWiseEmployeeList;
                                      employeeListScreenController
                                          .textSearchEditingController
                                          .clear();
                                      employeeListScreenController
                                          .isLoading(false);
                                    },
                                    icon: const Icon(Icons.close, color: AppColors.colorLightHintPurple2),
                                  ),
                          ),
                        ).commonOnlyPadding(left: 10, right: 10, top: 15),
                        Row(
                          children: [
                            Text(
                              AppMessage.employeeList,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ).commonAllSidePadding(10)
                          ],
                        ),
                        Expanded(child: EmployeeListScreenWidgets()),
                      ],
                    ),
        ),
      ),
    );
  }
}
