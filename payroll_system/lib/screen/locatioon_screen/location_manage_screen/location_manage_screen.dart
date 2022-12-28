import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/location_manage_screen_controller.dart';
import 'package:payroll_system/screen/locatioon_screen/location_manage_screen/location_manage_screen_widgets.dart';

import '../../../utils/messaging.dart';

class LocationManageScreen extends StatelessWidget {
  LocationManageScreen({super.key});
  final locationManageScreenController =
      Get.put(LocationManageScreenController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            locationManageScreenController.locationOption ==
                    LocationOption.create
                ? AppMessage.locationCreate
                : AppMessage.locationUpdate,
          ),
        ),
        body: Obx(
          () => locationManageScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : LocationManageScreenWidgets(),
        ),
      ),
    );
  }
}
