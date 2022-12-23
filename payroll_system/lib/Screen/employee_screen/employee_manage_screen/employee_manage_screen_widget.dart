import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controller/employee_details_screen_controller.dart';
import 'package:payroll_system/Screen/authentication/Login_Screen/login_screen.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/Utils/validator.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/form_single_field_module.dart';

// ignore: must_be_immutable
class EmployeeDetailsScreenWidgets extends StatelessWidget {
  EmployeeDetailsScreenWidgets({super.key});

  @override
  final employeCreateFormController =
      Get.find<EmployeDetailsScreenController>();

  bool isChecked = false;
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: employeCreateFormController.formKey,
      child: Column(
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
            textEditingController: employeCreateFormController.FirstName,
            validate: (value) => FieldValidation().validateFirstName(value),
          ),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.middleName,
            text: AppMessage.middleName,
            keyboardType: TextInputType.text,
            textEditingController: employeCreateFormController.middleName,
            validate: (value) => FieldValidation().validateMiddleName(value),
          ),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.lastName,
            text: AppMessage.lastName,
            keyboardType: TextInputType.text,
            textEditingController: employeCreateFormController.lastName,
            validate: (value) => FieldValidation().validateLastName(value),
          ),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.phoneNo,
            text: AppMessage.phoneNo,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            textEditingController: employeCreateFormController.phoneNo,
            validate: (value) => FieldValidation().validateMobileNumber(value),
          ),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.dateOfBrith,
            text: AppMessage.dateOfBrith,
            keyboardType: TextInputType.datetime,
            maxLength: 10,
            textEditingController: employeCreateFormController.dateOfBrith,
            suffixIcon: Icons.calendar_month,
            onPressed: () {
              employeCreateFormController.showDatePicker(context);
            },
            validate: (value) => FieldValidation().validateDateOfBirth(value),
          ),
          // DateOfBrithFiledCustom(),
          const SizedBox(height: 5),

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       AppMessage.departmentNameDrawer,
          //       style: TextStyleConfig.textStyle(
          //           fontWeight: FontWeight.w600, fontSize: 16),
          //     ).commonSymmetricPadding(vertical: 2),

          // DropDownMultiSelect(
          //   options: employeCreateFormController.departmentStringList,
          //   whenEmpty: 'Choose Department',
          //   onChanged: (value) {
          //     employeCreateFormController.selectedEmployeeList.value = value;
          //     employeCreateFormController.selectedDepartmentOption.value = "";
          //     employeCreateFormController.selectedDepartmentIdList = [];

          //     // Selected Department generate new id list for send in api
          //     for(int i=0; i < value.length; i++) {
          //       for(int j=0; j < employeCreateFormController.departmentList.length; j++) {
          //         if(value[i] == employeCreateFormController.departmentList[j].departmentName) {
          //           employeCreateFormController.selectedDepartmentIdList.add(employeCreateFormController.departmentList[j].id.toString());
          //         }
          //       }
          //     }

          //     log('screenController.selectedDepartmentIdList :${employeCreateFormController.selectedDepartmentIdList}');

          //   },
          //   selectedValues: employeCreateFormController.selectedDepartmentList.value,
          // ),
          // ],
          // ),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.homeNo,
            text: AppMessage.homeNo,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            textEditingController: employeCreateFormController.homeNo,
            validate: (value) => FieldValidation().validateMobileNumber(value),
          ),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.workNO,
            text: AppMessage.workNO,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            textEditingController: employeCreateFormController.homeNo,
            validate: (value) => FieldValidation().validateMobileNumber(value),
          ),

          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.hourlyRate,
            text: AppMessage.hourlyRate,
            keyboardType: TextInputType.number,
            textEditingController: employeCreateFormController.homeNo,
            validate: (value) => FieldValidation().validateHourlyRate(value),
          ),

          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.salary,
            text: AppMessage.salary,
            keyboardType: TextInputType.number,
            textEditingController: employeCreateFormController.salary,
            validate: (value) => FieldValidation().validateSalary(value),
          ),

          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.startDate,
            text: AppMessage.startDate,
            // keyboardType: TextInputType.number,
            textEditingController: employeCreateFormController.startDate,
            validate: (value) => FieldValidation().validateStartDayWork(value),
          ),

          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.lastDay,
            text: AppMessage.lastDay,
            // keyboardType: TextInputType.number,
            textEditingController: employeCreateFormController.lastDate,
            validate: (value) => FieldValidation().validateLastDayWork(value),
          ),

          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.isActive,
            text: AppMessage.isActive,
            // keyboardType: TextInputType.number,
            textEditingController: employeCreateFormController.isActive,
            // validate: (value) => FieldValidation().validateLastDayWork(value),
          ),

          const SizedBox(height: 5),

          FormSingleFieldModule(
            headerText: AppMessage.company,
            text: AppMessage.company,
            // keyboardType: TextInputType.number,
            textEditingController: employeCreateFormController.company,
            validate: (value) => FieldValidation().validateCompanyName(value),
          ),

          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.employeeEmail,
            text: AppMessage.employeeEmail,
            // keyboardType: TextInputType.number,
            textEditingController: employeCreateFormController.email,
            validate: (value) => FieldValidation().validateEmail(value),
          ),

          const SizedBox(height: 5),

          FormSingleFieldModule(
            headerText: AppMessage.password,
            text: AppMessage.password,
            keyboardType: TextInputType.visiblePassword,
            // maxLength: 10,
            textEditingController: employeCreateFormController.password,
            suffixIcon: _isHidden ? Icons.calendar_month : Icons.visibility,
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
            textEditingController: employeCreateFormController.CurrentAddress,
            validate: (value) =>
                FieldValidation().validateCurrentAddress(value),
          ),
          const SizedBox(height: 5),
          FormSingleFieldModule(
            headerText: AppMessage.employeeHomeAddress,
            text: AppMessage.employeeHomeAddress,
            keyboardType: TextInputType.text,
            textEditingController: employeCreateFormController.homeAddress,
            validate: (value) => FieldValidation().validateHomeAddress(value),
          ),

          ButtonCustom(
            onPressed: () {
              if (employeCreateFormController.formKey.currentState!
                  .validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }
            },
            text: "Submit",
            textsize: 15.sp,
          ),
        ],
      ).commonOnlyPadding(
        top: 6.h,
        right: 6.w,
        left: 6.w,
        bottom: 2.h,
      ),
    ));
  }
}

