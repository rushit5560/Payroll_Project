import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:payroll_system/controllers/company_manage_screen_controller.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/Utils/validator.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/custom_button_module.dart';
import 'package:payroll_system/common_modules/form_single_field_module.dart';
import 'package:payroll_system/constants/anums.dart';
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
        child: Column(
          children: [
            FormSingleFieldModule(
              headerText: AppMessage.companyLabelName,
              text: AppMessage.companyName,
              keyboardType: TextInputType.text,
              textEditingController: screenController.nameFieldController,
              validate: (value) => FieldValidation().validateCompanyName(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.companyLabelEmail,
              text: AppMessage.labelEmailName,
              keyboardType: TextInputType.emailAddress,
              textEditingController: screenController.emailFieldController,
              validate: (value) => FieldValidation().validateEmail(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.companyPhoneNumber,
              text: AppMessage.labelPhoneNo,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              textEditingController:
                  screenController.phoneNumberFieldController,
              validate: (value) =>
                  FieldValidation().validateMobileNumber(value),
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppMessage.companyDepartmentNameDrawer,
                  style: TextStyleConfig.textStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ).commonSymmetricPadding(vertical: 2),
                DropDownMultiSelect(
                  options: screenController.departmentStringList,
                  whenEmpty: 'Choose Department',
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
                            screenController.departmentList[j].departmentName) {
                          screenController.selectedDepartmentIdList.add(
                              screenController.departmentList[j].id.toString());
                        }
                      }
                    }

                    log('screenController.selectedDepartmentIdList :${screenController.selectedDepartmentIdList}');
                    screenController.loadUI();
                  },
                  // ignore: invalid_use_of_protected_member
                  selectedValues: screenController.selectedDepartmentList.value,
                ),
              ],
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.labelCompanyAddress,
              text: AppMessage.labelCompanyAddress,
              keyboardType: TextInputType.text,
              textEditingController: screenController.addressFieldController,
              validate: (value) => FieldValidation().validateCompanyName(value),
            ),
            const SizedBox(height: 5),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ButtonCustom(
                    onPressed: () async {
                      if (screenController.companyOption ==
                          CompanyOption.create) {
                        if (screenController.selectedDepartmentIdList.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please select department");
                        } else if (screenController
                            .selectedDepartmentIdList.isNotEmpty) {
                          await screenController.createCompanyFunction();
                        }
                      } else {
                        if (screenController.selectedDepartmentIdList.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please select department");
                        } else if (screenController
                            .selectedDepartmentIdList.isNotEmpty) {
                          await screenController.updateCompanyDetailsFunction();
                        }
                      }
                    },
                    text: "Submit",
                    textsize: 15.sp,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: ButtonCustom(
                    onPressed: () => CustomAlertDialog().showAlertDialog(
                      context: context,
                      textContent: 'Are you sure you want to go to back ?',
                      onYesTap: () {
                        Get.back();
                        Get.back();
                      },
                      onCancelTap: () => Get.back(),
                    ),
                    text: "Back",
                    textsize: 15.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
