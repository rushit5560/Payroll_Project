import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/profile_screens_controller/admin_profile_screen_controller.dart';
import 'package:payroll_system/controllers/profile_screens_controller/company_profile_screen_controller.dart';
import 'package:payroll_system/controllers/profile_screens_controller/sub_admin_profile_screen_controller.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:sizer/sizer.dart';

import '../../../models/company_manage_screen_model/get_all_department_model.dart';

class CompanyImageModule extends StatelessWidget {
  CompanyImageModule({super.key});

  final companyProfileScreenController =
      Get.find<CompanyProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => companyProfileScreenController.isLoading.value
          ? CommonLoader().showLoader()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: companyProfileScreenController.imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.file(
                                  companyProfileScreenController.imageFile!,
                                  // height: 100,
                                  // width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.network(
                                  companyProfileScreenController.companyData ==
                                          null
                                      ? ""
                                      : ApiUrl.apiImagePath +
                                          companyProfileScreenController
                                              .companyData!.photo,
                                  fit: BoxFit.cover,
                                  errorBuilder: (ctx, obj, st) {
                                    return Container(
                                      color:
                                          AppColors.greyColor.withOpacity(0.35),
                                      child: Center(
                                        child: Text(
                                          "No Image",
                                          style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        companyProfileScreenController
                            .showPhotoPickerSheet(context);
                      },
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class CompanyFormModule extends StatelessWidget {
  CompanyFormModule({super.key});

  final companyProfileScreenController =
      Get.find<CompanyProfileScreenController>();
  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.greyColor,
      ),
      borderRadius: BorderRadius.circular(12),
    );

    return Obx(
      () => Form(
        key: companyProfileScreenController.formKey,
        child: Column(
          children: [
            DropDownMultiSelect(
              options: companyProfileScreenController.departmentStringList,

              decoration: InputDecoration(
                fillColor: AppColors.greyColor.withOpacity(0.25),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelText: "Choose Department",
                border: border,
                enabledBorder: border,
                filled: true,
              ),

              // whenEmpty: 'Choose Department',
              validator: (val) {
                if (val == "Choose Department") {
                  return "Please Choose Department";
                } else {
                  return "";
                }
              },
              onChanged: (value) {
                companyProfileScreenController.selectedDepartmentList.value =
                    value;
                // companyProfileScreenController.selectedDepartmentOption.value =
                //     "";
                companyProfileScreenController.selectedDepartmentIdList = [];

                // Selected Department generate new id list for send in api
                for (int i = 0; i < value.length; i++) {
                  for (int j = 0;
                      j < companyProfileScreenController.departmentList.length;
                      j++) {
                    if (value[i] ==
                        companyProfileScreenController
                            .departmentList[j].departmentName) {
                      companyProfileScreenController.selectedDepartmentIdList
                          .add(
                        companyProfileScreenController.departmentList[j].id
                            .toString(),
                      );
                    }
                  }
                }

                log('companyProfileScreenController.selectedDepartmentIdList :${companyProfileScreenController.selectedDepartmentIdList}');
                companyProfileScreenController.loadUI();
              },
              // ignore: invalid_use_of_protected_member
              selectedValues:
                  companyProfileScreenController.selectedDepartmentList.value,
            ),
            SizedBox(height: 2.h),
            TextFormField(
              controller: companyProfileScreenController.nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) => FieldValidation().validateUserName(val!),
              decoration: InputDecoration(
                fillColor: AppColors.greyColor.withOpacity(0.25),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelText: "Name",
                border: border,
                enabledBorder: border,
                filled: true,
              ),
            ),
            SizedBox(height: 2.h),
            TextFormField(
              controller: companyProfileScreenController.phoneNumberController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) => FieldValidation().validateMobileNumber(val!),
              maxLength: 10,
              decoration: InputDecoration(
                fillColor: AppColors.greyColor.withOpacity(0.25),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelText: "Phone Number",
                border: border,
                enabledBorder: border,
                filled: true,
              ),
            ),
            SizedBox(height: 2.h),
            TextFormField(
              controller: companyProfileScreenController.addressController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) => FieldValidation().validateAddress(val!),
              decoration: InputDecoration(
                fillColor: AppColors.greyColor.withOpacity(0.25),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelText: "Address",
                border: border,
                enabledBorder: border,
                filled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompanySubmitButtonModule extends StatelessWidget {
  CompanySubmitButtonModule({super.key});

  final companyProfileScreenController =
      Get.find<CompanyProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 60.w,
      child: ElevatedButton(
        onPressed: () async {
          if (companyProfileScreenController.formKey.currentState!.validate()) {
            await companyProfileScreenController.updateCompanyProfileFunction();
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Center(
          child: Text(
            AppMessage.submitText,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
