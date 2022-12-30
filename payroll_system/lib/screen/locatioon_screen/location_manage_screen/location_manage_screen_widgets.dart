import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/common_modules/form_single_field_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/location_manage_screen_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/custom_alert_dialog_module.dart';
import '../../../utils/messaging.dart';
import '../../../utils/validator.dart';
import '../../employee_screens/employee_manage_screen/employee_manage_screen_widget.dart';
import '../location_list_screen/location_list_screen.dart';

class LocationManageScreenWidgets extends StatelessWidget {
  LocationManageScreenWidgets({super.key});
  final locationManageScreenController =
      Get.find<LocationManageScreenController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: locationManageScreenController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormSingleFieldModule(
              headerText: AppMessage.locationName,
              text: AppMessage.locationName,
              keyboardType: TextInputType.text,
              mandatoryText: '*',
              textEditingController:
                  locationManageScreenController.locationNameController,
              validate: (value) =>
                  FieldValidation().validateLocationName(value),
            ),
            const SizedBox(height: 5),
            RichText(
              textAlign: TextAlign.left,
              maxLines: null,
              text: TextSpan(
                  text: AppMessage.isActive,
                  style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.redColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ]),
            ).commonSymmetricPadding(vertical: 2),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.greyColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: locationManageScreenController.selectedValue.value,
                    items: locationManageScreenController.isActiveOptionList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      locationManageScreenController.isLoading(true);
                      locationManageScreenController.selectedValue.value =
                          value!;
                      log('value : $value');
                      // locationManageScreenController.loadUI();

                      locationManageScreenController.isLoading(false);
                    },
                  ).commonOnlyPadding(left: 10, right: 10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ButtonCustom(
                    onPressed: () async {
                      if (locationManageScreenController.formKey.currentState!
                          .validate()) {
                        if (locationManageScreenController.locationOption ==
                            LocationOption.create) {
                          if (locationManageScreenController
                                  .selectedValue.value ==
                              "Choose Option") {
                            Fluttertoast.showToast(msg: "Please select status");
                          } else {
                            await locationManageScreenController
                                .locationCreateFunction();
                          }
                        } else {
                          await locationManageScreenController
                              .locationUpdateFunction();
                        }
                      }
                    },
                    text: "Submit",
                    textsize: 15.sp,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: ButtonCustom(
                    onPressed: () => CustomAlertDialog().showAlertDialog(
                      context: context,
                      textContent: 'Are you sure you want to go to back ?',
                      onYesTap: () {
                        Get.back();
                        Get.back();
                      },
                      onCancelTap: () => Get.back(),
                    ),
                    text: "Back",
                    textsize: 15.sp,
                  ),
                ),
              ],
            ),
          ],
        ).commonOnlyPadding(top: 6.h, right: 6.w, left: 6.w, bottom: 4.h),
      ),
    );
  }
}