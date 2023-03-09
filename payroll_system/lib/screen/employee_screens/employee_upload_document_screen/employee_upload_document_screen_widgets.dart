import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/common_modules/new/web_url_launcher_function.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/employee_upload_document_screen_controller.dart';
import 'package:payroll_system/models/employee_upload_document_models/employee_document_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';

class EmployeeDocumentListModule extends StatelessWidget {
  EmployeeDocumentListModule({Key? key}) : super(key: key);
  final screenController = Get.find<EmployeeUploadDocumentScreenController>();

  @override
  Widget build(BuildContext context) {
    return screenController.employeeSelectedDocumentList.isNotEmpty
        ? ListView.builder(
            itemCount: screenController.employeeSelectedDocumentList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              String fileName = "";
              List<String> tempStringList = screenController
                  .employeeSelectedDocumentList[i].path
                  .split('/');
              for (int i = 0; i < tempStringList.length; i++) {
                fileName = tempStringList[i];
              }

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.colorWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      // flex: 8,
                      child: Text(
                        fileName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ).commonOnlyPadding(left: 8),
                    ),
                    /*IconButton(
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Download");
                      },
                      icon: const Icon(Icons.download_rounded),
                    ),*/
                    IconButton(
                      onPressed: () {
                        CustomAlertDialog().showAlertDialog(
                            context: context,
                            textContent:
                                "Are you sure you want to delete this document?",
                            onCancelTap: () => Get.back(),
                            onYesTap: () async {
                              /// Api Call Delete
                              screenController.isLoading(true);
                              screenController.employeeSelectedDocumentList
                                  .removeAt(i);
                              Get.back();
                              screenController.isLoading(false);
                            });
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ).commonSymmetricPadding(horizontal: 5),
              ).commonSymmetricPadding(vertical: 5);
            },
          )
        : Center(
            child: Text(AppMessage.noDocumentUploaded),
          );
  }
}

class EmployeeDocumentTypeDropdownModule extends StatelessWidget {
  EmployeeDocumentTypeDropdownModule({Key? key}) : super(key: key);
  final screenController = Get.find<EmployeeUploadDocumentScreenController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: screenController.globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          RichText(
            textAlign: TextAlign.left,
            maxLines: null,
            text: TextSpan(
                text: AppMessage.documentsType,
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
          const SizedBox(height: 5),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.transparent),
            ),
            // child: DropdownButtonHideUnderline(
              child: Center(
                child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if (screenController.documentSelectedTypeValue.value == AppMessage.chooseOption) {
                      return AppMessage.activeStatusMessage;
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration.collapsed(hintText: ''),
                  value: screenController.documentSelectedTypeValue.value,
                  items: screenController.documentTypeList
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
                    screenController.isLoading(true);
                    screenController.documentSelectedTypeValue.value = value!;
                    screenController.isLoading(false);
                  },
                ).commonOnlyPadding(left: 10, right: 10, bottom: 10, top: 10),
              ),
            // ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class EmployeeUploadedDocumentListModule extends StatelessWidget {
  EmployeeUploadedDocumentListModule({Key? key}) : super(key: key);
  final screenController = Get.find<EmployeeUploadDocumentScreenController>();
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return screenController.searchEmployeeUploadedDocumentList.isEmpty
        ? Center(child: Text(AppMessage.noDocumentUploaded))
        : ListView.builder(
            itemCount: screenController.searchEmployeeUploadedDocumentList.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              DocumentDatum singleDoc =
                  screenController.employeeUploadedDocumentList[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            bool employeeDeletePermission =
                                await userPreference.getBoolPermissionFromPrefs(
                                    keyId: UserPreference
                                        .employeeDocumentDeleteKey);

                            if (employeeDeletePermission == true) {
                              CustomAlertDialog().showAlertDialog(
                                context: context,
                                textContent:
                                    AppMessage.deleteDocumentAlertMessage,
                                onYesTap: () async {
                                  log("Delete Document");
                                  await screenController.deleteDocumentFunction(
                                      singleDoc.id.toString(), index);
                                },
                                onCancelTap: () {
                                  Get.back();
                                },
                              );
                            } else {
                              Fluttertoast.showToast(
                                  msg: AppMessage.deniedPermission);
                            }
                          },
                          child: Image.asset(
                            AppImages.deleteIcon,
                            width: 20,
                            height: 20,
                            color: AppColors.colorRed,
                          ),
                        ),
                      ],
                    ),
                    SingleListTileModuleCustom(
                      image: AppImages.departmentIcon,
                      textKey: AppMessage.fileName,
                      textValue: singleDoc.name,
                    ),
                    SizedBox(height: 2.h),
                    SingleListTileModuleCustom(
                      image: AppImages.departmentIcon,
                      textKey: AppMessage.documentsType,
                      textValue: singleDoc.doctype,
                    ),

                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            bool employeeDownloadDownloadPermission =
                            await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.employeeDocumentDownloadKey);

                            if (employeeDownloadDownloadPermission == true) {
                              // await payCheckesListScreenController.downloadFile();
                              await WebUrlLauncher().launchPdfInBrowser("${ApiUrl.downloadFilePath}${singleDoc.name}");
                            } else {
                              Fluttertoast.showToast(msg: AppMessage.deniedPermission);
                            }
                          },
                          child: Image.asset(
                            AppImages.downloadIcon,
                            width: 25,
                            height: 25,
                            color: AppColors.colorBtBlue,
                          ),
                        ),


                        GestureDetector(
                          onTap: () async {
                            bool employeeDocumentViewPermission =
                                await userPreference.getBoolPermissionFromPrefs(
                                    keyId:
                                        UserPreference.employeeDocumentViewKey);

                            if (employeeDocumentViewPermission == true) {
                              await WebUrlLauncher().launchPdfInBrowser(
                                  "${ApiUrl.downloadFilePath}${singleDoc.name}");
                            } else {
                              Fluttertoast.showToast(
                                  msg: AppMessage.deniedPermission);
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                AppMessage.view,
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
                  ],
                ).commonAllSidePadding(8),
              ).commonSymmetricPadding(vertical: 5);
            },
          );
  }
}
