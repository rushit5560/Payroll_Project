import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/employee_upload_document_screen_controller.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';
import 'employee_upload_document_screen_widgets.dart';

// ignore: must_be_immutable
class EmployeeUploadDocumentScreen extends StatelessWidget {
  EmployeeUploadDocumentScreen({Key? key}) : super(key: key);
  final employeeUploadDocumentScreenController =
      Get.put(EmployeeUploadDocumentScreenController());

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          employeeUploadDocumentScreenController.employeeName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Obx(
        () => employeeUploadDocumentScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        textAlign: TextAlign.left,
                        maxLines: null,
                        text: TextSpan(
                            text: AppMessage.uploadDocumentWithFormat,
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
                      ),
                      IconButton(
                        onPressed: () async {
                          bool addUploadDocumentPermission =
                              await userPreference.getBoolPermissionFromPrefs(
                                  keyId: UserPreference.employeeDocumentAddKey);

                          if (addUploadDocumentPermission == true) {
                            if (employeeUploadDocumentScreenController
                                    .employeeSelectedDocumentList.length <=
                                5) {
                              await employeeUploadDocumentScreenController
                                  .pickEmployeeDocumentFunction();
                            } else {
                              Fluttertoast.showToast(
                                  msg: AppMessage.youReachedAtMaxLength);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: AppMessage.deniedPermission);
                          }
                        },
                        icon: const Icon(
                          Icons.add_rounded,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  EmployeeDocumentListModule(),
                  SizedBox(height: 2.h),
                  EmployeeDocumentTypeDropdownModule(),
                  SizedBox(height: 2.h),
                  CustomSubmitButtonModule(
                    onPress: () async {
                      if (employeeUploadDocumentScreenController
                          .employeeSelectedDocumentList.isEmpty) {
                        Fluttertoast.showToast(
                            msg: AppMessage.pleaseSelectDocument);
                      } else {
                        if (employeeUploadDocumentScreenController
                            .globalKey.currentState!
                            .validate()) {
                          await employeeUploadDocumentScreenController
                              .uploadEmployeeDocumentFunction();
                        }

                        // if (employeeUploadDocumentScreenController.documentSelectedTypeValue.value == AppMessage.chooseOption) {
                        //   Fluttertoast.showToast(
                        //       msg: AppMessage.pleaseSelectDocument);
                        // }
                      }
                    },
                    labelText: AppMessage.submit,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppMessage.uplodedDocumentList,
                        style: TextStyleConfig.textStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: employeeUploadDocumentScreenController
                        .textSearchEditingController,
                    onChanged: (value) {
                      employeeUploadDocumentScreenController.isLoading(true);

                      employeeUploadDocumentScreenController
                              .searchEmployeeUploadedDocumentList =
                          employeeUploadDocumentScreenController
                              .employeeUploadedDocumentList
                              .where((element) =>
                                  element.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  element.doctype
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                              .toList();

                      employeeUploadDocumentScreenController.isLoading(false);
                      log("searchEmployeeList : ${employeeUploadDocumentScreenController.searchEmployeeUploadedDocumentList}");
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputFieldStyles().inputBorder(),
                      focusedBorder: InputFieldStyles().inputBorder(),
                      errorBorder: InputFieldStyles().inputBorder(),
                      focusedErrorBorder: InputFieldStyles().inputBorder(),
                      fillColor: AppColors.colorWhite,
                      filled: true,
                      hintText: AppMessage.search,
                      hintStyle: const TextStyle(
                          color: AppColors.colorLightHintPurple2),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.colorLightHintPurple2,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 11),
                      suffixIcon: employeeUploadDocumentScreenController
                              .textSearchEditingController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                employeeUploadDocumentScreenController
                                    .isLoading(true);
                                employeeUploadDocumentScreenController
                                        .searchEmployeeUploadedDocumentList =
                                    employeeUploadDocumentScreenController
                                        .employeeUploadedDocumentList;
                                employeeUploadDocumentScreenController
                                    .textSearchEditingController
                                    .clear();
                                employeeUploadDocumentScreenController
                                    .isLoading(false);
                              },
                              icon: const Icon(Icons.close,
                                  color: AppColors.colorLightHintPurple2),
                            ),
                    ),
                  ).commonOnlyPadding(left: 10, right: 10, top: 15),
                  SizedBox(height: 2.h),
                  Expanded(child: EmployeeUploadedDocumentListModule()),
                ],
              ).commonAllSidePadding(10),
      ),
    );
  }
}
