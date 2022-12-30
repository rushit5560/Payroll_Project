import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/profile_screens_controller/admin_profile_screen_controller.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:sizer/sizer.dart';

class AdminImageModule extends StatelessWidget {
  AdminImageModule({super.key});

  final adminProfileScreenController = Get.find<AdminProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => adminProfileScreenController.isLoading.value
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
                        child: adminProfileScreenController.imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.file(
                                  adminProfileScreenController.imageFile!,
                                  // height: 100,
                                  // width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.network(
                                  adminProfileScreenController.profileData ==
                                          null
                                      ? ""
                                      : ApiUrl.apiImagePath +
                                          adminProfileScreenController
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

                                // CachedNetworkImage(
                                //   imageUrl: adminProfileScreenController
                                //               .profileData!.photo ==

                                //           ""
                                //       ? ""
                                //       : ApiUrl.apiImagePath +
                                //           adminProfileScreenController
                                //               .profileData!.photo,
                                //   fit: BoxFit.cover,
                                //   errorWidget: (ctx, obj, st) {
                                //     return Container(
                                //       color:
                                //           AppColors.greyColor.withOpacity(0.35),
                                //       child: Center(
                                //         child: Text(
                                //           "Upload Image",
                                //           style: TextStyle(
                                //             color: AppColors.blackColor,
                                //             fontSize: 10.sp,
                                //           ),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        adminProfileScreenController
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

class AdminNameFieldModule extends StatelessWidget {
  AdminNameFieldModule({super.key});

  final adminProfileScreenController = Get.find<AdminProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.greyColor,
      ),
      borderRadius: BorderRadius.circular(12),
    );

    return Form(
      key: adminProfileScreenController.formKey,
      child: TextFormField(
        controller: adminProfileScreenController.userNameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) => FieldValidation().validateUserName(val!),
        decoration: InputDecoration(
          fillColor: AppColors.greyColor.withOpacity(0.25),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          labelText: AppMessage.userName,
          border: border,
          enabledBorder: border,
          filled: true,
        ),
      ),
    );
  }
}

class AdminSubmitButtonModule extends StatelessWidget {
  AdminSubmitButtonModule({super.key});

  final adminProfileScreenController = Get.find<AdminProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 60.w,
      child: ElevatedButton(
        onPressed: () async {
          if (adminProfileScreenController.formKey.currentState!.validate()) {
            await adminProfileScreenController.updateAdminProfileFunction();
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
