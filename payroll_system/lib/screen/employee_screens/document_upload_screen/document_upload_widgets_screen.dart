import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/upload_document_screen_controller.dart';
import 'package:payroll_system/models/uplode_document_screen_model/uplode_document_screen_model.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';

class DocumentListModule extends StatelessWidget {
  DocumentListModule({Key? key}) : super(key: key);
  final uploadDocumentScreenController =
      Get.find<UploadDocumentScreenController>();

  @override
  Widget build(BuildContext context) {
    return uploadDocumentScreenController.selectedDocumentList.isNotEmpty
        ? ListView.builder(
            itemCount:
                uploadDocumentScreenController.selectedDocumentList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              String fileName = "";
              List<String> tempStringList = uploadDocumentScreenController
                  .selectedDocumentList[i].path
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
                   /* IconButton(
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
                              uploadDocumentScreenController.isLoading(true);
                              uploadDocumentScreenController
                                  .selectedDocumentList
                                  .removeAt(i);
                              Get.back();
                              uploadDocumentScreenController.isLoading(false);
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

class DocumentTypeDropdownModule extends StatelessWidget {
  DocumentTypeDropdownModule({Key? key}) : super(key: key);
  final uploadDocumentScreenController =
      Get.find<UploadDocumentScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.transparent),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          // hint: Text(AppMessage.chooseOption),
          value: uploadDocumentScreenController.documentSelectedTypeValue.value,
          items: uploadDocumentScreenController.documentTypeList
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
            uploadDocumentScreenController.isLoading(true);
            uploadDocumentScreenController.documentSelectedTypeValue.value =
                value!;
            uploadDocumentScreenController.isLoading(false);
          },
        ).commonOnlyPadding(left: 10, right: 10),
      ),
    );
  }
}

// ignore: must_be_immutable
class UploadedDocumentListModule extends StatelessWidget {
  UploadedDocumentListModule({Key? key}) : super(key: key);
  final uploadDocumentScreenController =
      Get.find<UploadDocumentScreenController>();
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return uploadDocumentScreenController.uploadedDocumentList.isEmpty
        ? Center(child: Text(AppMessage.noDocumentUploaded))
        : ListView.builder(
            itemCount:
                uploadDocumentScreenController.uploadedDocumentList.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, i) {
              DocumentDatumData singleDoc =
                  uploadDocumentScreenController.uploadedDocumentList[i];
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
                            bool employeeUpdatePermission =
                                await userPreference.getBoolPermissionFromPrefs(
                                    keyId: UserPreference.employeeEditKey);

                            if (employeeUpdatePermission == true) {
                              CustomAlertDialog().showAlertDialog(
                                context: context,
                                textContent:
                                    AppMessage.deleteDocumentAlertMessage,
                                onYesTap: () async {
                                  log("Delete Document");
                                  await uploadDocumentScreenController
                                      .deleteDocumentFunction(
                                          singleDoc.id.toString(), i);
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

                    // SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
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
