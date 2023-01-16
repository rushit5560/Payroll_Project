import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/document_download_screen_controller.dart';
import 'package:payroll_system/models/employee_upload_document_models/employee_document_model.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/extension_methods/user_preference.dart';


class EmployeeDocumentListsModule extends StatelessWidget {
  EmployeeDocumentListsModule({Key? key}) : super(key: key);
  final screenController = Get.find<DocumentDownloadScreenController>();

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: screenController.employeeUploadedDocumentList.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) {
        DocumentDatum singleDoc = screenController.employeeUploadedDocumentList[i];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.transparent),
          ),

          child: Column(
            children: [

              /*Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      bool employeeUpdatePermission =
                      await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.employeeEditKey);

                      if (employeeUpdatePermission == true) {
                        CustomAlertDialog().showAlertDialog(
                          context: context,
                          textContent: AppMessage.deleteDocumentAlertMessage,
                          onYesTap: () async {
                            log("Delete Document");
                            await screenController.deleteDocumentFunction(singleDoc.id.toString(), i);
                          },
                          onCancelTap: () {
                            Get.back();
                          },
                        );
                      } else {
                        Fluttertoast.showToast(msg: AppMessage.deniedPermission);
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
              ),*/
              SingleListTileModuleCustom(
                image: AppImages.departmentIcon,
                textKey: AppMessage.fileName,
                textValue: singleDoc.name,
              ),
              SizedBox(height: 2.h),
              SingleListTileModuleCustom(
                image: AppImages.departmentIcon,
                textKey: AppMessage.documentType,
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
