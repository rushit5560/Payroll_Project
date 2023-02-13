import 'dart:developer';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/date_format_changer.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/utils/extensions.dart';
import '../../../common_modules/form_single_field_module.dart';
import 'package:payroll_system/controllers/employee_manage_screen_controller.dart';
import 'package:payroll_system/models/company_department_model/company_department_model.dart';
import 'package:payroll_system/models/location_list_screen_model/location_list_screen_model.dart';

import '../../../utils/extension_methods/user_preference.dart';

// ignore: must_be_immutable
class EmployeeManageScreenWidgets extends StatelessWidget {
  EmployeeManageScreenWidgets({
    super.key,
  });

  final employeeCreteScreenController =
      Get.find<EmployeeManageScreenController>();

  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: employeeCreteScreenController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormSingleFieldModule(
              headerText: AppMessage.firstName,
              text: AppMessage.firstName,
              keyboardType: TextInputType.text,
              mandatoryText: AppMessage.mandatory,
              textEditingController:
                  employeeCreteScreenController.firstNameController,
              validate: (value) => FieldValidation().validateFirstName(value),
            ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.middleName,
              text: AppMessage.middleName,
              mandatoryText: AppMessage.mandatory,
              keyboardType: TextInputType.text,
              textEditingController:
                  employeeCreteScreenController.middleNameController,
              validate: (value) => FieldValidation().validateMiddleName(value),
            ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.lastName,
              text: AppMessage.lastName,
              mandatoryText: AppMessage.mandatory,
              keyboardType: TextInputType.text,
              textEditingController:
                  employeeCreteScreenController.lastNameController,
              validate: (value) => FieldValidation().validateLastName(value),
            ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.mobileNumber,
              text: AppMessage.mobileNumber,
              mandatoryText: AppMessage.mandatory,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              textEditingController:
                  employeeCreteScreenController.phoneNoController,
              validate: (value) =>
                  FieldValidation().validateMobileNumber(value),
            ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.dateOfBirth,
              text: AppMessage.selectDate,
              mandatoryText: AppMessage.mandatory,
              keyboardType: TextInputType.datetime,
              readOnly: true,
              maxLength: 10,
              textEditingController:
                  employeeCreteScreenController.dateOfBirthShowController,
              suffixIcon: Icons.calendar_month,
              onPressed: () async {
                await _selectDate(
                  context: context,
                  dateTime: employeeCreteScreenController.birthDate,
                  textEditingController:
                      employeeCreteScreenController.dateOfBirthController,
                  datePickerOption: DatePickerOption.dob,
                );
              },
              validate: (value) => FieldValidation().validateDateOfBirth(value),
            ),
            const SizedBox(height: 5),

