import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/form_single_field_module.dart';
import 'package:payroll/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll/controllers/sub_admin_manage_screen_controller.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/validator.dart';

class SubAdminManageWidgetsScreen extends StatelessWidget {
  SubAdminManageWidgetsScreen({super.key});

  final subAdminManageScreenController =
      Get.find<SubAdminManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: subAdminManageScreenController.formKey,
          child: Column(
            children: [
              FormSingleFieldModule(
                headerText: AppMessage.name,
                text: AppMessage.name,
                keyboardType: TextInputType.text,
                mandatoryText: AppMessage.mandatory,
                textEditingController:
                    subAdminManageScreenController.firstNameController,
                validate: (value) => FieldValidation().validateName(value),
              ),
              const SizedBox(height: 5),
              FormSingleFieldModule(
                headerText: AppMessage.email1,
                text: AppMessage.email1,
                keyboardType: TextInputType.emailAddress,
                mandatoryText: AppMessage.mandatory,
                textEditingController:
                    subAdminManageScreenController.emailController,
                validate: (value) => FieldValidation().validateEmail(value),
              ),
              const SizedBox(height: 5),
              FormSingleFieldModule(
                headerText: AppMessage.mobileNumber,
                text: AppMessage.mobileNumber,
                mandatoryText: AppMessage.mandatory,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                textEditingController:
                    subAdminManageScreenController.phoneNoController,
                validate: (value) =>
                    FieldValidation().validateMobileNumber(value),
              ),
              const SizedBox(height: 5),
              FormSingleFieldModule(
                headerText: AppMessage.address,
                text: AppMessage.street,
                keyboardType: TextInputType.text,
                mandatoryText: AppMessage.mandatory,
                textEditingController:
                    subAdminManageScreenController.streetAddressController,
                validate: (value) =>
                    FieldValidation().validateStreetAddress(value),
              ),
              const SizedBox(height: 5),
              FormSingleFieldModule(
                headerText: AppMessage.landmark,
                isHeaderTextShow: false,
                text: AppMessage.landmark,
                keyboardType: TextInputType.text,
                mandatoryText: AppMessage.empty,
                textEditingController:
                    subAdminManageScreenController.townAddressController,
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
                      mandatoryText: AppMessage.empty,
                      textEditingController:
                          subAdminManageScreenController.cityAddressController,
                      validate: (value) =>
                          FieldValidation().validateCity(value),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: FormSingleFieldModule(
                      headerText: AppMessage.empty,
                      isHeaderTextShow: false,
                      text: AppMessage.state,
                      keyboardType: TextInputType.text,
                      mandatoryText: AppMessage.empty,
                      textEditingController:
                          subAdminManageScreenController.stateAddressController,
                      validate: (value) =>
                          FieldValidation().validateState(value),
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
                mandatoryText: AppMessage.empty,
                textEditingController:
                    subAdminManageScreenController.zipcodeAddressController,
                validate: (value) => FieldValidation().validateZipCode(value),
              ),
              const SizedBox(height: 15),
              CustomSubmitButtonModule(
                labelText: AppMessage.submit,
                onPress: () async {
                  if (subAdminManageScreenController.formKey.currentState!
                      .validate()) {
                    // if (subAdminManageScreenController.employeeOption ==
                    //     EmployeeOption.create) {

                    await subAdminManageScreenController
                        .subAdminUpdateFunction();

                  } else {
                    // }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
