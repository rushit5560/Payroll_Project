import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/location_list_screen_controller.dart';
import 'package:payroll_system/screen/locatioon_screen/location_list_screen/location_list_screen_widgets.dart';
import 'package:payroll_system/screen/locatioon_screen/location_manage_screen/location_manage_screen.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class LocationListScreen extends StatelessWidget {
  LocationListScreen({super.key});
  final locationListScreenController = Get.put(LocationListScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMessage.locationList),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => LocationManageScreen(),
                arguments: [
                  LocationOption.create,
                  "",
                  locationListScreenController.companyId.toString(),
                  locationListScreenController.companyName,
                ],
              );
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
                                  .where((element) => element.locationName
                                      .toLowerCase()
                                      .contains(value))
                                  .toList();

                          locationListScreenController.isLoading(false);
                          log("searchEmployeeList : ${locationListScreenController.searchLocationDataList}");
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: const Icon(Icons.search),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
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
                                  icon: const Icon(Icons.close),
                                ),
                        ),
                      ).commonOnlyPadding(left: 10, right: 10, top: 15),
                      Row(
                        children: [
                          Text(
                            AppMessage.locationList,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ).commonAllSidePadding(10)
                        ],
                      ),
                      LocationListScreenWidgets(),
                    ],
                  ),
      ),
    );
  }
}