            /// Pay Period
            RichText(
              textAlign: TextAlign.left,
              maxLines: null,
              text: TextSpan(
                  text: AppMessage.payPeriod,
                  style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: " ${AppMessage.mandatory}",
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.redColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ]),
            ).commonSymmetricPadding(vertical: 2),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: AppColors.greyColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent),
                  ),
                  // child: DropdownButtonHideUnderline(
                  child: SizedBox(
                    // height: 50,
                    child: Center(
                      child: DropdownButtonFormField<String>(
                        validator: (value) => FieldValidation().validateDropdownStatus(value!),
                        decoration:
                            const InputDecoration.collapsed(hintText: ''),
                        value: employeeCreteScreenController
                            .selectedValuePayper.value,
                        items: employeeCreteScreenController.isPayperList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        borderRadius: BorderRadius.circular(10),
                        icon: Image.asset(
                          AppImages.arrowDownIcon,
                          height: 15,
                          width: 15,
                        ).commonSymmetricPadding(horizontal: 10),
                        onChanged: (String? value) {
                          employeeCreteScreenController.isLoading(true);
                          employeeCreteScreenController.hourlyRateController
                              .clear();
                          employeeCreteScreenController.salaryController
                              .clear();
                          employeeCreteScreenController
                              .selectedValuePayper.value = value!;
                          employeeCreteScreenController.isLoading(false);
                        },
                      ).commonOnlyPadding(left: 10, right: 10, top: 10, bottom: 10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),

            employeeCreteScreenController.selectedValuePayper.value == "Hourly"
                ? FormSingleFieldModule(
                    headerText: AppMessage.hourlyRate,
                    text: AppMessage.hourlyRate,
                    mandatoryText: AppMessage.mandatory,
                    keyboardType: TextInputType.number,
                    textEditingController:
                        employeeCreteScreenController.hourlyRateController,
                    validate: (value) =>
                        FieldValidation().validateHourlyRate(value),
                  )
                : employeeCreteScreenController.selectedValuePayper.value ==
                        "Salary"
                    ? FormSingleFieldModule(
                        headerText: AppMessage.salary,
                        text: AppMessage.salary,
                        mandatoryText: AppMessage.mandatory,
                        keyboardType: TextInputType.number,
                        textEditingController:
                            employeeCreteScreenController.salaryController,
                        validate: (value) =>
                            FieldValidation().validateSalary(value),
                      )
                    : Container(),
            employeeCreteScreenController.selectedValuePayper.value ==
                    "Choose Option"
                ? Container()
                : const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.employmentDate,
              text: AppMessage.selectStartDate,
              keyboardType: TextInputType.datetime,
              mandatoryText: AppMessage.mandatory,
              readOnly: true,
              textEditingController:
                  employeeCreteScreenController.startDateShowController,
              suffixIcon: Icons.calendar_month,
              onPressed: () async {
                await _selectDate(
                    context: context,
                    dateTime: employeeCreteScreenController.employmentStartDate,
                    textEditingController:
                        employeeCreteScreenController.startDateController,
                    datePickerOption: DatePickerOption.startDate);
              },
              validate: (value) =>
                  FieldValidation().validateEmployeeStartDate(value),
            ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.employmentEndDate,
              text: AppMessage.employmentEndDate,
              readOnly: true,
              keyboardType: TextInputType.datetime,
              mandatoryText: AppMessage.mandatory,
              textEditingController:
                  employeeCreteScreenController.endDateShowController,
              suffixIcon: Icons.calendar_month,
              onPressed: () async {
                await _selectDate(
                  context: context,
                  dateTime: employeeCreteScreenController.employmentEndDate,
                  textEditingController:
                      employeeCreteScreenController.endDateController,
                  datePickerOption: DatePickerOption.endDate,
                  firstDate: employeeCreteScreenController.employmentStartDate,
                );
              },
              validate: (value) =>
                  FieldValidation().pleaseEnterEmployeeEndDate(value),
            ),

            const SizedBox(height: 5),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  maxLines: null,
                  text: TextSpan(
                      text: AppMessage.status,
                      style: TextStyleConfig.textStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: " ${AppMessage.mandatory}",
                          style: TextStyleConfig.textStyle(
                            textColor: AppColors.redColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ]),
                ).commonSymmetricPadding(vertical: 2),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: AppColors.greyColor),
                  ),
                  child: Container(
                    // height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Center(
                        child: DropdownButtonFormField<String>(
                          // validator: (value) {
                          //   employeeCreteScreenController.onError(true);

                          //   employeeCreteScreenController.onError = false.obs;
                          //   employeeCreteScreenController.onError(false);
                          //   if (employeeCreteScreenController
                          //           .selectedValue.value ==
                          //       AppMessage.chooseOption) {
                          //     employeeCreteScreenController.onError(true);

                          //     employeeCreteScreenController.onError = true.obs;
                          //     employeeCreteScreenController.onError(false);
                          //     return null;
                          //   }

                          //   employeeCreteScreenController.onError.value
                          //       ? Positioned(
                          //           bottom: 0,
                          //           child: Text(
                          //             AppMessage.chooseOption,
                          //             style: const TextStyle(color: Colors.red),
                          //           ),
                          //         )
                          //       : Container();
                          //   return null;
                          // },
                          validator: (value) => FieldValidation().validateDropdownStatus(value!),
                          decoration:
                              const InputDecoration.collapsed(hintText: ''),
                          value:
                              employeeCreteScreenController.selectedValue.value,
                          items: employeeCreteScreenController
                              .isActiveOptionList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          borderRadius: BorderRadius.circular(10),
                          icon: Image.asset(
                            AppImages.arrowDownIcon,
                            height: 15,
                            width: 15,
                          ).commonSymmetricPadding(horizontal: 10),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            employeeCreteScreenController.isLoading(true);
                            employeeCreteScreenController.selectedValue.value =
                                value!;
                            log('value : $value');
                            // employeeCreteScreenController.loadUI();

                            employeeCreteScreenController.isLoading(false);
                          },
                        ).commonOnlyPadding(left: 10, right: 10, top: 10, bottom: 10),
                      ),
                    ),
                    // ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),
            RichText(
              textAlign: TextAlign.left,
              maxLines: null,
              text: TextSpan(
                  text: AppMessage.company,
                  style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: " ${AppMessage.mandatory}",
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.redColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ]),
            ).commonSymmetricPadding(vertical: 2),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: AppColors.greyColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: employeeCreteScreenController
                          .companyDDSelectedStringItem,
                      items: [employeeCreteScreenController.companyName]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      borderRadius: BorderRadius.circular(10),
                      icon: Image.asset(
                        AppImages.arrowDownIcon,
                        height: 15,
                        width: 15,
                      ).commonSymmetricPadding(horizontal: 10),
                      onChanged: (String? value) async {
                        employeeCreteScreenController
                            .companyDDSelectedStringItem = value!;
                      },
                    ).commonOnlyPadding(left: 10, right: 10),
                  ),
                ),
              ),

              /// Company api data wise dropdown
              /*child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<CompanyData>(
                    value: employeeCreteScreenController.companyDDSelectedItem,
                    items: employeeCreteScreenController.allCompanyList
                        .map<DropdownMenuItem<CompanyData>>(
                            (CompanyData value) {
                      return DropdownMenuItem<CompanyData>(
                        value: value,
                        child: Text(value.userName),
                      );
                    }).toList(),
                    onChanged: (CompanyData? value) async {
                      // This is called when the user selects an item.
                      // employeeCreteScreenController.isloding(true);
                      employeeCreteScreenController.companyDDSelectedItem =
                          value;

                      int companyid = employeeCreteScreenController
                          .companyDDSelectedItem!.id;

                      log('companyid : $companyid');
                      log('valuevaluevaluevalue :${value!.userName}');

                      await employeeCreteScreenController
                          .getCompanyDepartmentFunction(companyid.toString());

                      log(employeeCreteScreenController
                          .companyDDSelectedItem!.id
                          .toString());
                    },
                  ).commonOnlyPadding(left: 10, right: 10),
                ),
              ),*/
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  maxLines: null,
                  text: TextSpan(
                      text: AppMessage.departmentNameDrawer,
                      style: TextStyleConfig.textStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: " ${AppMessage.mandatory}",
                          style: TextStyleConfig.textStyle(
                            textColor: AppColors.redColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ]),
                ).commonSymmetricPadding(vertical: 2),
                /*Text(
                  AppMessage.departmentNameDrawer,
                  style: TextStyleConfig.textStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ).commonSymmetricPadding(vertical: 2),*/
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: AppColors.greyColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Container(
                      // height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.transparent),
                      ),
                      // child: DropdownButtonHideUnderline(
                      child: Center(
                        child: DropdownButtonFormField<CompanyDepartmentData>(
                          validator: (value) => FieldValidation().validateDropdownDepartment(value!.departmentName!),
                          decoration:
                              const InputDecoration.collapsed(hintText: ''),
                          value: employeeCreteScreenController
                              .companyDepartmentData,
                          items: employeeCreteScreenController.companyDepartment
                              .map<DropdownMenuItem<CompanyDepartmentData>>(
                                  (CompanyDepartmentData value) {
                            return DropdownMenuItem<CompanyDepartmentData>(
                              value: value,
                              child: Text(value.departmentName!),
                            );
                          }).toList(),
                          borderRadius: BorderRadius.circular(10),
                          icon: Image.asset(
                            AppImages.arrowDownIcon,
                            height: 15,
                            width: 15,
                          ).commonSymmetricPadding(horizontal: 10),
                          onChanged: (CompanyDepartmentData? value) async {
                            employeeCreteScreenController.isLoading(true);
                            // This is called when the user selects an item.
                            employeeCreteScreenController
                                .companyDepartmentData = value;
                            employeeCreteScreenController.isLoading(false);
                          },
                        ).commonOnlyPadding(left: 10, right: 10, top: 10, bottom: 10),
                      ),
                    ),
                  ),
                ),
                // ),
              ],
            ),
            const SizedBox(height: 5),
            RichText(
              textAlign: TextAlign.left,
              maxLines: null,
              text: TextSpan(
                  text: AppMessage.location,
                  style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: " ${AppMessage.mandatory}",
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.redColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ]),
            ).commonSymmetricPadding(vertical: 2),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: AppColors.greyColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  // height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent),
                  ),
                  // child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButtonFormField(
                      validator: (value) => FieldValidation().validateDropdownLocation(value!.locationName!),
                      decoration: const InputDecoration.collapsed(hintText: ''),
                      value: employeeCreteScreenController.locationListData,
                      items: employeeCreteScreenController.allLocationList
                          .map<DropdownMenuItem<LocationListData>>(
                              (LocationListData value) {
                        return DropdownMenuItem<LocationListData>(
                            value: value, child: Text(value.locationName!));
                      }).toList(),
                      borderRadius: BorderRadius.circular(10),
                      icon: Image.asset(
                        AppImages.arrowDownIcon,
                        height: 15,
                        width: 15,
                      ).commonSymmetricPadding(horizontal: 10),
                      onChanged: (LocationListData? value) async {
                        employeeCreteScreenController.isLoading(true);
                        employeeCreteScreenController.locationListData = value;
                        employeeCreteScreenController.isLoading(false);
                      },
                    ).commonOnlyPadding(left: 10, right: 10, top: 10, bottom: 10),
                  ),
                ),
              ),
            ),
            // ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.employeeEmail,
              text: AppMessage.employeeEmail,
              keyboardType: TextInputType.emailAddress,
              mandatoryText: AppMessage.mandatory,
              readOnly: employeeCreteScreenController.employeeOption ==
                      EmployeeOption.update
                  ? true
                  : false,
              textEditingController:
                  employeeCreteScreenController.emailController,
              validate: (value) => FieldValidation().validateEmail(value),
            ),
            const SizedBox(height: 5),

            employeeCreteScreenController.employeeOption ==
                    EmployeeOption.update
                ? Container()
                : Obx(
                    () => FormSingleFieldModule(
                      obscureText:
                          employeeCreteScreenController.isPasswordVisible.value,
                      // obscureText:,
                      headerText: AppMessage.password,
                      text: AppMessage.password,
                      mandatoryText: AppMessage.mandatory,
                      keyboardType: TextInputType.visiblePassword,
                      // maxLength: 10,
                      textEditingController:
                          employeeCreteScreenController.passwordController,

                      suffixIcon:
                          employeeCreteScreenController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                      onPressed: () {
                        employeeCreteScreenController.isPasswordVisible.value =
                            !employeeCreteScreenController
                                .isPasswordVisible.value;
                      },
                      validate: (value) =>
                          FieldValidation().validatePassword(value),
                    ),
                  ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.address,
              text: AppMessage.street,
              keyboardType: TextInputType.text,
              mandatoryText: AppMessage.mandatory,
              textEditingController:
                  employeeCreteScreenController.streetAddressController,
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
                  employeeCreteScreenController.landmarkAddressController,
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
                        employeeCreteScreenController.cityAddressController,
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
                    mandatoryText: AppMessage.empty,
                    textEditingController:
                        employeeCreteScreenController.stateAddressController,
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
              mandatoryText: AppMessage.empty,
              textEditingController:
                  employeeCreteScreenController.zipcodeAddressController,
              validate: (value) => FieldValidation().validateZipCode(value),
            ),
            SizedBox(height: 2.h),

            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppMessage.uploadDocument,
                  style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (employeeCreteScreenController
                            .employeeSelectedDocumentList.length <=
                        5) {
                      await employeeCreteScreenController
                          .pickEmployeeDocumentFunction();
                    } else {
                      Fluttertoast.showToast(msg: "You reached at max length");
                    }
                  },
                  icon: const Icon(
                    Icons.add_rounded,
                    size: 25,
                  ),
                ),
              ],
            ),*/

            /*employeeCreteScreenController
                    .employeeSelectedDocumentList.isNotEmpty
                ? ListView.builder(
                    itemCount: employeeCreteScreenController
                        .employeeSelectedDocumentList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      String fileName = "";
                      List<String> tempStringList =
                          employeeCreteScreenController
                              .employeeSelectedDocumentList[i].path
                              .split('/');
                      for (int i = 0; i < tempStringList.length; i++) {
                        fileName = tempStringList[i];
                      }

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              // flex: 8,
                              child: Text(
                                fileName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Fluttertoast.showToast(msg: "Download");
                              },
                              icon: const Icon(Icons.download_rounded),
                            ),
                            IconButton(
                              onPressed: () {
                                employeeCreteScreenController
                                    .isLoading(true);
                                employeeCreteScreenController
                                    .employeeSelectedDocumentList
                                    .removeAt(i);
                                employeeCreteScreenController
                                    .isLoading(false);
                                log('Length : ${employeeCreteScreenController.employeeSelectedDocumentList}');
                              },
                              icon: const Icon(Icons.close_rounded),
                            ),
                          ],
                        ).commonSymmetricPadding(horizontal: 5),
                      ).commonSymmetricPadding(vertical: 5);
                    },
                  )
                : Container(),*/

            // const SizedBox(height: 15),
            /*Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ButtonCustom(
                    onPressed: () async {
                      if (employeeCreteScreenController
                          .formKey.currentState!
                          .validate()) {
                        if (employeeCreteScreenController
                                .employeeOption ==
                            EmployeeOption.create) {
                          // if (employeeCreteScreenController.images != null) {
                          if (employeeCreteScreenController
                                  .companyDepartmentData!.departmentName ==
                              AppMessage.empty) {
                            Fluttertoast.showToast(
                                msg: AppMessage.pleaseSelectDepartment);
                          } else if (employeeCreteScreenController
                                  .selectedValuePayper.value ==
                              AppMessage.chooseOption) {
                            Fluttertoast.showToast(
                                msg: AppMessage.pleaseSelectPayper);
                          } else {
                            await employeeCreteScreenController
                                .employeeCreateFunction();
                          }
                          // } else {
                          //   Fluttertoast.showToast(
                          //       msg: "Please select profile image!");
                          // }
                        } else {
                          log("updateEmployeeDetailsFunction");
                          if (employeeCreteScreenController
                                  .companyDepartmentData!.departmentName ==
                              AppMessage.empty) {
                            Fluttertoast.showToast(
                                msg: AppMessage.pleaseSelectDepartment);
                          } else if (employeeCreteScreenController
                                  .selectedValuePayper.value ==
                              AppMessage.chooseOption) {
                            Fluttertoast.showToast(
                                msg: AppMessage.pleaseSelectPayper);
                          } else {
                            await employeeCreteScreenController
                                .updateEmployeeDetailsFunction();
                          }
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
            ),*/
            CustomSubmitButtonModule(
              labelText: AppMessage.submit,
              onPress: () async {
                if (employeeCreteScreenController.formKey.currentState!
                    .validate()) {
                  if (employeeCreteScreenController.employeeOption ==
                      EmployeeOption.create) {
                    // if (employeeCreteScreenController.images != null) {
                    // if (employeeCreteScreenController
                    //         .companyDepartmentData!.departmentName ==
                    //     AppMessage.empty) {
                    //   Fluttertoast.showToast(
                    //       msg: AppMessage.pleaseSelectDepartment);
                    // }

                    // if (employeeCreteScreenController
                    //         .selectedValuePayper.value ==
                    //     AppMessage.chooseOption) {
                    //   Fluttertoast.showToast(
                    //       msg: AppMessage.pleaseSelectPayper);
                    // } else {
                    await employeeCreteScreenController
                        .employeeCreateFunction();
                    // }
                    // } else {
                    //   Fluttertoast.showToast(
                    //       msg: "Please select profile image!");
                    // }
                  } else {
                    log("updateEmployeeDetailsFunction");
                    // if (employeeCreteScreenController
                    //         .companyDepartmentData!.departmentName ==
                    //     AppMessage.empty) {
                    //   Fluttertoast.showToast(
                    //       msg: AppMessage.pleaseSelectDepartment);
                    // }

                    // if (employeeCreteScreenController
                    //         .selectedValuePayper.value ==
                    //     AppMessage.chooseOption) {
                    //   Fluttertoast.showToast(
                    //       msg: AppMessage.pleaseSelectPayper);
                    // } else {
                    await employeeCreteScreenController
                        .updateEmployeeDetailsFunction();
                    // }
                  }
                }
              },
            ),
          ],
        ).commonOnlyPadding(top: 1.h, right: 6.w, left: 6.w, bottom: 4.h),
      ),
    );
  }

  Future<void> _selectDate({
    required BuildContext context,
    required DateTime dateTime,
    required TextEditingController textEditingController,
    required DatePickerOption datePickerOption,
    DateTime? firstDate,
  }) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: datePickerOption == DatePickerOption.endDate
          ? firstDate!
          : DateTime(1950),
      lastDate: datePickerOption == DatePickerOption.endDate
          ? DateTime(2080)
          : DateTime.now(),
    );
    if (d != null) {
      employeeCreteScreenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";

      if (datePickerOption == DatePickerOption.dob) {
        employeeCreteScreenController.birthDate = d;
        employeeCreteScreenController.dateOfBirthShowController.text = DateFormater().changeDateFormat(
          DateTime.parse(d.toString()), employeeCreteScreenController.prefsDateFormat
        );
        log('D: $d');
        log('DOB DAte : ${employeeCreteScreenController.dateOfBirthShowController.text}');

      } else if (datePickerOption == DatePickerOption.startDate) {
        employeeCreteScreenController.employmentStartDate = d;
        employeeCreteScreenController.startDateShowController.text = DateFormater().changeDateFormat(
            d, employeeCreteScreenController.prefsDateFormat
        );
      } else {
        employeeCreteScreenController.employmentEndDate = d;
        employeeCreteScreenController.endDateShowController.text = DateFormater().changeDateFormat(
            d, employeeCreteScreenController.prefsDateFormat
        );
      }
      employeeCreteScreenController.isLoading(false);
    }
  }
}

