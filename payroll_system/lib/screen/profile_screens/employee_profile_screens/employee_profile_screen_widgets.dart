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

import '../../../controllers/profile_screens_controller/employee_profile_screen_controller.dart';

class EmployeeImageModule extends StatelessWidget {
  EmployeeImageModule({super.key});

  final employeeProfileScreenController =
      Get.find<EmployeeProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => employeeProfileScreenController.isLoading.value
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
                        child: employeeProfileScreenController.imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.file(
                                  employeeProfileScreenController.imageFile!,
                                  // height: 100,
                                  // width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.network(
                                  ApiUrl.apiImagePath +
                                      employeeProfileScreenController
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
                        employeeProfileScreenController
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

class EmployeeFormModule extends StatelessWidget {
  EmployeeFormModule({super.key});
  final employeeProfileScreenController =
      Get.find<EmployeeProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.greyColor,
      ),
      borderRadius: BorderRadius.circular(12),
    );

    return Form(
      key: employeeProfileScreenController.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: employeeProfileScreenController.nameController,
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
            controller: employeeProfileScreenController.phoneNumberController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) => FieldValidation().validateMobileNumber(val!),
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
            controller: employeeProfileScreenController.addressController,
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

class EmployeeSubmitButtonModule extends StatelessWidget {
  EmployeeSubmitButtonModule({super.key});

  final employeeProfileScreenController =
      Get.find<EmployeeProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 60.w,
      child: ElevatedButton(
        onPressed: () {
          employeeProfileScreenController.updateSubAdminProfileFunction();
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
