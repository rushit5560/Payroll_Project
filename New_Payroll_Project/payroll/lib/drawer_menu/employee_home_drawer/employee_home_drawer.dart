import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll/common_modules/logout_drawer_tile_module.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/employee_home_screen_controller.dart';
import 'package:payroll/screen/authentication_screens/change_password_screen/change_password_screen.dart';
import 'package:payroll/screen/authentication_screens/login_screen/login_screen.dart';
import 'package:payroll/screen/employee_screens/document_download_screen/document_download_screen.dart';
import 'package:payroll/screen/employee_screens/document_upload_screen/document_uplode_screen.dart';
import 'package:payroll/screen/employee_screens/paycheckes_dowanload_screen/paycheckes_dowanload_screen.dart';
import 'package:payroll/screen/profile_screens/employee_profile_screens/employee_profile_screen.dart';
import 'package:payroll/utils/app_images.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/style.dart';

// ignore: must_be_immutable
class EmployeeHomeDrawerMenu extends StatelessWidget {
  EmployeeHomeDrawerMenu({Key? key}) : super(key: key);
  final employeeHomeScreenController = Get.find<EmployeeHomeScreenController>();

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(
        ()=> employeeHomeScreenController.isLoading.value
        ? Container()
        : SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      EmployeeDrawerTile(
                        title: AppMessage.updateProfile,
                        imageStatus: true,
                        image: AppImages.employeeIcon,
                        onTap: () {
                          Get.back();
                          Get.to(() => EmployeeProfileScreen());
                        },
                      ),
                      employeeHomeScreenController.isDocumentDownloadPermission.value == true
                      ? EmployeeDrawerTile(
                        title: AppMessage.documentDownloadDrawer,
                        imageStatus: true,
                        image: AppImages.downloadIcon,
                        // icon: const Icon(Icons.file_download_outlined,
                        //     color: AppColors.colorBtBlue),
                        onTap: () async {
                          int employeeId =
                              await userPreference.getIntValueFromPrefs(
                                  keyId: UserPreference.userIdKey);
                          String employeeName =
                              await userPreference.getStringValueFromPrefs(
                                  keyId: UserPreference.userNameKey);
                          Get.back();
                          Get.to(
                            () => DocumentDownloadScreen(),
                            arguments: [employeeId.toString(), employeeName],
                          );
                        },
                      ) : const SizedBox(),
                      employeeHomeScreenController.isDocumentUploadPermission.value == true
                                ? EmployeeDrawerTile(
                                    title: AppMessage.documentUploadDrawer,
                                    imageStatus: true,
                                    image: AppImages.uploadIcon,
                                    // icon: const Icon(Icons.file_upload_outlined,
                                    //     color: AppColors.colorBtBlue),
                                    onTap: () async {
                                      int employeeId = await userPreference
                                          .getIntValueFromPrefs(
                                              keyId: UserPreference.userIdKey);
                                      String employeeName = await userPreference
                                          .getStringValueFromPrefs(
                                              keyId:
                                                  UserPreference.userNameKey);
                                      Get.back();
                                      Get.to(
                                        () => DocumentUploadScreen(),
                                        arguments: [
                                          employeeId.toString(),
                                          employeeName,
                                        ],
                                      );
                                    },
                                  )
                                : const SizedBox(),
                            employeeHomeScreenController.isPayChecksDownloadPermission.value == true
                          ? EmployeeDrawerTile(
                                    title: AppMessage.paychecksDownloadDrawer,
                                    imageStatus: true,
                                    image: AppImages.downloadIcon,
                                    onTap: () async {
                                      int employeeId = await userPreference
                                          .getIntValueFromPrefs(
                                              keyId: UserPreference.userIdKey);
                                      String employeeName = await userPreference
                                          .getStringValueFromPrefs(
                                              keyId:
                                                  UserPreference.userNameKey);
                                      Get.back();
                                      Get.to(
                                        () => PayCheckesDowanloadListScreen(),
                                        arguments: [
                                          employeeId.toString(),
                                          employeeName,
                                        ],
                                      );
                                    },
                                  )
                                : const SizedBox(),
                      EmployeeDrawerTile(
                        title: AppMessage.changePassword,
                        imageStatus: true,
                        image: AppImages.roleIcon,
                        onTap: () {
                          Get.back();
                          Get.to(() => ChangePasswordScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),

              /// Getting from common module
              LogOutDrawerTileModule(
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
                title: AppMessage.logOutNameDrawer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeDrawerTile extends StatelessWidget {
  Function() onTap;
  String title;
  bool imageStatus;
  Icon? icon;
  String? image;

  EmployeeDrawerTile({
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
