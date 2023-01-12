import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/location_manage_screen_controller.dart';
import 'package:payroll_system/screen/locatioon_screen/location_manage_screen/location_manage_screen_widgets.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/messaging.dart';

class LocationManageScreen extends StatelessWidget {
  LocationManageScreen({super.key});

  final locationManageScreenController =
      Get.put(LocationManageScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (locationManageScreenController.locationOption ==
            LocationOption.update) {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return CustomMobileBackPressAlertDialog();
            },
          );
          return shouldPop!;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.colorLightPurple2,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              locationManageScreenController.locationOption ==
                      LocationOption.create
                  ? AppMessage.locationCreate
                  : AppMessage.locationUpdate,
              style: TextStyle(
                color: AppColors.colorBlack,
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
              ),
            ),
            leading: locationManageScreenController.locationOption ==
                    LocationOption.update
                ? IconButton(
                    onPressed: () => CustomAlertDialog().showAlertDialog(
                      context: context,
                      textContent: AppMessage.permissionMessage,
                      onYesTap: () {
                        Get.back();
                        Get.back();
                      },
                      onCancelTap: () => Get.back(),
                    ),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  )
                : null,
          ),
          body: Obx(
            () => locationManageScreenController.isLoading.value
                ? CommonLoader().showLoader()
                : LocationManageScreenWidgets(),
          ),
        ),
      ),
    );
  }
}
