import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/location_list_screen_controller.dart';
import 'package:payroll_system/screen/locatioon_screen/location_list_screen/location_list_screen_widgets.dart';
import 'package:payroll_system/screen/locatioon_screen/location_manage_screen/location_manage_screen.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';

class LocationListScreen extends StatelessWidget {
  LocationListScreen({super.key});
  final locationListScreenController = Get.put(LocationListScreenController());
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        title: Text(
          AppMessage.location,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              bool locationCreatePermission =
                  await userPreference.getBoolPermissionFromPrefs(
                      keyId: UserPreference.departmentAddKey);

              if (locationCreatePermission == true) {
                Get.to(
                  () => LocationManageScreen(),
                  arguments: [
                    LocationOption.create,
                    "",
                    locationListScreenController.companyId.toString(),
                    locationListScreenController.companyName,
                  ],
                );
              } else {
                Fluttertoast.showToast(msg: AppMessage.deniedPermission);
              }
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Obx(
        () => locationListScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : locationListScreenController.allLocationList.isEmpty
                ? Center(
                    child: Text(AppMessage.noLocationFound),
                  )
                : Column(
                    children: [
                      TextFormField(
                        controller: locationListScreenController
                            .textSearchEditingController,
                        onChanged: (value) {
                          locationListScreenController.isLoading(true);

                          locationListScreenController.searchLocationDataList =
                              locationListScreenController.allLocationList
                                  .where((element) => element.locationName!
                                      .toLowerCase()
                                      .contains(value))
                                  .toList();

                          locationListScreenController.isLoading(false);
                          log("searchEmployeeList : ${locationListScreenController.searchLocationDataList}");
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputFieldStyles().inputBorder(),
                          focusedBorder: InputFieldStyles().inputBorder(),
                          errorBorder: InputFieldStyles().inputBorder(),
                          focusedErrorBorder: InputFieldStyles().inputBorder(),
                          hintText: AppMessage.search,
                          fillColor: AppColors.colorWhite,
                          filled: true,
                          hintStyle: const TextStyle(
                              color: AppColors.colorLightHintPurple2),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 11),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.colorLightHintPurple2,
                          ),
                          suffixIcon: locationListScreenController
                                  .textSearchEditingController.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    locationListScreenController
                                        .isLoading(true);
                                    locationListScreenController
                                            .searchLocationDataList =
                                        locationListScreenController
                                            .allLocationList;
                                    locationListScreenController
                                        .textSearchEditingController
                                        .clear();
                                    locationListScreenController
                                        .isLoading(false);
                                  },
                                  icon: const Icon(Icons.close,
                                      color: AppColors.colorLightHintPurple2),
                                ),
                        ),
                      ).commonOnlyPadding(left: 10, right: 10, top: 15),
                      Row(
                        children: [
                          Text(
                            AppMessage.locationList,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: AppColors.colorBlack),
                          ).commonAllSidePadding(14)
                        ],
                      ),
                      Expanded(child: LocationListScreenWidgets()),
                    ],
                  ),
      ),
    );
  }
}
