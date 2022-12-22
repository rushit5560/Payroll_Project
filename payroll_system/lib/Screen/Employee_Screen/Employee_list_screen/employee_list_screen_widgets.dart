import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../Utils/messaging.dart';
import '../../../common_modules/custom_alert_dialog_module.dart';
import '../../../common_modules/edit_and_delete_button_module.dart';
import '../../../common_modules/single_item_module.dart';
import '../employee_details_screen.dart';

class EmployeeListScreenWidgets extends StatelessWidget {
  const EmployeeListScreenWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blackColor),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    SingleListTileCustom(
                      textKey: AppMessage.employeeName,
                      textValue: AppMessage.employeeName,
                    ),
                    SizedBox(height: 1.h),
                    SingleListTileCustom(
                      textKey: AppMessage.employeeEmail,
                      textValue: AppMessage.employeeEmail,
                    ),
                    SizedBox(height: 1.h),
                    SingleListTileCustom(
                      textKey: AppMessage.employeePhoneNumber,
                      textValue: AppMessage.employeePhoneNumber,
                    ),
                    SizedBox(height: 2.h),
                    SingleListTileCustom(
                      textKey: AppMessage.employeeDepartmentName,
                      textValue: AppMessage.employeeDepartmentName,
                    ),
                    SizedBox(height: 2.h),
                    SingleListTileCustom(
                        textKey: AppMessage.employeeCompanyName,
                        textValue: AppMessage.employeeCompanyName),
                    SizedBox(height: 2.h),
                    SingleListTileCustom(
                        textKey: AppMessage.employeeStatus,
                        textValue: AppMessage.employeeStatus),
                    SizedBox(height: 3.h),
                    EditAndDeleteButtonModule(
                      onDeleteTap: () {
                        CustomAlertDialog().showAlertDialog(
                          context: context,
                          textContent:
                              'Are youe sure you want to delete employee ?',
                          onYesTap: () {},
                          onCancelTap: () {
                            Get.back();
                          },
                        );
                      },
                      onEditTap: () {
                        Get.to(
                          EmployeeDetailsScreen(),
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
