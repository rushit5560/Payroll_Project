import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/common_modules/edit_and_delete_button_module.dart';
import 'package:payroll_system/common_modules/single_item_module.dart';
import 'package:payroll_system/controllers/location_list_screen_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/custom_alert_dialog_module.dart';
import '../../../constants/colors.dart';
import '../../../utils/messaging.dart';

class LocationListScreenWidgets extends StatelessWidget {
  LocationListScreenWidgets({super.key});
  final allLocationListScreen = Get.find<LocationListScreenController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: allLocationListScreen.allLocationList.length,
      itemBuilder: (context, index) {
        final value = allLocationListScreen.allLocationList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.greyColor,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 1.h),
                SingleListTileCustom(
                  textKey: AppMessage.employeeName,
                  textValue: value.locationName,
                ),
                SizedBox(height: 1.h),
                SingleListTileCustom(
                  textKey: AppMessage.employeeName,
                  textValue: value.isActive == "1" ? "Active" : "In-Active",
                ),
                EditAndDeleteButtonModule(
                  onDeleteTap: () async {
                    // bool employeeUpdatePermission = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.employeeEditKey);

                    // if(employeeUpdatePermission == true) {
                    //   CustomAlertDialog().showAlertDialog(
                    //     context: context,
                    //     textContent:
                    //     'Are youe sure you want to delete employee ?',
                    //     onYesTap: () async {
                    //       log("Delete Employee");
                    //       await employeeListScreenController
                    //           .deleteEmployeeFunction(
                    //           value.id.toString(), index);
                    //     },
                    //     onCancelTap: () {
                    //       Get.back();
                    //     },
                    //   );
                    // } else {
                    //   Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                    // }
                  },
                  onEditTap: () async {
                    // bool employeeDeletePermission = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.employeeDeleteKey);

                    // if(employeeDeletePermission == true) {
                    //   Get.to(
                    //         () => EmployeeManageScreen(),
                    //     arguments: [
                    //       EmployeeOption.update,
                    //       value.id.toString(),
                    //       log('111'),
                    //       log(value.id.toString())
                    //     ],
                    //   );
                    // } else {
                    //   Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                    // }
                  },
                )
              ],
            ).commonAllSidePadding(5),
          ),
        );
      },
    );
    ;
  }
}
