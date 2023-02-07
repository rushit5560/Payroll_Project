import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/common_modules/form_single_field_module.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/location_manage_screen_controller.dart';
import 'package:payroll_system/utils/app_images.dart';
import '../../../utils/messaging.dart';
import '../../../utils/validator.dart';


class LocationManageScreenWidgets extends StatelessWidget {
  LocationManageScreenWidgets({super.key});
  final locationManageScreenController =
      Get.find<LocationManageScreenController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    text: AppMessage.status,
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
                  // border: Border.all(color: AppColors.greyColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Container(
                    // height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.transparent),
                    ),
                    // child: DropdownButtonHideUnderline(
                    child: Center(
                      child: DropdownButtonFormField<String>(
                        validator: (value) => FieldValidation().validateDropdownStatus(value!),
                        decoration: const InputDecoration.collapsed(hintText: ''),
                        value: locationManageScreenController.selectedValue.value,
                        items: locationManageScreenController.isActiveOptionList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        borderRadius: BorderRadius.circular(10),
                        icon: Image.asset(
                          AppImages.arrowDownIcon,
                          height: 15,
                          width: 15,
                        ).commonSymmetricPadding(horizontal: 10),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          locationManageScreenController.isLoading(true);
                          locationManageScreenController.selectedValue.value =
                              value!;
                          log('value : $value');
                          // locationManageScreenController.loadUI();

                          locationManageScreenController.isLoading(false);
                        },
                      ).commonOnlyPadding(left: 10, right: 10, bottom: 10, top: 10),
                    ),
                  ),
                ),
              ),
              // ),
              const SizedBox(height: 15),
              CustomSubmitButtonModule(
                labelText: AppMessage.submit,
                onPress: () async {
                  if (locationManageScreenController.formKey.currentState!.validate()) {
                    if (locationManageScreenController.locationOption == LocationOption.create) {
                      if (locationManageScreenController.selectedValue.value == AppMessage.chooseOption) {
                        Fluttertoast.showToast(msg: "Please select status");
                      } else {
                        await locationManageScreenController.locationCreateFunction();
                      }
                    } else {
                      await locationManageScreenController.locationUpdateFunction();
                    }
                  }
                },
              ),
              /* Row(
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
                               AppMessage.chooseOption) {
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
                      text:AppMessage.submit,
                      textsize: 15.sp,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: ButtonCustom(
                      onPressed: () => CustomAlertDialog().showAlertDialog(
                        context: context,
                        textContent: AppMessage.permissionMessage,
                        onYesTap: () {
                          Get.back();
                          Get.back();
                        },
                        onCancelTap: () => Get.back(),
                      ),
                      text: AppMessage.back,
                      textsize: 15.sp,
                    ),
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
