import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/employee_list_screen_controller.dart';
import 'package:payroll/screen/employee_screens/employee_manage_screen/employee_manage_screen.dart';
import 'package:payroll/utils/app_images.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/style.dart';
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
          title: Text(
            employeeListScreenController.companyName,
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
                                        // element.departmentId
                                        //     .toLowerCase()
                                        //     .contains(value) ||
                                        element.companyid
                                            .toLowerCase()
                                            .contains(value))
                                    .toList();
                            employeeListScreenController
                                .selectedFilterValue.value = "All";
                            employeeListScreenController.isLoading(false);
                          },
                          decoration: InputDecoration(
                            enabledBorder: InputFieldStyles().inputBorder(),
                            focusedBorder: InputFieldStyles().inputBorder(),
                            errorBorder: InputFieldStyles().inputBorder(),
                            focusedErrorBorder:
                                InputFieldStyles().inputBorder(),
                            fillColor: AppColors.colorWhite,
                            filled: true,
                            hintText: AppMessage.search,
                            hintStyle: const TextStyle(
                                color: AppColors.colorLightHintPurple2),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.colorLightHintPurple2,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 11),
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
                                    icon: const Icon(Icons.close,
                                        color: AppColors.colorLightHintPurple2),
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
                            ).commonAllSidePadding(10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Colors.transparent),
                                    ),
                                    child: Center(
                                      child: DropdownButtonFormField<String>(
                                        decoration:
                                            const InputDecoration.collapsed(
                                                hintText: ''),
                                        value: employeeListScreenController
                                            .selectedFilterValue.value,
                                        items: employeeListScreenController
                                            .filterList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        borderRadius: BorderRadius.circular(10),
                                        icon: Image.asset(
                                          AppImages.arrowDownIcon,
                                          height: 15,
                                          width: 15,
                                        ).commonSymmetricPadding(
                                            horizontal: 10),
                                        onChanged: (String? value) {
                                          employeeListScreenController
                                              .isLoading(true);
                                          employeeListScreenController
                                              .selectedFilterValue
                                              .value = value!;
                                          employeeListScreenController
                                              .textSearchEditingController
                                              .clear();
                                          employeeListScreenController
                                              .filterDropdownWiseFunction(
                                                  value);
                                          employeeListScreenController
                                              .isLoading(false);
                                        },
                                      ).commonOnlyPadding(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 10),
                                    ),
                                  ),
                                ),
                              ).commonOnlyPadding(left: 10, right: 10, top: 5),
                            ),
                          ],
                        ),
                        Expanded(
                          child: employeeListScreenController
                                  .searchEmployeeList.isEmpty
                              ? Center(child: Text(AppMessage.noEmpFound))
                              : EmployeeListScreenWidgets(),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
