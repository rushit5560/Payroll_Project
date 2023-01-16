import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/document_download_screen_controller.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
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
          : EmployeeDocumentListsModule().commonAllSidePadding(10),
      ),
    );
  }
}
