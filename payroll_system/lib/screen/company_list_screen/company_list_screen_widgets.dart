import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/company_list_screen_controller.dart';
import 'package:payroll_system/Models/company_list_screen_model/get_all_company_model.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/edit_and_delete_button_module.dart';
import 'package:payroll_system/common_modules/single_item_module.dart';
import 'package:payroll_system/constants/anums.dart';
import 'package:payroll_system/constants/colors.dart';

import '../company_manage_screen/company_manage_screen.dart';



class CompanyListModule extends StatelessWidget {
  CompanyListModule({Key? key}) : super(key: key);
  final screenController = Get.find<CompanyListScreenController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: screenController.allCompanyList.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) {
        CompanyData singleItem = screenController.allCompanyList[i];
        return CompanyListTile(singleItem: singleItem, index: i);
      },
    );
  }

}

class CompanyListTile extends StatelessWidget {
  CompanyData singleItem;
  int index;
  CompanyListTile({Key? key, required this.singleItem, required this.index}) : super(key: key);

  final screenController = Get.find<CompanyListScreenController>();

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
                textKey: AppMessage.companyName,
                textValue: singleItem.userName,
              ),

              /// Getting From Common Module
              SingleListTileCustom(
                textKey: AppMessage.phoneNoName,
                textValue: singleItem.phoneno,
              ),

              /// Getting From Common Module
              SingleListTileCustom(
                textKey: AppMessage.verifiedStatusName,
                textValue: singleItem.verified,
              ),

              /// Getting From Common Module
              EditAndDeleteButtonModule(
                onEditTap: () {
                  Get.to(
                    () => CompanyManageScreen(),
                    arguments: [
                      CompanyOption.update,
                      singleItem.id.toString(),
                    ],
                  );
                },
                onDeleteTap: () => CustomAlertDialog().showAlertDialog(
                  textContent: AppMessage.deleteAlertMessage,
                    context: context,
                  onYesTap: () async {
                    await screenController.deleteCompanyFunction(singleItem.id.toString(), index);
                  },
                  onCancelTap: () => Get.back(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









