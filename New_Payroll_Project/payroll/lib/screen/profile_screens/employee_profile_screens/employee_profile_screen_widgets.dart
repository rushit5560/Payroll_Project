import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:payroll/common_modules/common_loader.dart';
import 'package:payroll/common_modules/form_single_field_module.dart';
import 'package:payroll/constants/colors.dart';

import 'package:payroll/utils/api_url.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/validator.dart';
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
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: employeeProfileScreenController.imageFile != null
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
                                    employeeProfileScreenController.imageFile!,
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
                                    employeeProfileScreenController
                                                .employeeData ==
                                            null
                                        ? AppMessage.empty
                                        : ApiUrl.apiImagePath +
                                            employeeProfileScreenController
                                                .employeeData!.photo,
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
                          employeeProfileScreenController
                              .showPhotoPickerSheet(context);
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 2),
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

class EmployeeFormModule extends StatelessWidget {
  EmployeeFormModule({super.key});
  final employeeProfileScreenController =
      Get.find<EmployeeProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: employeeProfileScreenController.formKey,
      child: Column(
        children: [
          FormSingleFieldModule(
              textEditingController:
                  employeeProfileScreenController.firstNameController,
              validate: (val) => FieldValidation().validateFirstName(val!),
              maxLength: 10,
              text: AppMessage.firstName,
              headerText: AppMessage.firstName,
              mandatoryText: " ${AppMessage.mandatory}"),
          const SizedBox(height: 5),
          FormSingleFieldModule(
              textEditingController:
                  employeeProfileScreenController.middleNameController,
              validate: (val) => FieldValidation().validateMiddleName(val!),
              maxLength: 10,
              text: AppMessage.middleName,
              headerText: AppMessage.middleName,
              mandatoryText: " ${AppMessage.mandatory}"),
          const SizedBox(height: 5),
          FormSingleFieldModule(
              textEditingController:
                  employeeProfileScreenController.lastNameController,
              validate: (val) => FieldValidation().validateLastName(val!),
              maxLength: 10,
              text: AppMessage.lastName,
              headerText: AppMessage.lastName,
              mandatoryText: " ${AppMessage.mandatory}"),
          const SizedBox(height: 5),
          FormSingleFieldModule(
              textEditingController:
                  employeeProfileScreenController.phoneNumberController,
              validate: (val) => FieldValidation().validateMobileNumber(val!),
              maxLength: 10,
              text: AppMessage.mobileNo,
              headerText: AppMessage.mobileNo,
              mandatoryText: " ${AppMessage.mandatory}"),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.dateOfBirth,
            text: AppMessage.dobHintText,
            mandatoryText: AppMessage.mandatory,
            keyboardType: TextInputType.datetime,
            readOnly: true,
            textEditingController:
                employeeProfileScreenController.dobFieldShowController,
            suffixIcon: Icons.calendar_month,
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              employeeProfileScreenController.selectDateOfBirth(context);
            },
            validate: (value) => FieldValidation().validateDateOfBirth(value),
          ),
          const SizedBox(height: 5),

          FormSingleFieldModule(
            headerText: AppMessage.address,
            text: AppMessage.street,
            keyboardType: TextInputType.text,
            mandatoryText: AppMessage.mandatory,
            textEditingController:
                employeeProfileScreenController.streetAddressController,
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
                employeeProfileScreenController.townAddressController,
            validate: (value) =>
                FieldValidation().validateLandmarkAddress(value),
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
                      employeeProfileScreenController.cityAddressController,
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
                      employeeProfileScreenController.stateAddressController,
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
                employeeProfileScreenController.zipcodeAddressController,
            // validate: (value) => FieldValidation().validateZipCode(value),
          ),

          // FormSingleFieldModule(
          //     textEditingController:
          //         employeeProfileScreenController.homeNumberController,
          //     validate: (val) =>
          //         FieldValidation().validateHomePhoneNumber(val!),
          //     maxLength: 10,
          //     text: AppMessage.homeNo,
          //     headerText: AppMessage.homeNo,
          //     mandatoryText: " ${AppMessage.mandatory}"),
          // const SizedBox(height: 5),
          // FormSingleFieldModule(
          //     textEditingController:
          //         employeeProfileScreenController.workNumberController,
          //     validate: (val) =>
          //         FieldValidation().validateWorkPhoneNumber(val!),
          //     maxLength: 10,
          //     text: AppMessage.workNO,
          //     headerText: AppMessage.workNO,
          //     mandatoryText: " ${AppMessage.mandatory}"),
          // const SizedBox(height: 5),
          // FormSingleFieldModule(
          //     textEditingController:
          //         employeeProfileScreenController.currentAddressController,
          //     validate: (val) => FieldValidation().validateAddress(val!),
          //     maxLength: 10,
          //     text: AppMessage.currentAddress,
          //     headerText: AppMessage.currentAddress,
          //     mandatoryText: " ${AppMessage.mandatory}"),
          // const SizedBox(height: 5),
          // FormSingleFieldModule(
          //     textEditingController:
          //         employeeProfileScreenController.homeAddressController,
          //     validate: (val) => FieldValidation().validateAddress(val!),
          //     maxLength: 10,
          //     text: AppMessage.homeAddress,
          //     headerText: AppMessage.homeAddress,
          //     mandatoryText: " ${AppMessage.mandatory}"),
        ],
      ),
    );
  }
}

// class EmployeeSubmitButtonModule extends StatelessWidget {
//   EmployeeSubmitButtonModule({super.key});

//   final employeeProfileScreenController =
//       Get.find<EmployeeProfileScreenController>();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 45,
//       width: 60.w,
//       child: ElevatedButton(
//         onPressed: () async {
//           if (employeeProfileScreenController.formKey.currentState!
//               .validate()) {
//             await employeeProfileScreenController
//                 .updateEmployeeProfileFunction();
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
