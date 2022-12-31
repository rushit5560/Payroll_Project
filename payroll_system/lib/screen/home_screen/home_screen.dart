import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/home_screen_controller.dart';
import 'package:payroll_system/drawer_menu/admin_drawer/admin_drawer.dart';
import 'package:payroll_system/screen/company_screens/company_manage_screen/company_manage_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';
import 'home_screen_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeScreenController = Get.put(HomeScreenController());
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: homeScreenController.scaffoldKey,
      drawer: AdminDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppMessage.adminText),
        actions: [
          FloatingActionButton(
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
            tooltip: AppMessage.companyCreate,
            elevation: 0.0,
            child: const Icon(
              Icons.add_rounded,
              size: 30,
            ),
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
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),).commonAllSidePadding(10)
                        ],
                      ),
                      Expanded(
                        child: CompanyListModule(),
                      ),
                    ],
                  ),
      ),
    );
  }
}
