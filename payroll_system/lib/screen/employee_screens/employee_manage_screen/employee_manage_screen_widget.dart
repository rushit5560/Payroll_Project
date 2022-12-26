import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/Utils/validator.dart';
import 'package:payroll_system/constants/anums.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/employee_manage_screen_controller.dart';
import 'package:payroll_system/models/company_list_screen_model/get_all_company_model.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/custom_alert_dialog_module.dart';
import '../../../common_modules/form_single_field_module.dart';

// ignore: must_be_immutable
class EmployeeManageScreenWidgets extends StatelessWidget {
  EmployeeManageScreenWidgets({
    super.key,
  });

  @override
  final employeeCreteScreenController =
      Get.find<EmployeManageScreenController>();

  bool isChecked = false;
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: employeeCreteScreenController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                AppMessage.employeeDetails,
                style: TextStyleConfig.textStyle(
                    fontSize: 22.sp, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 2.h),
            ImagePickerCustom(),
            SizedBox(height: 2.h),
            FormSingleFieldModule(
              headerText: AppMessage.firstName,
              text: AppMessage.firstName,
              keyboardType: TextInputType.text,
              textEditingController:
                  employeeCreteScreenController.firstNameController,
              validate: (value) => FieldValidation().validateFirstName(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.middleName,
              text: AppMessage.middleName,
              keyboardType: TextInputType.text,
              textEditingController:
                  employeeCreteScreenController.middleNameController,
              validate: (value) => FieldValidation().validateMiddleName(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.lastName,
              text: AppMessage.lastName,
              keyboardType: TextInputType.text,
              textEditingController:
                  employeeCreteScreenController.lastNameController,
              validate: (value) => FieldValidation().validateLastName(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.phoneNo,
              text: AppMessage.phoneNo,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              textEditingController:
                  employeeCreteScreenController.phoneNoController,
              validate: (value) =>
                  FieldValidation().validateMobileNumber(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.dateOfBrith,
              text: "Select Date",
              keyboardType: TextInputType.datetime,
              maxLength: 10,
              textEditingController:
                  employeeCreteScreenController.dateOfBrithController,
              suffixIcon: Icons.calendar_month,
              onPressed: () {
                DateTime selectedDate =
                    employeeCreteScreenController.selectedDate;
                _selectDate(context, selectedDate,
                    employeeCreteScreenController.dateOfBrithController);

                // employeeCreteScreenController.showDatePicker(context);
              },
              validate: (value) => FieldValidation().validateDateOfBirth(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.homeNo,
              text: AppMessage.homeNo,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              textEditingController:
                  employeeCreteScreenController.homeNoController,
              validate: (value) =>
                  FieldValidation().validateMobileNumber(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.workNO,
              text: AppMessage.workNO,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              textEditingController:
                  employeeCreteScreenController.workNoController,
              validate: (value) =>
                  FieldValidation().validateMobileNumber(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.hourlyRate,
              text: AppMessage.hourlyRate,
              keyboardType: TextInputType.number,
              textEditingController:
                  employeeCreteScreenController.hourlyRateController,
              validate: (value) => FieldValidation().validateHourlyRate(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.salary,
              text: AppMessage.salary,
              keyboardType: TextInputType.number,
              textEditingController:
                  employeeCreteScreenController.salaryController,
              validate: (value) => FieldValidation().validateSalary(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.startDate,
              text: "Select First Date",
              keyboardType: TextInputType.datetime,
              textEditingController:
                  employeeCreteScreenController.startDateController,
              suffixIcon: Icons.calendar_month,
              onPressed: () {
                DateTime selectedFirstDate =
                    employeeCreteScreenController.selectedDate;
                _selectDate(context, selectedFirstDate,
                    employeeCreteScreenController.startDateController);
              },
              validate: (value) =>
                  FieldValidation().validateStartDayWork(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.lastDay,
              text: "Select Last Date",
              keyboardType: TextInputType.datetime,
              textEditingController:
                  employeeCreteScreenController.lastDateController,
              suffixIcon: Icons.calendar_month,
              onPressed: () {
                DateTime selectedLastDate =
                    employeeCreteScreenController.selectedDate;
                _selectDate(context, selectedLastDate,
                    employeeCreteScreenController.lastDateController);
              },
              validate: (value) => FieldValidation().validateLastDayWork(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.isActive,
              text: AppMessage.isActive,
              // keyboardType: TextInputType.number,
              textEditingController:
                  employeeCreteScreenController.isActiveController,
              validate: (value) => FieldValidation().validateLastDayWork(value),
            ),
            const SizedBox(height: 5),
            Text(
              AppMessage.company,
              style: TextStyleConfig.textStyle(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ).commonSymmetricPadding(vertical: 2),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.greyColor),
              ),
              child: Padding(
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
                    onChanged: (CompanyData? value) {
                      // This is called when the user selects an item.
                      employeeCreteScreenController.companyDDSelectedItem =
                          value!;

                      employeeCreteScreenController.loadUI();
                      log(employeeCreteScreenController
                          .companyDDSelectedItem!.id
                          .toString());
                    },
                  ).commonOnlyPadding(left: 10, right: 10),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppMessage.departmentNameDrawer,
                  style: TextStyleConfig.textStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ).commonSymmetricPadding(vertical: 2),
                DropDownMultiSelect(
                  options: employeeCreteScreenController.departmentStringList,
                  whenEmpty: 'Choose Department',
                  onChanged: (value) {
                    employeeCreteScreenController.selectedDepartmentList.value =
                        value;
                    employeeCreteScreenController
                        .selectedDepartmentOption.value = "";
                    employeeCreteScreenController.selectedDepartmentIdList = [];

                    // Selected Department generate new id list for send in api
                    for (int i = 0; i < value.length; i++) {
                      for (int j = 0;
                          j <
                              employeeCreteScreenController
                                  .departmentList.length;
                          j++) {
                        if (value[i] ==
                            employeeCreteScreenController
                                .departmentList[j].departmentName) {
                          employeeCreteScreenController.selectedDepartmentIdList
                              .add(employeeCreteScreenController
                                  .departmentList[j].id
                                  .toString());
                        }
                      }
                    }

                    // log('screenController.selectedDepartmentIdList :${screenController.selectedDepartmentIdList}');
                  },
                  selectedValues: employeeCreteScreenController
                      .selectedDepartmentList.value,
                ),
              ],
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.employeeEmail,
              text: AppMessage.employeeEmail,
              keyboardType: TextInputType.emailAddress,
              textEditingController:
                  employeeCreteScreenController.emailController,
              validate: (value) => FieldValidation().validateEmail(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.password,
              text: AppMessage.password,
              keyboardType: TextInputType.visiblePassword,
              // maxLength: 10,
              textEditingController:
                  employeeCreteScreenController.passwordController,
              suffixIcon: _isHidden ? Icons.visibility_off : Icons.visibility,
              onPressed: () {
                _isHidden = !_isHidden;
              },
              validate: (value) => FieldValidation().validatePassword(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.employeeCurrentAddress,
              text: AppMessage.employeeCurrentAddress,
              keyboardType: TextInputType.text,
              textEditingController:
                  employeeCreteScreenController.currentAddressController,
              validate: (value) =>
                  FieldValidation().validateCurrentAddress(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.employeeHomeAddress,
              text: AppMessage.employeeHomeAddress,
              keyboardType: TextInputType.text,
              textEditingController:
                  employeeCreteScreenController.homeAddressController,
              validate: (value) => FieldValidation().validateHomeAddress(value),
            ),
            const SizedBox(height: 15),
            Center(
              child: ButtonCustom(
                onPressed: () async {
                  if (employeeCreteScreenController.formKey.currentState!
                      .validate()) {
                    if (employeeCreteScreenController.images == null) {
                      Fluttertoast.showToast(
                          msg: "Please select employee image");
                    } else {
                      await employeeCreteScreenController
                          .employeeStoreFunction();
                    }
                  }
                },
                text: "Submit",
                textsize: 15.sp,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ButtonCustom(
                    onPressed: () async {
                      if (employeeCreteScreenController.employeeOption ==
                          EmployeeOption.create) {
                        if (employeeCreteScreenController
                            .allCompanyList.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please select department");
                        } else if (employeeCreteScreenController
                            .allCompanyList.isNotEmpty) {
                          await employeeCreteScreenController
                              .employeeStoreFunction();
                        }
                      } else {
                        if (employeeCreteScreenController
                            .allCompanyList.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please select department");
                        } else if (employeeCreteScreenController
                            .allCompanyList.isNotEmpty) {
                          // await employeeCreteScreenController.updateCompanyDetailsFunction();
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
          ],
        ).commonOnlyPadding(top: 6.h, right: 6.w, left: 6.w, bottom: 4.h),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, DateTime dateTime,
      TextEditingController textEditingController) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (d != null) {
      employeeCreteScreenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      employeeCreteScreenController.isLoading(false);

      //setState(() {
      // screenController.selectedDate = DateFormat.yMd("en_US").format(d);
      // log(screenController.selectedDate.value);
      //});
    }
  }

  companyNameFunction() {
    Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppMessage.company,
              style: TextStyleConfig.textStyle(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ).commonSymmetricPadding(vertical: 2),
          ],
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(),
          ),
          child: Text("sd"
              // employeeCreteScreenController.allCompanyList[index].userName,

              ),
        ),
      ],
    );
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
  final employeDetailsFormController =
      Get.find<EmployeManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => employeDetailsFormController.isloding == true
          ? const CircularProgressIndicator()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    employeDetailsFormController.showPicker(context);

                    // _showPicker();
                  },
                  child: ClipOval(
                    child: Container(
                      height: 15.h,
                      width: 15.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: employeDetailsFormController.images != null
                          ? Image.file(
                              employeDetailsFormController.images!,
                              fit: BoxFit.fill,
                            )
                          : const Icon(
                              Icons.camera_alt_outlined,
                            ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
