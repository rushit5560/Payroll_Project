import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/form_single_field_module.dart';
import 'package:payroll_system/constants/colors.dart';
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
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: subAdminProfileScreenController.imageFile != null
                            ? Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  shape: BoxShape.circle,
                                  // color: Colors.pink,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Image.file(
                                    subAdminProfileScreenController.imageFile!,
                                    // height: 100,
                                    // width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  shape: BoxShape.circle,
                                  // color: Colors.pink,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Image.network(
                                    subAdminProfileScreenController
                                                .profileData ==
                                            null
                                        ? AppMessage.empty
                                        : ApiUrl.apiImagePath +
                                            subAdminProfileScreenController
                                                .profileData!.photo,
                                    fit: BoxFit.fill,
                                    errorBuilder: (ctx, obj, st) {
                                      return Container(
                                        color: AppColors.greyColor
                                            .withOpacity(0.35),
                                        child: Center(
                                          child: Text(
                                            AppMessage.noImage,
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
                    ),
                    Positioned(
                      right: -5,
                      bottom: 20,
                      child: GestureDetector(
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
          FormSingleFieldModule(
              textEditingController:
                  subAdminProfileScreenController.nameController,
              validate: (val) => FieldValidation().validateUserName(val!),
              maxLength: 10,
              text: AppMessage.subAdminNameText,
              headerText: AppMessage.subAdminNameText,
              mandatoryText: AppMessage.mandatory),
          const SizedBox(height: 5),
          FormSingleFieldModule(
              textEditingController:
                  subAdminProfileScreenController.phoneNumberController,
              validate: (val) => FieldValidation().validateMobileNumber(val!),
              maxLength: 10,
              text: AppMessage.mobileNo,
              headerText: AppMessage.mobileNo,
              mandatoryText: AppMessage.mandatory),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.address,
            text: AppMessage.street,
            keyboardType: TextInputType.text,
            mandatoryText: AppMessage.mandatory,
            textEditingController:
                subAdminProfileScreenController.streetAddressController,
            validate: (value) => FieldValidation().validateStreetAddress(value),
          ),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.empty,
            isHeaderTextShow: false,
            text: AppMessage.landmark,
            keyboardType: TextInputType.text,
            mandatoryText: AppMessage.empty,
            textEditingController:
                subAdminProfileScreenController.townAddressController,
            validate: (value) => FieldValidation().validateTown(value),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: FormSingleFieldModule(
                  headerText: AppMessage.empty,
                  isHeaderTextShow: false,
                  text: AppMessage.city,
                  keyboardType: TextInputType.text,
                  mandatoryText: AppMessage.mandatory,
                  textEditingController:
                      subAdminProfileScreenController.cityAddressController,
                  validate: (value) => FieldValidation().validateCity(value),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: FormSingleFieldModule(
                  headerText: AppMessage.empty,
                  isHeaderTextShow: false,
                  text: AppMessage.state,
                  keyboardType: TextInputType.text,
                  mandatoryText: AppMessage.mandatory,
                  textEditingController:
                      subAdminProfileScreenController.stateAddressController,
                  validate: (value) => FieldValidation().validateState(value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.empty,
            isHeaderTextShow: false,
            text: AppMessage.zipcode,
            keyboardType: TextInputType.number,
            mandatoryText: AppMessage.mandatory,
            textEditingController:
                subAdminProfileScreenController.zipCodeAddressController,
            validate: (value) => FieldValidation().validateZipCode(value),
          ),
        ],
      ),
    );
  }
}

// class SubAdminSubmitButtonModule extends StatelessWidget {
//   SubAdminSubmitButtonModule({super.key});

//   final subAdminProfileScreenController =
//       Get.find<SubAdminProfileScreenController>();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 45,
//       width: 60.w,
//       child: ElevatedButton(
//         onPressed: () async {
//           if (subAdminProfileScreenController.formKey.currentState!
//               .validate()) {
//             await subAdminProfileScreenController
//                 .updateSubAdminProfileFunction();
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(28),
//           ),
//         ),
//         child: Center(
//           child: Text(
//             AppMessage.submitText,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: AppColors.whiteColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
