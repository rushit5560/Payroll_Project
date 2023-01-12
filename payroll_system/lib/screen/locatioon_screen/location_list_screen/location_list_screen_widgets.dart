import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/common_modules/edit_and_delete_button_module.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/common_modules/single_item_module.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/location_list_screen_controller.dart';
import 'package:payroll_system/screen/locatioon_screen/location_manage_screen/location_manage_screen.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/custom_alert_dialog_module.dart';
import '../../../constants/colors.dart';
import '../../../utils/messaging.dart';

class LocationListScreenWidgets extends StatelessWidget {
  LocationListScreenWidgets({super.key});
  final screenController = Get.find<LocationListScreenController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: screenController.searchLocationDataList.length,
      itemBuilder: (context, index) {
        final value = screenController.searchLocationDataList[index];
        return Padding(
          padding:
              const EdgeInsets.only(left:10, right: 10, bottom: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Get.to(
                                () => LocationManageScreen(),
                            arguments: [
                              LocationOption.update,
                              value.id.toString(),
                              screenController.companyId.toString(),
                              screenController.companyName,
                            ],
                          );
                          /*bool departmentEditPermission =
                          await userPreference.getBoolPermissionFromPrefs(
                              keyId: UserPreference.departmentEditKey);
                          if (departmentEditPermission == true) {
                            Get.to(
                                  () => DepartmentManageScreen(),
                              arguments: [
                                DepartmentOption.update,
                                singleItem.id.toString(),
                                screenController.companyId,
                              ],
                            );
                          } else {
                            Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                          }*/
                        },
                        child: Image.asset(
                          AppImages.editIcon,
                          width: 20,
                          height: 20,
                          color: AppColors.colorBtBlue,
                        ),
                      ),
                      const SizedBox(width: 10),

                      GestureDetector(
                        onTap: () async {
                          CustomAlertDialog().showAlertDialog(
                            context: context,
                            textContent:
                            'Are youe sure you want to delete location ?',
                            onYesTap: () async {
                              await screenController.deleteLocationFunction(
                                  value.id.toString(), index);
                            },
                            onCancelTap: () {
                              Get.back();
                            },
                          );
                        },
                        child: Image.asset(
                          AppImages.deleteIcon,
                          width: 20,
                          height: 20,
                          color: AppColors.colorRed,
                        ),
                      ),
                    ],
                  ),


                  SingleListTileModuleCustom(
                    image: AppImages.locationIcon,
                    textKey: AppMessage.locationName,
                    textValue: value.locationName,
                  ),
                  SizedBox(height: 1.h),
                  SingleListTileModuleCustom(
                    image: AppImages.verifyIcon,
                    textKey: AppMessage.status,
                    textValue: value.isActive == "1" ? "Active" : "In-Active",
                    valueColor: value.isActive == "1" ? AppColors.greenColor : AppColors.colorRed,
                  ),
                  /*SizedBox(height: 2.h),
                  EditAndDeleteButtonModule(
                    onDeleteTap: () {
                      CustomAlertDialog().showAlertDialog(
                        context: context,
                        textContent:
                            'Are youe sure you want to delete location ?',
                        onYesTap: () async {
                          await screenController.deleteLocationFunction(
                              value.id.toString(), index);
                        },
                        onCancelTap: () {
                          Get.back();
                        },
                      );

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
                      Get.to(
                        () => LocationManageScreen(),
                        arguments: [
                          LocationOption.update,
                          value.id.toString(),
                          screenController.companyId.toString(),
                          screenController.companyName,
                        ],
                      );
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
                  )*/
                ],
              ).commonAllSidePadding(5),
            ),
          ),
        );
      },
    );
    ;
  }
}