// ignore: must_be_immutable
class ButtonCustom extends StatelessWidget {
  final String text;
  Color textColor;
  FontWeight? fontWeight;
  double? textsize;
  Function() onPressed;
  ButtonCustom({
    Key? key,
    required this.text,
    this.textColor = AppColors.whiteColor,
    this.fontWeight = FontWeight.normal,
    this.textsize = 12,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(200, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyleConfig.textStyle(
          textColor: textColor,
          fontWeight: fontWeight!,
          fontSize: textsize!,
        ),
      ),
    );
  }
}

class ImagePickerCustom extends StatelessWidget {
  ImagePickerCustom({super.key});
  final employeeCreteScreenController =
      Get.find<EmployeeManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => employeeCreteScreenController.isLoading.value == true
          ? const CircularProgressIndicator()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    employeeCreteScreenController.showPicker(context);
                  },
                  child: ClipOval(
                    child: Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: employeeCreteScreenController.employeeOption ==
                                  EmployeeOption.create
                              ? employeeCreteScreenController.images != null
                                  ? Image.file(
                                      employeeCreteScreenController.images!,
                                      fit: BoxFit.fill,
                                    )
                                  : const Icon(
                                      Icons.camera_alt_outlined,
                                    )
                              : employeeCreteScreenController.images != null
                                  ? Image.file(
                                      employeeCreteScreenController.images!,
                                      fit: BoxFit.fill,
                                    )
                                  : employeeCreteScreenController
                                              .oldImageName !=
                                          AppMessage.empty
                                      ? Image.network(
                                          "${ApiUrl.apiImagePath}${employeeCreteScreenController.oldImageName}",
                                          fit: BoxFit.fill,
                                        )
                                      : const Icon(
                                          Icons.camera_alt_outlined,
                                        ),
                        ),
                        employeeCreteScreenController.employeeOption ==
                                EmployeeOption.update
                            ? Positioned(
                                top: 70,
                                right: 8,
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
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