// ignore: must_be_immutable
class EmployeDetailsTextFormFieldCustom extends StatelessWidget {
  final String text;
  // IconData prefixIcon;
  IconData? suffixIcon;
  final FormFieldValidator? validate;
  TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  Color color;
  Function()? onTap;
  Size? size;
  TextInputType? keyboardType;
  bool readOnly;

  //  double fontSize = 15.0,
  EmployeDetailsTextFormFieldCustom(
      {Key? key,
      required this.text,
      // required this.prefixIcon,
      this.inputFormatters,
      this.suffixIcon,
      this.color = Colors.grey,
      this.size,
      this.textEditingController,
      this.onTap,
      this.keyboardType,
      this.validate,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: keyboardType,
      controller: textEditingController,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        // prefixIcon: Icon(prefixIcon, color: color),

        hintText: text,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}

class DateOfBrithFiledCustom extends StatelessWidget {
  DateOfBrithFiledCustom({super.key});

  final employeDetailsFormController =
      Get.find<EmployeDetailsScreenController>();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: employeDetailsFormController.dateOfBrith,
      // enabled: false,
      decoration: InputDecoration(
        hintText: AppMessage.dateOfBrith,
        labelText: AppMessage.dateOfBrith,
        suffixIcon: IconButton(
          onPressed: () {
            employeDetailsFormController.showDatePicker(context);
          },
          icon: const Icon(Icons.calendar_month),
        ),
        // hintText: AppMessage.dateOfBrith,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
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
      Get.find<EmployeDetailsScreenController>();

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
