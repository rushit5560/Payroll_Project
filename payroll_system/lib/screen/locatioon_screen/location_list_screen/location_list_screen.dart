import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/location_list_screen_controller.dart';
import 'package:payroll_system/screen/locatioon_screen/location_list_screen/location_list_screen_widgets.dart';
import 'package:payroll_system/screen/locatioon_screen/location_manage_screen/location_manage_screen.dart';

class LocationListScreen extends StatelessWidget {
  LocationListScreen({super.key});
  final allLocationListScreen = Get.put(LocationListScreenController());
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
                arguments: [LocationOption.create, ""],
              );
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: allLocationListScreen.isLoading.value
          ? CommonLoader().showLoader()
          : LocationListScreenWidgets(),
    );
  }
}
