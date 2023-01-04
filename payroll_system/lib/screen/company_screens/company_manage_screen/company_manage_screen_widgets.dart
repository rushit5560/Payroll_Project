import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/company_manage_screen_controller.dart';
import 'package:payroll_system/Utils/validator.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/custom_button_module.dart';
import 'package:payroll_system/common_modules/form_single_field_module.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class CompanyFormModule extends StatelessWidget {
  CompanyFormModule({Key? key}) : super(key: key);
  final screenController = Get.find<CompanyManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: screenController.formKey,
          child: Column(
            children: [
              FormSingleFieldModule(
                headerText: AppMessage.companyLabelName,
                text: AppMessage.companyName,
                mandatoryText: AppMessage.mandatory,
                keyboardType: TextInputType.text,
                textEditingController: screenController.nameFieldController,
                validate: (value) =>
                    FieldValidation().validateCompanyName(value),
              ),
              const SizedBox(height: 5),

              FormSingleFieldModule(
                headerText: AppMessage.companyLabelEmail,
                text: AppMessage.labelEmailName,
                mandatoryText: AppMessage.mandatory,
                keyboardType: TextInputType.emailAddress,
                textEditingController: screenController.emailFieldController,
                readOnly: screenController.companyOption == CompanyOption.create
                    ? false
                    : true,
                validate: (value) => FieldValidation().validateEmail(value),
              ),
              const SizedBox(height: 5),

              FormSingleFieldModule(
                headerText: AppMessage.companyPhoneNumber,
                text: AppMessage.labelPhoneNo,
                mandatoryText: AppMessage.mandatory,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                textEditingController:
                    screenController.phoneNumberFieldController,
                validate: (value) =>
                    FieldValidation().validateMobileNumber(value),
              ),
              const SizedBox(height: 5),

              screenController.companyOption == CompanyOption.update
                  ? Container()
                  : Obx(
                      () => FormSingleFieldModule(
                        obscureText: screenController.isPasswordVisible.value,
                        // obscureText:,
                        headerText: AppMessage.password,
                        text: AppMessage.password,
                        mandatoryText: AppMessage.mandatory,
                        keyboardType: TextInputType.visiblePassword,
                        // maxLength: 10,
                        readOnly: true,
                        textEditingController:
                            screenController.passwordFieldController,
                        suffixIcon: screenController.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onPressed: () {
                          screenController.isPasswordVisible.value =
                              !screenController.isPasswordVisible.value;
                        },
                        validate: (value) =>
                            FieldValidation().validatePassword(value),
                      ),
                    ),
              const SizedBox(height: 5),

              /* Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    maxLines: null,
                    text: TextSpan(
                        text: AppMessage.companyDepartmentNameDrawer,
                        style: TextStyleConfig.textStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: AppMessage.mandatory,
                            style: TextStyleConfig.textStyle(
                              textColor: AppColors.redColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ]),
                  ).commonSymmetricPadding(vertical: 2),
                  DropDownMultiSelect(
                    options: screenController.departmentStringList,
                    whenEmpty: AppMessage.chooseDepartment,
                    onChanged: (value) {
                      screenController.selectedDepartmentList.value = value;
                      screenController.selectedDepartmentOption.value = "";
                      screenController.selectedDepartmentIdList = [];

                      // Selected Department generate new id list for send in api
                      for (int i = 0; i < value.length; i++) {
                        for (int j = 0;
                            j < screenController.departmentList.length;
                            j++) {
                          if (value[i] ==
                              screenController
                                  .departmentList[j].departmentName) {
                            screenController.selectedDepartmentIdList.add(
                                screenController.departmentList[j].id
                                    .toString());
                          }
                        }
                      }

                      log('screenController.selectedDepartmentIdList :${screenController.selectedDepartmentIdList}');
                      screenController.loadUI();
                    },
                    // ignore: invalid_use_of_protected_member
                    selectedValues:
                        screenController.selectedDepartmentList.value,
                  ),
                ],
              ),
              const SizedBox(height: 5),*/

              /*Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    maxLines: null,
                    text: TextSpan(
                        text: AppMessage.companyLocation,
                        style: TextStyleConfig.textStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: AppMessage.mandatory,
                            style: TextStyleConfig.textStyle(
                              textColor: AppColors.redColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ]),
                  ).commonSymmetricPadding(vertical: 2),
                  DropDownMultiSelect(
                    options: screenController.locationStringList,
                    whenEmpty: AppMessage.chooseLocation,
                    onChanged: (value) {
                      screenController.selectedLocationList.value = value;
                      screenController.selectedLocationOption.value = "";
                      screenController.selectedLocationIdList = [];

                      // Selected Department generate new id list for send in api
                      for (int i = 0; i < value.length; i++) {
                        for (int j = 0;
                            j < screenController.allLocationList.length;
                            j++) {
                          if (value[i] ==
                              screenController
                                  .allLocationList[j].locationName) {
                            screenController.selectedLocationIdList.add(
                                screenController.allLocationList[j].id
                                    .toString());
                          }
                        }
                      }

                      log('screenController.selectedDepartmentIdList :${screenController.selectedLocationIdList}');
                      screenController.loadUI();
                    },
                    // ignore: invalid_use_of_protected_member
                    selectedValues: screenController.selectedLocationList.value,
                  ),
                ],
              ),
              const SizedBox(height: 5),*/

              /*FormSingleFieldModule(
                headerText: AppMessage.labelCompanyAddress,
                text: AppMessage.labelCompanyAddress,
                keyboardType: TextInputType.text,
                mandatoryText: AppMessage.empty,
                textEditingController: screenController.addressFieldController,
                // validate: (value) => FieldValidation().validateCompanyAddress(value),
              ),
              const SizedBox(height: 5),*/

              FormSingleFieldModule(
                headerText: AppMessage.labelCompanyAddress,
                text: AppMessage.street,
                keyboardType: TextInputType.text,
                mandatoryText: AppMessage.mandatory,
                textEditingController:
                screenController.streetAddressController,
                validate: (value) =>
                    FieldValidation().validateStreetAddress(value),
              ),
              const SizedBox(height: 5),

              FormSingleFieldModule(
                headerText: AppMessage.empty,
                isHeaderTextShow: false,
                text: AppMessage.landmark,
                keyboardType: TextInputType.text,
                mandatoryText: AppMessage.empty,
                textEditingController:
                screenController.landmarkAddressController,
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
                      mandatoryText: AppMessage.empty,
                      textEditingController:
                      screenController.cityAddressController,
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
                      screenController.stateAddressController,
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
                screenController.zipcodeAddressController,
                validate: (value) =>
                    FieldValidation().validateZipCode(value),
              ),

              const SizedBox(height: 15),

              // Buttons Module - Submit & Back
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ButtonCustom(
                      onPressed: () async {
                        if (screenController.formKey.currentState!.validate()) {
                          if (screenController.companyOption ==
                              CompanyOption.create) {
                            await screenController.createCompanyFunction();
                            /*if (screenController.selectedDepartmentIdList.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: AppMessage.pleaseSelectDepartment);
                            } else if (screenController.selectedDepartmentIdList.isNotEmpty) {

                            }*/
                          } else {
                            await screenController.updateCompanyDetailsFunction();
                            /*if (screenController.selectedDepartmentIdList.isEmpty) {
                              Fluttertoast.showToast(msg: AppMessage.pleaseSelectDepartment);
                            } else if (screenController.selectedDepartmentIdList.isNotEmpty) {
                            }*/
                          }
                        }
                      },
                      text: AppMessage.submit,
                      textsize: 15.sp,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: ButtonCustom(
                      onPressed: () => CustomAlertDialog().showAlertDialog(
                        context: context,
                        textContent: AppMessage.permissionMessage,
                        onYesTap: () {
                          Get.back();
                          Get.back();
                        },
                        onCancelTap: () => Get.back(),
                      ),
                      text: AppMessage.back,
                      textsize: 15.sp,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
