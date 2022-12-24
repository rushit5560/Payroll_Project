import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/Utils/validator.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/form_single_field_module.dart';
import '../../../controller/employee_manage_screen_controller.dart';

// ignore: must_be_immutable
class EmployeeDetailsScreenWidgets extends StatelessWidget {
  EmployeeDetailsScreenWidgets({super.key});

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
          Text(
            AppMessage.employeeDetails,
            style: TextStyleConfig.textStyle(
                fontSize: 22.sp, fontWeight: FontWeight.w400),
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
            validate: (value) => FieldValidation().validateMobileNumber(value),
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
            validate: (value) => FieldValidation().validateMobileNumber(value),
          ),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.workNO,
            text: AppMessage.workNO,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            textEditingController:
                employeeCreteScreenController.workNoController,
            validate: (value) => FieldValidation().validateMobileNumber(value),
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
            validate: (value) => FieldValidation().validateStartDayWork(value),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppMessage.companyNameDrawer,
                style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.w600, fontSize: 16),
              ).commonSymmetricPadding(vertical: 2),
              DropDownMultiSelect(
                options: employeeCreteScreenController.departmentStringList,
                whenEmpty: 'Choose Company',
                onChanged: (value) {
                  employeeCreteScreenController.selectedDepartmentList.value =
                      value;
                  employeeCreteScreenController.selectedDepartmentOption.value =
                      "";
                  employeeCreteScreenController.selectedDepartmentIdList = [];

                  // Selected Department generate new id list for send in api
                  for (int i = 0; i < value.length; i++) {
                    for (int j = 0;
                        j < employeeCreteScreenController.departmentList.length;
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
                selectedValues:
                    employeeCreteScreenController.selectedDepartmentList.value,
              ),
            ],
          ),
          FormSingleFieldModule(
            headerText: AppMessage.company,
            text: AppMessage.company,
            // keyboardType: TextInputType.number,
            textEditingController:
                employeeCreteScreenController.companyController,
            validate: (value) => FieldValidation().validateCompanyName(value),
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
                  employeeCreteScreenController.selectedDepartmentOption.value =
                      "";
                  employeeCreteScreenController.selectedDepartmentIdList = [];

                  // Selected Department generate new id list for send in api
                  for (int i = 0; i < value.length; i++) {
                    for (int j = 0;
                        j < employeeCreteScreenController.departmentList.length;
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
                selectedValues:
                    employeeCreteScreenController.selectedDepartmentList.value,
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
                    Fluttertoast.showToast(msg: "Please select employee image");
                  } else {
                    await employeeCreteScreenController.employeeStoreFunction();
                  }
                }
              },
              text: "Submit",
              textsize: 15.sp,
            ),
          ),
        ],
      ).commonOnlyPadding(
        top: 6.h,
        right: 6.w,
        left: 6.w,
        bottom: 4.h,
      ),
    ));
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
