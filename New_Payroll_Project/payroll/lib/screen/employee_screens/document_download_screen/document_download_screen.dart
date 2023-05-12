import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/document_download_screen_controller.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/style.dart';
import 'package:sizer/sizer.dart';

import 'document_download_screen_widgets.dart';

class DocumentDownloadScreen extends StatelessWidget {
  DocumentDownloadScreen({Key? key}) : super(key: key);
  final documentDownloadScreenController =
      Get.put(DocumentDownloadScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorLightPurple2,
        appBar: AppBar(
          title: Text(
            documentDownloadScreenController.employeeName,
            style: TextStyle(
              color: AppColors.colorBlack,
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            ),
          ),
          centerTitle: true,
        ),

      body: Obx(
          ()=> documentDownloadScreenController.isLoading.value
              ? CommonLoader().showLoader()
              : documentDownloadScreenController.employeeUploadedDocumentList.isEmpty
          ? Center(child: Text(AppMessage.noDocumentUploaded))
          : Column(
            children: [
              TextFormField(
                controller: documentDownloadScreenController
                    .textSearchEditingController,
                onChanged: (value) {
                  documentDownloadScreenController.isLoading(true);

                  documentDownloadScreenController.searchEmployeeUploadedDocumentList =
                      documentDownloadScreenController.employeeUploadedDocumentList.where((element) =>
                      element.name.toLowerCase().contains(value.toLowerCase()) ||
                          element.doctype.toLowerCase().contains(value.toLowerCase())
                      ).toList();

                  documentDownloadScreenController.isLoading(false);
                  log("searchEmployeeList : ${documentDownloadScreenController.searchEmployeeUploadedDocumentList}");
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
                  suffixIcon: documentDownloadScreenController
                      .textSearchEditingController.text.isEmpty
                      ? null
                      : IconButton(
                    onPressed: () {
                      documentDownloadScreenController.isLoading(true);
                      documentDownloadScreenController.searchEmployeeUploadedDocumentList =
                          documentDownloadScreenController.employeeUploadedDocumentList;
                      documentDownloadScreenController.textSearchEditingController.clear();
                      documentDownloadScreenController.isLoading(false);
                    },
                    icon: const Icon(Icons.close,
                        color: AppColors.colorLightHintPurple2),
                  ),
                ),
              ).commonOnlyPadding(bottom: 1.h),
              Expanded(
                  child: documentDownloadScreenController.searchEmployeeUploadedDocumentList.isEmpty
                  ? Center(
                    child: Text(AppMessage.noDocumentsFound),
                  )
                  : EmployeeDocumentListsModule(),
              ),
            ],
          ).commonAllSidePadding(10),
      ),
    );
  }
}
