import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/constants/enums.dart';
import 'package:payroll/controllers/home_screen_controller.dart';
import 'package:payroll/drawer_menu/admin_home_drawer/admin_home_drawer.dart';
import 'package:payroll/screen/company_screens/company_manage_screen/company_manage_screen.dart';
import 'package:payroll/utils/app_images.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:sizer/sizer.dart';
import 'home_screen_widgets.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final homeScreenController = Get.put(HomeScreenController());
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return const HomeCustomMobileBackPressAlertDialog();
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        key: homeScreenController.scaffoldKey,
        backgroundColor: AppColors.colorLightPurple2,
        drawer: AdminHomeDrawerMenu(),
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () =>
                homeScreenController.scaffoldKey.currentState!.openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Image.asset(
                AppImages.menuDrawerImg,
              ),
            ),
          ),
          title: Obx(
            () => Text(
              homeScreenController.roleId.value == 1
                  ? AppMessage.adminText
                  : AppMessage.subAdminText,
              style: TextStyle(
                color: AppColors.colorBlack,
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                bool companyCreatePermission =
                    await userPreference.getBoolPermissionFromPrefs(
                        keyId: UserPreference.companyAddKey);

                if (companyCreatePermission == true) {
                  Get.to(
                    () => CompanyManageScreen(),
                    arguments: [CompanyOption.create, ""],
                  );
                } else if (companyCreatePermission == false) {
                  Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                }
              },
              icon: const Icon(
                Icons.add_rounded,
                size: 30,
              ),
              highlightColor: Colors.transparent,
            ),
          ],
        ),
        body: Obx(
          () => homeScreenController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : homeScreenController.allCompanyList.isEmpty
                  ? Center(child: Text(AppMessage.noCompanyFound))
                  : Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppMessage.companiesName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: AppColors.colorBlack),
                            ).commonAllSidePadding(8)
                          ],
                        ).commonOnlyPadding(top: 8),
                        Expanded(
                          child: CompanyListModule(),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
