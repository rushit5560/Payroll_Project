import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/drawer_list_tile_module.dart';
import 'package:payroll_system/common_modules/logout_drawer_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/company_home_screen_controller.dart';
import 'package:payroll_system/screen/authentication_screens/change_password_screen/change_password_screen.dart';
import 'package:payroll_system/screen/authentication_screens/login_screen/login_screen.dart';
import 'package:payroll_system/screen/department_screens/department_list_screen/department_list_screen.dart';
import 'package:payroll_system/screen/locatioon_screen/location_list_screen/location_list_screen.dart';
import 'package:payroll_system/screen/pay_checked_screen/pay_checkes_list_Screen/pay_checkes_list_screen.dart';
import 'package:payroll_system/screen/profile_screens/company_profile_screens/company_profile_screen.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';

class CompanyHomeDrawer extends StatelessWidget {
  CompanyHomeDrawer({Key? key}) : super(key: key);
  final companyHomeScreenController = Get.put(CompanyHomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CompanyHomeDrawerTile(
                      title: AppMessage.updateProfile,
                      onTap: () {
                        Get.back();
                        Get.to(() => CompanyProfileScreen());
                      },
                      imageStatus: false,
                      icon: const Icon(Icons.person,
                          color: AppColors.colorBtBlue),
                    ),
                    companyHomeScreenController
                                .isDepartmentShowPermission.value ==
                            true
                        ? CompanyHomeDrawerTile(
                            title: AppMessage.departmentNameDrawer,
                            onTap: () {
                              Get.back();
                              Get.to(
                                () => DepartmentListScreen(),
                                arguments: [
                                  companyHomeScreenController.companyId
                                      .toString(),
                                  companyHomeScreenController.companyName,
                                ],
                              );
                            },
                            imageStatus: true,
                            image: AppImages.departmentIcon,
                          )
                        : const SizedBox(),
                    companyHomeScreenController
                                .isLocationShowPermission.value ==
                            true
                        ? CompanyHomeDrawerTile(
                            title: AppMessage.location,
                            onTap: () {
                              Get.back();
                              Get.to(() => LocationListScreen(), arguments: [
                                companyHomeScreenController.companyId
                                    .toString(),
                                companyHomeScreenController.companyName,
                              ]);
                            },
                            imageStatus: true,
                            image: AppImages.locationIcon,
                          )
                        : const SizedBox(),
                    companyHomeScreenController
                                .isLocationShowPermission.value ==
                            true
                        ? CompanyHomeDrawerTile(
                            title: AppMessage.paycheckes,
                            onTap: () {
                              Get.back();
                              Get.to(() => PayCheckesListScreen(), arguments: [
                                companyHomeScreenController.companyId
                                    .toString(),
                                companyHomeScreenController.companyName,
                              ]);
                            },
                            imageStatus: true,
                            image: AppImages.paycheckIcon,
                          )
                        : const SizedBox(),
                    CompanyHomeDrawerTile(
                      onTap: () {
                        Get.back();
                        Get.to(() => ChangePasswordScreen());
                      },
                      title: AppMessage.changePassword,
                      imageStatus: false,
                      icon: const Icon(Icons.person,
                          color: AppColors.colorBtBlue),
                    ),
                  ],
                ),
              ),
            ),

            /// Getting from common module
            LogOutDrawerTileModule(
              title: AppMessage.logOutNameDrawer,
              onTap: () async {
                CustomAlertDialog().showAlertDialog(
                  context: context,
                  textContent: AppMessage.logoutMessage,
                  onYesTap: () async {
                    await UserPreference()
                        .logoutRemoveUserDetailsFromPrefs()
                        .then(
                      (value) {
                        Get.offAll(() => LoginScreen());
                      },
                    );
                  },
                  onCancelTap: () {
                    Get.back();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CompanyHomeDrawerTile extends StatelessWidget {
  Function() onTap;
  String title;
  bool imageStatus;
  Icon? icon;
  String? image;

  CompanyHomeDrawerTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.imageStatus,
    this.icon,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: imageStatus == false
                ? icon
                : Image.asset(
                    image!,
                    height: 20,
                    width: 20,
                    color: AppColors.colorBtBlue,
                  ),
            title: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyleConfig.drawerTextStyle(),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded,
                color: AppColors.colorBtBlue),
          ),
          const Divider(
              height: 1,
              thickness: 1,
              indent: 10,
              endIndent: 10,
              color: AppColors.colorLightPurple2),
        ],
      ),
    );
  }
}
