import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/Utils/validator.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/employee_manage_screen_controller.dart';
import 'package:payroll_system/models/company_department_model/company_department_model.dart';
import 'package:payroll_system/models/company_list_screen_model/get_all_company_model.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/form_single_field_module.dart';

// ignore: must_be_immutable
class EmployeeManageScreenWidgets extends StatelessWidget {
  EmployeeManageScreenWidgets({
    super.key,
  });

  final employeeCreteScreenController =
      Get.find<EmployeManageScreenController>();

  bool isChecked = false;
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
                // DateTime selectedDate =
                //     employeeCreteScreenController.selectedDate;
                _selectDate(
                    context,
                    employeeCreteScreenController.birthDate,
                    employeeCreteScreenController.dateOfBrithController,
                    DatePickerOption.dob);
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
                // DateTime selectedFirstDate =
                //     employeeCreteScreenController.selectedDate;
                _selectDate(
                    context,
                    employeeCreteScreenController.startDate,
                    employeeCreteScreenController.startDateController,
                    DatePickerOption.startDate);
              },
              validate: (value) =>
                  FieldValidation().validateStartDayWork(value),
            ),
            const SizedBox(height: 5),

            FormSingleFieldModule(
              headerText: AppMessage.lastDay,
              text: AppMessage.lastDay,
              keyboardType: TextInputType.number,
              textEditingController:
                  employeeCreteScreenController.lastDateController,
              validate: (value) => FieldValidation().validateLastDayWork(value),
            ),
            // FormSingleFieldModule(
            //   headerText: AppMessage.lastDay,
            //   text: "Select Last Date",
            //   keyboardType: TextInputType.datetime,
            //   textEditingController:
            //       employeeCreteScreenController.lastDateController,
            //   suffixIcon: Icons.calendar_month,
            //   onPressed: () {
            //     DateTime selectedLastDate =
            //         employeeCreteScreenController.selectedDate;
            //     _selectDate(context, selectedLastDate,
            //         employeeCreteScreenController.lastDateController);
            //   },
            //   validate: (value) => FieldValidation().validateLastDayWork(value),
            // ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppMessage.isActive,
                  style: TextStyleConfig.textStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ).commonSymmetricPadding(vertical: 2),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.greyColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value:
                            employeeCreteScreenController.selectedValue.value,
                        items: employeeCreteScreenController.isActiveOptionList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          employeeCreteScreenController.isLoading(true);
                          employeeCreteScreenController.selectedValue.value =
                              value!;
                          log('value : $value');
                          // employeeCreteScreenController.loadUI();

                          employeeCreteScreenController.isLoading(false);
                        },
                      ).commonOnlyPadding(left: 10, right: 10),
                    ),
                  ),
                ),
              ],
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
                          .getCompanyDepartmentFunction(companyid);

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
                      child: DropdownButton<CompanyDepartmentData>(
                        value:
                            employeeCreteScreenController.companyDepartmentData,
                        items: employeeCreteScreenController.companyDepartment
                            .map<DropdownMenuItem<CompanyDepartmentData>>(
                                (CompanyDepartmentData value) {
                          return DropdownMenuItem<CompanyDepartmentData>(
                            value: value,
                            child: Text(value.departmentName),
                          );
                        }).toList(),
                        onChanged: (CompanyDepartmentData? value) async {
                          // This is called when the user selects an item.
                          log('valuevaluevaluevalue :${value!.departmentName}');
                          // employeeCreteScreenController.isloding(true);
                          employeeCreteScreenController.companyDepartmentData =
                              value;
                        },
                      ).commonOnlyPadding(left: 10, right: 10),
                    ),
                  ),
                ),
                // DropDownMultiSelect(
                //   options: employeeCreteScreenController.departmentStringList,
                //   whenEmpty: 'Choose Department',
                //   onChanged: (value) {
                //     employeeCreteScreenController.selectedDepartmentList.value =
                //         value;
                //     employeeCreteScreenController
                //         .selectedDepartmentOption.value = "";
                //     employeeCreteScreenController.selectedDepartmentIdList = [];

                //     // Selected Department generate new id list for send in api
                //     for (int i = 0; i < value.length; i++) {
                //       for (int j = 0;
                //           j <
                //               employeeCreteScreenController
                //                   .companyDepartment.length;
                //           j++) {
                //         if (value[i] ==
                //             employeeCreteScreenController
                //                 .companyDepartment[j].departmentName) {
                //           employeeCreteScreenController.selectedDepartmentIdList
                //               .add(employeeCreteScreenController
                //                   .companyDepartment[j].id
                //                   .toString());
                //         }
                //       }
                //     }
                //   },
                //   selectedValues: employeeCreteScreenController
                //       .selectedDepartmentList.value,
                // ),
              ],
            ),
            const SizedBox(height: 5),

            employeeCreteScreenController.employeeOption ==
                    EmployeeOption.update
                ? FormSingleFieldModule(
                    headerText: AppMessage.employeeEmail,
                    text: AppMessage.employeeEmail,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: true,
                    textEditingController:
                        employeeCreteScreenController.emailController,
                    validate: (value) => FieldValidation().validateEmail(value),
                  )
                : FormSingleFieldModule(
                    headerText: AppMessage.employeeEmail,
                    text: AppMessage.employeeEmail,
                    keyboardType: TextInputType.emailAddress,
                    textEditingController:
                        employeeCreteScreenController.emailController,
                    validate: (value) => FieldValidation().validateEmail(value),
                  ),
            const SizedBox(height: 5),

            employeeCreteScreenController.employeeOption ==
                    EmployeeOption.update
                ? Container()
                : FormSingleFieldModule(
                    obscureText:
                        employeeCreteScreenController.isPasswordVisible.value,
                    // obscureText:,
                    headerText: AppMessage.password,
                    text: AppMessage.password,
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
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ButtonCustom(



                    
                    onPressed: () async {
                      if (employeeCreteScreenController.formKey.currentState!
                          .validate()) {
                        if (employeeCreteScreenController.employeeOption ==
                            EmployeeOption.create) {
                          if (employeeCreteScreenController.images != null) {
                            if (employeeCreteScreenController
                                .companyDepartment.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please select department");
                            } else if (employeeCreteScreenController
                                .companyDepartment.isNotEmpty) {
                              await employeeCreteScreenController
                                  .employeeCreateFunction();
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please select profile image!");
                          }
                        } else {
                          log("updateEmployeeDetailsFunction");
                          await employeeCreteScreenController
                              .updateEmployeeDetailsFunction();
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

  Future<void> _selectDate(
      BuildContext context,
      DateTime dateTime,
      TextEditingController textEditingController,
      DatePickerOption datePickerOption) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (d != null) {
      employeeCreteScreenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      // dateTime = d;
      if (datePickerOption == DatePickerOption.dob) {
        employeeCreteScreenController.birthDate = d;
      } else {
        employeeCreteScreenController.startDate = d;
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
      Get.find<EmployeManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => employeeCreteScreenController.isloding == true
          ? const CircularProgressIndicator()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    employeeCreteScreenController.showPicker(context);

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
                      child: employeeCreteScreenController.images != null
                          ? Image.file(
                              employeeCreteScreenController.images!,
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
