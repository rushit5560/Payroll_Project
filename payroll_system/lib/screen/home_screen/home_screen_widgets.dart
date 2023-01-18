import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/home_screen_controller.dart';
import 'package:payroll_system/models/company_list_screen_model/get_all_company_model.dart';
import 'package:payroll_system/screen/company_screens/company_manage_screen/company_manage_screen.dart';
import 'package:payroll_system/screen/company_screens/company_view_screen/company_view_screen.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';

class CompanyListModule extends StatelessWidget {
  CompanyListModule({Key? key}) : super(key: key);
  final screenController = Get.find<HomeScreenController>();

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
  CompanyListTile({Key? key, required this.singleItem, required this.index})
      : super(key: key);

  final screenController = Get.find<HomeScreenController>();
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10, bottom: 15),
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
                    onTap: () {
                      Get.to(
                        () => CompanyManageScreen(),
                        arguments: [
                          CompanyOption.update,
                          singleItem.id.toString(),
                        ],
                      );
                    },
                    child: Image.asset(
                      AppImages.editIcon,
                      width: 20,
                      height: 20,
                      color: AppColors.colorBtBlue,
                    ),
                  ),
                ],
              ),

              /// Getting From Common Module
              SingleListTileModuleCustom(
                image: AppImages.companyIcon,
                textKey: AppMessage.companyName,
                textValue: singleItem.userName,
              ),

              /// Getting From Common Module
              SingleListTileModuleCustom(
                image: AppImages.phoneIcon,
                textKey: AppMessage.phoneNoName,
                textValue: singleItem.phoneno,
              ),

              /// Getting From Common Module
              SingleListTileModuleCustom(
                image: AppImages.verifyIcon,
                textKey: AppMessage.verifiedStatusName,
                textValue: singleItem.verified.toString().capitalizeFirstLetter(),
                valueColor: singleItem.verified == "active" ? AppColors.greenColor : AppColors.redColor,
              ),

              // SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                            () => CompanyViewScreen(),
                        arguments: [
                          singleItem.id.toString(),
                          singleItem.userName,
                        ],
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'View',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConfig.textStyle(
                            textColor: AppColors.colorBtBlue,
                          ),
                        ).commonOnlyPadding(right: 5),
                        Image.asset(
                          AppImages.arrowRightIcon,
                          width: 20,
                          height: 20,
                          color: AppColors.colorBtBlue,
                        ),
                      ],
                    ),

                  ),
                ],
              ),

              /// Getting From Common Module
              /*ViewAndEditButtonModule(
                onViewTap: () {
                  Get.to(
                    () => CompanyViewScreen(),
                    arguments: [
                      singleItem.id.toString(),
                      singleItem.userName,
                    ],
                  );
                },
                onEditTap: () {
                  Get.to(
                    () => CompanyManageScreen(),
                    // arguments: [
                    //   singleItem.id.toString(),
                    //   singleItem.userName.toString(),
                    // ],
                    arguments: [
                      CompanyOption.update,
                      singleItem.id.toString(),
                    ],
                  );
                },
                viewLabelText: AppMessage.view,
                editLabelText: AppMessage.edit,
              ),*/

            ],
          ),
        ),
      ),
    );
  }
}
