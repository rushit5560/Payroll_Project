import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/constants/anums.dart';
import 'package:payroll_system/controllers/company_list_screen_controller.dart';
import 'package:payroll_system/screen/company_screens/company_manage_screen/company_manage_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';


import 'company_list_screen_widgets.dart';

class CompanyListScreen extends StatelessWidget {
  CompanyListScreen({Key? key}) : super(key: key);
  final companyListScreenController = Get.put(CompanyListScreenController());
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMessage.companiesName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              bool companyCreatePermission = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.companyAddKey);

              if(companyCreatePermission == true) {
                Get.to(()=> CompanyManageScreen(),
                  arguments: [CompanyOption.create, ""],
                );
              } else if(companyCreatePermission == false) {
                Fluttertoast.showToast(msg: AppMessage.deniedPermission);
              }


            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Obx(
        () => companyListScreenController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : CompanyListModule(),
      ),
    );
  }
}
