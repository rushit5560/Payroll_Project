import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/new/single_list_tile_module.dart';
import 'package:payroll/common_modules/new/web_url_launcher_function.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/controllers/document_download_screen_controller.dart';
import 'package:payroll/models/employee_upload_document_models/employee_document_model.dart';
import 'package:payroll/utils/api_url.dart';
import 'package:payroll/utils/app_images.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/style.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/extension_methods/user_preference.dart';

class EmployeeDocumentListsModule extends StatelessWidget {
  EmployeeDocumentListsModule({Key? key}) : super(key: key);
  final screenController = Get.find<DocumentDownloadScreenController>();

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: screenController.searchEmployeeUploadedDocumentList.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) {
        DocumentDatum singleDoc =
            screenController.searchEmployeeUploadedDocumentList[i];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.transparent),
          ),
          child: Column(
            children: [
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
                        await WebUrlLauncher().launchPdfInBrowser("${ApiUrl.downloadPayrollApi}${singleDoc.id}");
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

                      bool isDocumentDownloadPermission = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.employeeDocumentDownloadKey);

                      if(isDocumentDownloadPermission == true) {
                        await WebUrlLauncher().launchPdfInBrowser(
                            "${ApiUrl.downloadFilePath}${singleDoc.name}");
                      } else {
                       Fluttertoast.showToast(msg: AppMessage.deniedPermission);
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
