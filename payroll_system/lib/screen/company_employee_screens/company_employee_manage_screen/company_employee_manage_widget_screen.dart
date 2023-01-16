import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/company_employee_manage_screen_controller.dart';
import 'package:payroll_system/models/company_department_model/company_department_model.dart';
import 'package:payroll_system/models/location_list_screen_model/location_list_screen_model.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/form_single_field_module.dart';



// ignore: must_be_immutable
class CompanyEmployeeManageWidgetsScreen extends StatelessWidget {
  CompanyEmployeeManageWidgetsScreen({
    super.key,
  });

  final companyEmployeeManageScreenController =
      Get.find<CompanyEmployeeManageScreenController>();

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: companyEmployeeManageScreenController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            FormSingleFieldModule(
              headerText: AppMessage.firstName,
              text: AppMessage.firstName,
              keyboardType: TextInputType.text,
              mandatoryText: AppMessage.mandatory,
              textEditingController:
                  companyEmployeeManageScreenController.firstNameController,
              validate: (value) => FieldValidation().validateFirstName(value),
            ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.middleName,
              text: AppMessage.middleName,
              mandatoryText: AppMessage.mandatory,
              keyboardType: TextInputType.text,
              textEditingController:
                  companyEmployeeManageScreenController.middleNameController,
              validate: (value) => FieldValidation().validateMiddleName(value),
            ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.lastName,
              text: AppMessage.lastName,
              mandatoryText: AppMessage.mandatory,
              keyboardType: TextInputType.text,
              textEditingController:
                  companyEmployeeManageScreenController.lastNameController,
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
                  companyEmployeeManageScreenController.phoneNoController,
              validate: (value) =>
                  FieldValidation().validateMobileNumber(value),
            ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.dateOfBirth,
              text: AppMessage.selectDate,
              mandatoryText: AppMessage.mandatory,
              keyboardType: TextInputType.datetime,
              maxLength: 10,
              textEditingController:
                  companyEmployeeManageScreenController.dateOfBirthController,
              suffixIcon: Icons.calendar_month,
              onPressed: () async {
                await _selectDate(
                  context: context,
                  dateTime: companyEmployeeManageScreenController.birthDate,
                  textEditingController: companyEmployeeManageScreenController
                      .dateOfBirthController,
                  datePickerOption: DatePickerOption.dob,
                );
              },
              validate: (value) => FieldValidation().validateDateOfBirth(value),
            ),
            const SizedBox(height: 5),

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
                    color: Colors.white, borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: companyEmployeeManageScreenController
                          .selectedValuePayper.value,
                      items: companyEmployeeManageScreenController.isPayperList
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
                        companyEmployeeManageScreenController.isLoading(true);
                        companyEmployeeManageScreenController.hourlyRateController
                            .clear();
                        companyEmployeeManageScreenController.salaryController
                            .clear();
                        companyEmployeeManageScreenController
                            .selectedValuePayper.value = value!;
                        companyEmployeeManageScreenController.isLoading(false);
                      },
                    ).commonOnlyPadding(left: 10, right: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),

            companyEmployeeManageScreenController.selectedValuePayper.value ==
                    "Hourly"
                ? FormSingleFieldModule(
                    headerText: AppMessage.hourlyRate,
                    text: AppMessage.hourlyRate,
                    mandatoryText: AppMessage.mandatory,
                    keyboardType: TextInputType.number,
                    textEditingController: companyEmployeeManageScreenController
                        .hourlyRateController,
                    validate: (value) =>
                        FieldValidation().validateHourlyRate(value),
                  )
                : companyEmployeeManageScreenController
                            .selectedValuePayper.value ==
                        "Salary"
                    ? FormSingleFieldModule(
                        headerText: AppMessage.salary,
                        text: AppMessage.salary,
                        mandatoryText: AppMessage.mandatory,
                        keyboardType: TextInputType.number,
                        textEditingController:
                            companyEmployeeManageScreenController
                                .salaryController,
                        validate: (value) =>
                            FieldValidation().validateSalary(value),
                      )
                    : Container(),
            companyEmployeeManageScreenController.selectedValuePayper.value ==
                    "Choose Option"
                ? Container()
                : const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.employmentDate,
              text: AppMessage.selectStartDate,
              keyboardType: TextInputType.datetime,
              mandatoryText: AppMessage.mandatory,
              textEditingController:
                  companyEmployeeManageScreenController.startDateController,
              suffixIcon: Icons.calendar_month,
              onPressed: () async {
                await _selectDate(
                    context: context,
                    dateTime: companyEmployeeManageScreenController
                        .employmentStartDate,
                    textEditingController: companyEmployeeManageScreenController
                        .startDateController,
                    datePickerOption: DatePickerOption.startDate);
              },
              validate: (value) =>
                  FieldValidation().validateStartDayWork(value),
            ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.endDate,
              text: AppMessage.endDate,
              keyboardType: TextInputType.datetime,
              mandatoryText: AppMessage.mandatory,
              textEditingController:
                  companyEmployeeManageScreenController.endDateController,
              suffixIcon: Icons.calendar_month,
              onPressed: () async {
                await _selectDate(
                  context: context,
                  dateTime:
                      companyEmployeeManageScreenController.employmentEndDate,
                  textEditingController:
                      companyEmployeeManageScreenController.endDateController,
                  datePickerOption: DatePickerOption.endDate,
                  firstDate:
                      companyEmployeeManageScreenController.employmentStartDate,
                );
              },
              validate: (value) => FieldValidation().validateEndDayWork(value),
            ),

            const SizedBox(height: 5),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  maxLines: null,
                  text: TextSpan(
                      text: AppMessage.isActive,
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
                        color: Colors.white, borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: companyEmployeeManageScreenController
                              .selectedValue.value,
                          items: companyEmployeeManageScreenController
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
                            companyEmployeeManageScreenController.isLoading(true);
                            companyEmployeeManageScreenController
                                .selectedValue.value = value!;
                            log('value : $value');
                            // companyEmployeeManageScreenController.loadUI();

                            companyEmployeeManageScreenController
                                .isLoading(false);
                          },
                        ).commonOnlyPadding(left: 10, right: 10),
                      ),
                    ),
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
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: AppColors.greyColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: companyEmployeeManageScreenController
                          .companyDDSelectedStringItem,
                      items: [companyEmployeeManageScreenController.companyName]
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
                        companyEmployeeManageScreenController
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
                    value: companyEmployeeManageScreenController.companyDDSelectedItem,
                    items: companyEmployeeManageScreenController.allCompanyList
                        .map<DropdownMenuItem<CompanyData>>(
                            (CompanyData value) {
                      return DropdownMenuItem<CompanyData>(
                        value: value,
                        child: Text(value.userName),
                      );
                    }).toList(),
                    onChanged: (CompanyData? value) async {
                      // This is called when the user selects an item.
                      // companyEmployeeManageScreenController.isloding(true);
                      companyEmployeeManageScreenController.companyDDSelectedItem =
                          value;

                      int companyid = companyEmployeeManageScreenController
                          .companyDDSelectedItem!.id;

                      log('companyid : $companyid');
                      log('valuevaluevaluevalue :${value!.userName}');

                      await companyEmployeeManageScreenController
                          .getCompanyDepartmentFunction(companyid.toString());

                      log(companyEmployeeManageScreenController
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
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: AppColors.greyColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<CompanyDepartmentData>(
                          value: companyEmployeeManageScreenController
                              .companyDepartmentData,
                          items: companyEmployeeManageScreenController
                              .companyDepartment
                              .map<DropdownMenuItem<CompanyDepartmentData>>(
                                  (CompanyDepartmentData value) {
                            return DropdownMenuItem<CompanyDepartmentData>(
                              value: value,
                              child: Text(value.departmentName),
                            );
                          }).toList(),
                          borderRadius: BorderRadius.circular(10),
                          icon: Image.asset(
                            AppImages.arrowDownIcon,
                            height: 15,
                            width: 15,
                          ).commonSymmetricPadding(horizontal: 10),
                          onChanged: (CompanyDepartmentData? value) async {
                            companyEmployeeManageScreenController.isLoading(true);
                            // This is called when the user selects an item.
                            companyEmployeeManageScreenController
                                .companyDepartmentData = value;
                            companyEmployeeManageScreenController
                                .isLoading(false);
                          },
                        ).commonOnlyPadding(left: 10, right: 10),
                      ),
                    ),
                  ),
                ),

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
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: AppColors.greyColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value:
                          companyEmployeeManageScreenController.locationListData,
                      items: companyEmployeeManageScreenController.allLocationList
                          .map<DropdownMenuItem<LocationListData>>(
                              (LocationListData value) {
                        return DropdownMenuItem<LocationListData>(
                            value: value, child: Text(value.locationName));
                      }).toList(),
                      borderRadius: BorderRadius.circular(10),
                      icon: Image.asset(
                        AppImages.arrowDownIcon,
                        height: 15,
                        width: 15,
                      ).commonSymmetricPadding(horizontal: 10),
                      onChanged: (LocationListData? value) async {
                        companyEmployeeManageScreenController.isLoading(true);
                        companyEmployeeManageScreenController.locationListData =
                            value;
                        companyEmployeeManageScreenController.isLoading(false);
                      },
                    ).commonOnlyPadding(left: 10, right: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.employeeEmail,
              text: AppMessage.employeeEmail,
              keyboardType: TextInputType.emailAddress,
              mandatoryText: AppMessage.mandatory,
              readOnly: companyEmployeeManageScreenController.employeeOption ==
                      EmployeeOption.update
                  ? true
                  : false,
              textEditingController:
                  companyEmployeeManageScreenController.emailController,
              validate: (value) => FieldValidation().validateEmail(value),
            ),
            const SizedBox(height: 5),

            companyEmployeeManageScreenController.employeeOption ==
                    EmployeeOption.update
                ? Container()
                : Obx(
                    () => FormSingleFieldModule(
                      obscureText: companyEmployeeManageScreenController
                          .isPasswordVisible.value,
                      // obscureText:,
                      headerText: AppMessage.password,
                      text: AppMessage.password,
                      mandatoryText: AppMessage.mandatory,
                      keyboardType: TextInputType.visiblePassword,
                      // maxLength: 10,
                      textEditingController:
                          companyEmployeeManageScreenController
                              .passwordController,

                      suffixIcon: companyEmployeeManageScreenController
                              .isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onPressed: () {
                        companyEmployeeManageScreenController
                                .isPasswordVisible.value =
                            !companyEmployeeManageScreenController
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
                  companyEmployeeManageScreenController.streetAddressController,
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
              textEditingController: companyEmployeeManageScreenController
                  .landmarkAddressController,
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
                    textEditingController: companyEmployeeManageScreenController
                        .cityAddressController,
                    // validate: (value) =>
                    //     FieldValidation().validateCurrentAddress(value),
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
                    textEditingController: companyEmployeeManageScreenController
                        .stateAddressController,
                    // validate: (value) =>
                    //     FieldValidation().validateCurrentAddress(value),
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
              textEditingController: companyEmployeeManageScreenController
                  .zipcodeAddressController,
              // validate: (value) =>
              //     FieldValidation().validateCurrentAddress(value),
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
                    if (companyEmployeeManageScreenController
                            .employeeSelectedDocumentList.length <=
                        5) {
                      await companyEmployeeManageScreenController
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

            /*companyEmployeeManageScreenController
                    .employeeSelectedDocumentList.isNotEmpty
                ? ListView.builder(
                    itemCount: companyEmployeeManageScreenController
                        .employeeSelectedDocumentList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      String fileName = "";
                      List<String> tempStringList =
                          companyEmployeeManageScreenController
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
                                companyEmployeeManageScreenController
                                    .isLoading(true);
                                companyEmployeeManageScreenController
                                    .employeeSelectedDocumentList
                                    .removeAt(i);
                                companyEmployeeManageScreenController
                                    .isLoading(false);
                                log('Length : ${companyEmployeeManageScreenController.employeeSelectedDocumentList}');
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
                      if (companyEmployeeManageScreenController
                          .formKey.currentState!
                          .validate()) {
                        if (companyEmployeeManageScreenController
                                .employeeOption ==
                            EmployeeOption.create) {
                          // if (companyEmployeeManageScreenController.images != null) {
                          if (companyEmployeeManageScreenController
                                  .companyDepartmentData!.departmentName ==
                              AppMessage.empty) {
                            Fluttertoast.showToast(
                                msg: AppMessage.pleaseSelectDepartment);
                          } else if (companyEmployeeManageScreenController
                                  .selectedValuePayper.value ==
                              AppMessage.chooseOption) {
                            Fluttertoast.showToast(
                                msg: AppMessage.pleaseSelectPayper);
                          } else {
                            await companyEmployeeManageScreenController
                                .employeeCreateFunction();
                          }
                          // } else {
                          //   Fluttertoast.showToast(
                          //       msg: "Please select profile image!");
                          // }
                        } else {
                          log("updateEmployeeDetailsFunction");
                          if (companyEmployeeManageScreenController
                                  .companyDepartmentData!.departmentName ==
                              AppMessage.empty) {
                            Fluttertoast.showToast(
                                msg: AppMessage.pleaseSelectDepartment);
                          } else if (companyEmployeeManageScreenController
                                  .selectedValuePayper.value ==
                              AppMessage.chooseOption) {
                            Fluttertoast.showToast(
                                msg: AppMessage.pleaseSelectPayper);
                          } else {
                            await companyEmployeeManageScreenController
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
                if (companyEmployeeManageScreenController
                    .formKey.currentState!
                    .validate()) {
                  if (companyEmployeeManageScreenController
                      .employeeOption ==
                      EmployeeOption.create) {
                    // if (companyEmployeeManageScreenController.images != null) {
                    if (companyEmployeeManageScreenController
                        .companyDepartmentData!.departmentName ==
                        AppMessage.empty) {
                      Fluttertoast.showToast(
                          msg: AppMessage.pleaseSelectDepartment);
                    } else if (companyEmployeeManageScreenController
                        .selectedValuePayper.value ==
                        AppMessage.chooseOption) {
                      Fluttertoast.showToast(
                          msg: AppMessage.pleaseSelectPayper);
                    } else {
                      await companyEmployeeManageScreenController
                          .employeeCreateFunction();
                    }
                    // } else {
                    //   Fluttertoast.showToast(
                    //       msg: "Please select profile image!");
                    // }
                  } else {
                    log("updateEmployeeDetailsFunction");
                    if (companyEmployeeManageScreenController
                        .companyDepartmentData!.departmentName ==
                        AppMessage.empty) {
                      Fluttertoast.showToast(
                          msg: AppMessage.pleaseSelectDepartment);
                    } else if (companyEmployeeManageScreenController
                        .selectedValuePayper.value ==
                        AppMessage.chooseOption) {
                      Fluttertoast.showToast(
                          msg: AppMessage.pleaseSelectPayper);
                    } else {
                      await companyEmployeeManageScreenController
                          .updateEmployeeDetailsFunction();
                    }
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
      companyEmployeeManageScreenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      // dateTime = d;
      if (datePickerOption == DatePickerOption.dob) {
        companyEmployeeManageScreenController.birthDate = d;
      } else if (datePickerOption == DatePickerOption.startDate) {
        companyEmployeeManageScreenController.employmentStartDate = d;
      } else {
        companyEmployeeManageScreenController.employmentEndDate = d;
      }
      companyEmployeeManageScreenController.isLoading(false);
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

// class ImagePickerCustom extends StatelessWidget {
//   ImagePickerCustom({super.key});
//   final companyEmployeeManageScreenController =
//       Get.find<CompanyEmployeeManageScreenController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => companyEmployeeManageScreenController.isLoading.value == true
//           ? const CircularProgressIndicator()
//           : Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     companyEmployeeManageScreenController.showPicker(context);
//                   },
//                   child: ClipOval(
//                     child: Stack(
//                       children: [
//                         Container(
//                           height: 100,
//                           width: 100,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.grey,
//                           ),
//                           child: companyEmployeeManageScreenController
//                                       .employeeOption ==
//                                   EmployeeOption.create
//                               ? companyEmployeeManageScreenController.images !=
//                                       null
//                                   ? Image.file(
//                                       companyEmployeeManageScreenController
//                                           .images!,
//                                       fit: BoxFit.fill,
//                                     )
//                                   : const Icon(
//                                       Icons.camera_alt_outlined,
//                                     )
//                               : companyEmployeeManageScreenController.images !=
//                                       null
//                                   ? Image.file(
//                                       companyEmployeeManageScreenController
//                                           .images!,
//                                       fit: BoxFit.fill,
//                                     )
//                                   : companyEmployeeManageScreenController
//                                               .oldImageName !=
//                                           AppMessage.empty
//                                       ? Image.network(
//                                           "${ApiUrl.apiImagePath}${companyEmployeeManageScreenController.oldImageName}",
//                                           fit: BoxFit.fill,
//                                         )
//                                       : const Icon(
//                                           Icons.camera_alt_outlined,
//                                         ),
//                         ),
//                         companyEmployeeManageScreenController.employeeOption ==
//                                 EmployeeOption.update
//                             ? Positioned(
//                                 top: 70,
//                                 right: 8,
//                                 child: Container(
//                                   height: 28,
//                                   width: 28,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: Colors.white,
//                                   ),
//                                   child: Icon(
//                                     Icons.edit,
//                                     size: 15.sp,
//                                   ),
//                                 ),
//                               )
//                             : Container(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
