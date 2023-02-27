import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/general_settings_screen_controller.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:sizer/sizer.dart';

class GeneralSettingsScreen extends StatelessWidget {
  GeneralSettingsScreen({super.key});

  final generalSettingsScreenController =
      Get.put(GeneralSettingsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppMessage.generalSettingsScreen,
          style: TextStyleConfig.drawerTextStyle(
              fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
      ),
      body: Obx(
        () => generalSettingsScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : Form(
                key: generalSettingsScreenController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   AppMessage.generalSettingsScreen,
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: 16.sp,
                    //       color: AppColors.colorBlack),
                    // ),
                    SizedBox(height: 2.h),
                    RichText(
                      textAlign: TextAlign.left,
                      maxLines: null,
                      text: TextSpan(
                          text: AppMessage.dateFormat,
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

                    // Container(
                    //   width: Get.width,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     // border: Border.all(color: AppColors.greyColor),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 3),
                    //     child: Container(
                    //       // height: 50,
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(10),
                    //         border: Border.all(color: Colors.transparent),
                    //       ),
                    //       // child: DropdownButtonHideUnderline(
                    //       child: Center(
                    //               child: DropdownButtonFormField(
                    //                   validator: (value) => FieldValidation()
                    //                       .validateDropdownDateFormat(value!),
                    //                   decoration:
                    //                       const InputDecoration.collapsed(
                    //                           hintText: ''),
                    //                   // value: generalSettingsScreenController
                    //                   //     .selectedValue.value,
                    //                   items: generalSettingsScreenController
                    //                       .generalSettingsOptionList
                    //                       .map<DropdownMenuItem<String>>(
                    //                           (String value) {
                    //                     return DropdownMenuItem(
                    //                         value: value, child: Text(value));
                    //                   }).toList(),
                    //                   onChanged: (String? value) {}))
                    //           .commonOnlyPadding(
                    //               left: 10, right: 10, bottom: 10, top: 10),
                    //     ),
                    //   ),
                    // ),
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
                              validator: (value) => FieldValidation()
                                  .validateDropdownDateFormat(value!),
                              decoration:
                                  const InputDecoration.collapsed(hintText: ''),
                              value: generalSettingsScreenController
                                  .selectedValue.value,
                              items: generalSettingsScreenController
                                  .generalSettingsOptionList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                                generalSettingsScreenController.isLoading(true);
                                generalSettingsScreenController
                                    .selectedValue.value = value!;
                                log('value : $value');
                                // generalSettingsScreenController.loadUI();

                                generalSettingsScreenController
                                    .isLoading(false);
                              },
                            ).commonOnlyPadding(
                                left: 10, right: 10, bottom: 10, top: 10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomSubmitButtonModule(
                      labelText: AppMessage.submit,
                      onPress: () async {
                        if (generalSettingsScreenController
                            .isGeneralSettingEditPermission.value) {
                          if (generalSettingsScreenController
                              .formKey.currentState!
                              .validate()) {
                            await generalSettingsScreenController
                                .updateDateFormatFunction();
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: AppMessage.deniedPermission);
                        }
                      },
                    ),
                  ],
                ).commonOnlyPadding(
                    right: 1.h, left: 1.h, top: 1.h, bottom: 1.h),
              ),
      ),
    );
  }
}
