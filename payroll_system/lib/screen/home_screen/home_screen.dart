import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/home_screen_controller.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'home_screen_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              // key: homeScreenController.scaffoldKey,
              // drawer: AdminDrawerMenu(),
              appBar: AppBar(
                centerTitle: true,
                title: Text(AppMessage.adminText),
                // title: Obx(
                //   () => homeScreenController.isLoading.value
                //       ? Container()
                //       : homeScreenController.roleId.value == 1
                //           ? Text(AppMessage.adminText)
                //           : Text(AppMessage.subAdminText),
                // ),
                /*actions: [
                  IconButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      var roleId = prefs.getInt(UserPreference.roleIdKey) ?? 0;

                      log("roleId :: $roleId");

                      if (roleId == 1) {
                        Get.to(() => AdminProfileScreen());
                      } else if (roleId == 2) {
                        Get.to(() => SubAdminProfileScreen());
                      }
                    },
                    icon: const Icon(Icons.person_rounded),
                  ),
                ],*/
              ),

        body: Obx(
              () => homeScreenController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : homeScreenController.allCompanyList.isEmpty
              ? Center(child: Text(AppMessage.noCompanyFound))
              : CompanyListModule(),
        ),
            );
  }
}
