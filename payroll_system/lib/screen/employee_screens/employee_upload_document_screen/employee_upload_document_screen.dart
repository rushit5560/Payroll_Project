import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/employee_upload_document_screen_controller.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';

import 'employee_upload_document_screen_widgets.dart';

class EmployeeUploadDocumentScreen extends StatelessWidget {
  EmployeeUploadDocumentScreen({Key? key}) : super(key: key);
  final employeeUploadDocumentScreenController =
      Get.put(EmployeeUploadDocumentScreenController());

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
                      Text(
                        AppMessage.uploadDocument,
                        style: TextStyleConfig.textStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (employeeUploadDocumentScreenController
                              .employeeSelectedDocumentList.length <=
                              5) {
                            await employeeUploadDocumentScreenController
                                .pickEmployeeDocumentFunction();
                          } else {
                            Fluttertoast.showToast(msg: "You reached at max length");
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
                      if(employeeUploadDocumentScreenController.employeeSelectedDocumentList.isEmpty) {
                        Fluttertoast.showToast(msg: "Please select document");
                      } else {
                        if(employeeUploadDocumentScreenController.documentSelectedTypeValue.value == "Choose Option") {
                          Fluttertoast.showToast(msg: "Please select document type");
                        } else {
                          await employeeUploadDocumentScreenController.uploadEmployeeDocumentFunction();
                        }
                      }
                    },
                    labelText: AppMessage.submit,
                  ),

                  SizedBox(height: 2.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Document List",
                        style: TextStyleConfig.textStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 2.h),

                  Expanded(child: EmployeeUploadedDocumentListModule()),

                ],
              ).commonAllSidePadding(10),
      ),
    );
  }
}