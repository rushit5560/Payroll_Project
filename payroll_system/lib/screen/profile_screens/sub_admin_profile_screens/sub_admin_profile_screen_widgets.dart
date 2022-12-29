import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/profile_screens_controller/admin_profile_screen_controller.dart';
import 'package:payroll_system/controllers/profile_screens_controller/sub_admin_profile_screen_controller.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:sizer/sizer.dart';

class SubAdminImageModule extends StatelessWidget {
  SubAdminImageModule({super.key});

  final subAdminProfileScreenController =
      Get.find<SubAdminProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => subAdminProfileScreenController.isLoading.value
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
                        child: subAdminProfileScreenController.imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.file(
                                  subAdminProfileScreenController.imageFile!,
                                  // height: 100,
                                  // width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.network(
                                  subAdminProfileScreenController.profileData ==
                                          null
                                      ? ""
                                      : ApiUrl.apiImagePath +
                                          subAdminProfileScreenController
                                              .profileData!.photo,
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
                        subAdminProfileScreenController
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

class SubAdminFormModule extends StatelessWidget {
  SubAdminFormModule({super.key});

  final subAdminProfileScreenController =
      Get.find<SubAdminProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.greyColor,
      ),
      borderRadius: BorderRadius.circular(12),
    );

    return Form(
      key: subAdminProfileScreenController.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: subAdminProfileScreenController.nameController,
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
            controller: subAdminProfileScreenController.phoneNumberController,
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
            controller: subAdminProfileScreenController.addressController,
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
    );
  }
}

class SubAdminSubmitButtonModule extends StatelessWidget {
  SubAdminSubmitButtonModule({super.key});

  final subAdminProfileScreenController =
      Get.find<SubAdminProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 60.w,
      child: ElevatedButton(
        onPressed: () async {
          if (subAdminProfileScreenController.formKey.currentState!
              .validate()) {
            await subAdminProfileScreenController
                .updateSubAdminProfileFunction();
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
