import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/logout_drawer_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/drawer_controllers/admin_drawer_controller.dart';
import 'package:payroll_system/screen/authentication_screens/change_password_screen/change_password_screen.dart';
import 'package:payroll_system/screen/authentication_screens/login_screen/login_screen.dart';
import 'package:payroll_system/screen/profile_screens/admin_profile_screens/admin_profile_screen.dart';
import 'package:payroll_system/screen/profile_screens/sub_admin_profile_screens/sub_admin_profile_screen.dart';
import 'package:payroll_system/screen/sub_admin_screen/sub_admin_list_screen/sub_admin_list_screen.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import '../../screen/role_screens/role_manage_screen/role_list_screen.dart';

class AdminHomeDrawerMenu extends StatelessWidget {
  AdminHomeDrawerMenu({Key? key}) : super(key: key);
  final adminDrawerController = Get.put(AdminDrawerController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Obx(
          () => adminDrawerController.isLoading.value
              ? Container()
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            adminDrawerController.roleId.value == 1
                                ? AdminDrawerTile(
                                    onTap: () {
                                      Get.back();
                                      Get.to(() => AdminProfileScreen());
                                    },
                                    title: AppMessage.updateProfile,
                                    imageStatus: false,
                                    icon: const Icon(Icons.person,
                                        color: AppColors.colorBtBlue),
                                  )
                                : AdminDrawerTile(
                                    onTap: () {
                                      Get.back();
                                      Get.to(() => SubAdminProfileScreen());
                                    },
                                    title: AppMessage.updateProfile,
                                    imageStatus: false,
                                    icon: const Icon(Icons.person,
                                        color: AppColors.colorBtBlue),
                                  ),
                            AdminDrawerTile(
                              onTap: () {
                                Get.back();
                                Get.to(() => const RoleListScreen());
                              },
                              title: AppMessage.role,
                              imageStatus: true,
                              image: AppImages.roleIcon,
                            ),
                            AdminDrawerTile(
                              onTap: () {
                                Get.back();
                                Get.to(() => SubAdminListScreen());
                              },
                              title: AppMessage.subAdminText,
                              imageStatus: true,
                              image: AppImages.subAdminIcon,
                            ),
                            AdminDrawerTile(
                              onTap: () {
                                Get.back();
                                Get.to(() => ChangePasswordScreen());
                              },
                              title: AppMessage.changePassword,
                              imageStatus: true,
                              image: AppImages.roleIcon,
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Getting from common module
                    LogOutDrawerTileModule(
                      onTap: () async {
                        log('Logout');

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

                        // await UserPreference()
                        //     .logoutRemoveUserDetailsFromPrefs()
                        //     .then(
                        //   (value) {
                        //     Get.offAll(() => LoginScreen());
                        //   },
                        // );
                      },
                      title: AppMessage.logOutNameDrawer,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class AdminDrawerTile extends StatelessWidget {
  Function() onTap;
  String title;
  bool imageStatus;
  Icon? icon;
  String? image;

  AdminDrawerTile({
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
    /*return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.greyColor,
        ),
      ),

      child: Text(
        AppMessage.companyNameDrawer,
        textAlign: TextAlign.left,
        style: TextStyleConfig.drawerTextStyle(),
      ).commonSymmetricPadding(horizontal: 10, vertical: 5),

    ).commonSymmetricPadding(horizontal: 20, vertical: 10);*/
  }
}

/*class AdminDrawerLogOutTile extends StatelessWidget {
  Function() onTap;
  String title;

  AdminDrawerLogOutTile({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1, thickness: 1, indent: 10, endIndent: 10),
          ListTile(
            leading:
                const Icon(Icons.logout_rounded, color: AppColors.blackColor),
            title: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyleConfig.drawerTextStyle(),
            ),
          ),
          // Text(
          //   title,
          //   textAlign: TextAlign.left,
          //   style: TextStyleConfig.drawerTextStyle(),
          // ).commonSymmetricPadding(horizontal: 10, vertical: 10),
          const Divider(height: 1, thickness: 1, indent: 10, endIndent: 10),
        ],
      ),
    );
    */ /*return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.greyColor,
        ),
      ),

      child: Text(
        AppMessage.companyNameDrawer,
        textAlign: TextAlign.left,
        style: TextStyleConfig.drawerTextStyle(),
      ).commonSymmetricPadding(horizontal: 10, vertical: 5),

    ).commonSymmetricPadding(horizontal: 20, vertical: 10);*/ /*
  }
}*/
