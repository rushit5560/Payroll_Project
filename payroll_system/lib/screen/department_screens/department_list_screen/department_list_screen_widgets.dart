import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/edit_and_delete_button_module.dart';
import 'package:payroll_system/common_modules/single_item_module.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/department_list_screen_controller.dart';
import 'package:payroll_system/models/company_manage_screen_model/get_all_department_model.dart';
import 'package:payroll_system/screen/department_screens/department_manage_screen/department_manage_screen.dart';
import 'package:payroll_system/utils/messaging.dart';

import '../../../utils/extension_methods/user_preference.dart';

class DepartmentListModule extends StatelessWidget {
  DepartmentListModule({Key? key}) : super(key: key);
  final screenController = Get.find<DepartmentListScreenController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: screenController.allDepartmentList.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) {
        DepartmentData singleItem = screenController.allDepartmentList[i];
        return DepartmentListTile(singleItem: singleItem, index: i);
      },
    );
  }
}

class DepartmentListTile extends StatelessWidget {
  DepartmentData singleItem;
  int index;

  DepartmentListTile({Key? key, required this.singleItem, required this.index})
      : super(key: key);

  final screenController = Get.find<DepartmentListScreenController>();
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.greyColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              /// Getting From Common Module
              SingleListTileCustom(
                textKey: AppMessage.employeeDepartmentName,
                textValue: singleItem.departmentName,
              ),

              /// Getting From Common Module
              SingleListTileCustom(
                textKey: AppMessage.verifiedStatusName,
                textValue: singleItem.isActive == "1" ? "Active" : "In-Active",
              ),

              /// Getting From Common Module
              EditAndDeleteButtonModule(
                onEditTap: () async {

                  bool departmentEditPermission = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.departmentEditKey);

                  if(departmentEditPermission == true) {
                    Get.to(
                          () => DepartmentManageScreen(),
                      arguments: [
                        DepartmentOption.update,
                        singleItem.id.toString(),
                      ],
                    );
                  } else {
                    Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                  }

                },
                onDeleteTap: () async {
                  bool departmentDeletePermission = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.departmentDeleteKey);

                  if(departmentDeletePermission == true) {
                    CustomAlertDialog().showAlertDialog(
                      textContent: AppMessage.deleteAlertMessage,
                      context: context,
                      onYesTap: () async {
                        await screenController.deleteDepartmentFunction(
                            singleItem.id.toString(), index);
                      },
                      onCancelTap: () => Get.back(),
                    );
                  } else {
                    Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
