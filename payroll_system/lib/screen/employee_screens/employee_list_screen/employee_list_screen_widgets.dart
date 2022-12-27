// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:payroll_system/Utils/extensions.dart';
// import 'package:payroll_system/constants/colors.dart';
// import 'package:payroll_system/controllers/employee_list_screen_controller.dart';
// import 'package:sizer/sizer.dart';
// import '../../../Utils/messaging.dart';
// import '../../../common_modules/custom_alert_dialog_module.dart';
// import '../../../common_modules/edit_and_delete_button_module.dart';
// import '../../../common_modules/single_item_module.dart';
// import '../employee_manage_screen/employee_manage_screen.dart';

// class EmployeeListScreenWidgets extends StatelessWidget {
//   EmployeeListScreenWidgets({super.key});
//   final employeeListScreenController = Get.find<EmployeeListScreenController>();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             physics: const BouncingScrollPhysics(),
//             itemCount: employeeListScreenController.allEmployeeList.length,
//             itemBuilder: (context, index) {
//               final value = employeeListScreenController.allEmployeeList[index];
//               return Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: AppColors.blackColor),
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 1.h),
//                     SingleListTileCustom(
//                       textKey: AppMessage.employeeName,
//                       textValue:
//                           value.firstName + value.middleName + value.lastName,
//                     ),
//                     SizedBox(height: 1.h),
//                     SingleListTileCustom(
//                       textKey: AppMessage.employeeEmail,
//                       textValue: value.email,
//                     ),
//                     SizedBox(height: 1.h),
//                     SingleListTileCustom(
//                       textKey: AppMessage.employeePhoneNumber,
//                       textValue: value.phoneNo,
//                     ),
//                     SizedBox(height: 2.h),
//                     SingleListTileCustom(
//                       textKey: AppMessage.employeeDepartmentName,
//                       textValue: value.departmentId.toString(),
//                     ),
//                     SizedBox(height: 2.h),
//                     SingleListTileCustom(
//                         textKey: AppMessage.employeeCompanyName,
//                         textValue: value.companyid.toString()),
//                     SizedBox(height: 2.h),
//                     SingleListTileCustom(
//                         textKey: AppMessage.employeeStatus,
//                         textValue: value.isActive),
//                     SizedBox(height: 3.h),
//                     EditAndDeleteButtonModule(
//                       onDeleteTap: () {
//                         CustomAlertDialog().showAlertDialog(
//                           context: context,
//                           textContent:
//                               'Are youe sure you want to delete employee ?',
//                           onYesTap: () async {
//                             log("Delete Employee");
//                             await employeeListScreenController
//                                 .deleteEmployeeFunction(
//                                     value.id.toString(), index);
//                           },
//                           onCancelTap: () {
//                             Get.back();
//                           },
//                         );
//                       },
//                       onEditTap: () {
//                         Get.to(
//                           EmployeeManageScreen(),
//                         );
//                       },
//                     )
//                   ],
//                 ).commonAllSidePadding(5),
//               ).commonOnlyPadding(bottom: 4.h);
//             },
//           ),
//         ),
//       ],
//     ).commonSymmetricPadding(horizontal: 3.w, vertical: 4.h);
//   }
// }
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Screen/employee_screens/employee_manage_screen/employee_manage_screen.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/employee_list_screen_controller.dart';
import 'package:payroll_system/screen/department_screens/department_manage_screen/department_manage_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../Utils/messaging.dart';
import '../../../common_modules/custom_alert_dialog_module.dart';
import '../../../common_modules/edit_and_delete_button_module.dart';
import '../../../common_modules/single_item_module.dart';

class EmployeeListScreenWidgets extends StatelessWidget {
  EmployeeListScreenWidgets({super.key});
  final employeeListScreenController = Get.find<EmployeeListScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: employeeListScreenController.allEmployeeList.length,
            itemBuilder: (context, index) {
              final value = employeeListScreenController.allEmployeeList[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blackColor),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    SingleListTileCustom(
                      textKey: AppMessage.employeeName,
                      textValue:
                          value.firstName + value.middleName + value.lastName,
                    ),
                    SizedBox(height: 1.h),
                    SingleListTileCustom(
                      textKey: AppMessage.employeeEmail,
                      textValue: value.email,
                    ),
                    SizedBox(height: 1.h),
                    SingleListTileCustom(
                      textKey: AppMessage.employeePhoneNumber,
                      textValue: value.phoneNo,
                    ),
                    SizedBox(height: 2.h),
                    SingleListTileCustom(
                      textKey: AppMessage.employeeDepartmentName,
                      textValue: value.departmentId.toString(),
                    ),
                    SizedBox(height: 2.h),
                    SingleListTileCustom(
                        textKey: AppMessage.employeeCompanyName,
                        textValue: value.companyid.toString()),
                    SizedBox(height: 2.h),
                    SingleListTileCustom(
                        textKey: AppMessage.employeeStatus,
                        textValue:
                            value.isActive == "1" ? "Active" : "In-Active"),
                    SizedBox(height: 3.h),
                    EditAndDeleteButtonModule(
                      onDeleteTap: () {
                        CustomAlertDialog().showAlertDialog(
                          context: context,
                          textContent:
                              'Are youe sure you want to delete employee ?',
                          onYesTap: () async {
                            log("Delete Employee");
                            await employeeListScreenController
                                .deleteEmployeeFunction(
                                    value.id.toString(), index);
                          },
                          onCancelTap: () {
                            Get.back();
                          },
                        );
                      },
                      onEditTap: () {
                        Get.to(
                          () => EmployeeManageScreen(),
                          arguments: [
                            EmployeeOption.update,
                            value.id.toString(),
                            log('111'),
                            log(value.id.toString())
                          ],
                        );
                      },
                    )
                  ],
                ).commonAllSidePadding(5),
              ).commonOnlyPadding(bottom: 4.h);
            },
          ),
        ),
      ],
    ).commonSymmetricPadding(horizontal: 3.w, vertical: 4.h);
  }
}
