import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/upload_document_screen_controller.dart';
import 'package:payroll_system/screen/employee_screens/document_upload_screen/document_upload_widgets_screen.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/messaging.dart';
import '../../../utils/style.dart';

class DocumentUploadScreen extends StatelessWidget {
  DocumentUploadScreen({Key? key}) : super(key: key);
  final uploadDocumentScreenController =
      Get.put(UploadDocumentScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightPurple2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          uploadDocumentScreenController.employeeName,
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
        () => uploadDocumentScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : Form(
          key: uploadDocumentScreenController.formKey,
              child: Column(
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
                            if (uploadDocumentScreenController
                                    .selectedDocumentList.length <=
                                5) {
                              await uploadDocumentScreenController
                                  .pickDocumentFunction();
                            } else {
                              Fluttertoast.showToast(
                                  msg: AppMessage.youReachedAtMaxLength);
                            }
                          },
                          icon: const Icon(
                            Icons.add_rounded,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                    DocumentListModule(),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          AppMessage.documentype,
                          style: TextStyleConfig.textStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    DocumentTypeDropdownModule(),
                    SizedBox(height: 2.h),
                    CustomSubmitButtonModule(
                      onPress: () async {
                        if (uploadDocumentScreenController.selectedDocumentList.isEmpty) {
                          Fluttertoast.showToast(msg: AppMessage.pleaseSelectDocument);
                        } else {
                          // if (uploadDocumentScreenController.documentSelectedTypeValue.value == AppMessage.chooseOption) {
                          //   Fluttertoast.showToast(msg: AppMessage.pleaseSelectDocumentType);
                          // } else {
                          if(uploadDocumentScreenController.formKey.currentState!.validate()) {
                            await uploadDocumentScreenController.uploadDocumentFunction();
                          }
                          // }
                        }
                      },
                      labelText: AppMessage.submit,
                    ),
                    SizedBox(height: 2.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       AppMessage.documentList,
                    //       style: TextStyleConfig.textStyle(
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 2.h),
                    // Expanded(child: UploadedDocumentListModule()),
                  ],
                ).commonAllSidePadding(10),
            ),
      ),
    );
  }
}
