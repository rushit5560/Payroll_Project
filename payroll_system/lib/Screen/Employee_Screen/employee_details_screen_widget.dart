import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Controller/employee_details_screen_controller.dart';
import 'package:payroll_system/Screen/Authentication/Login_Screen/login_screen.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/Utils/validator.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class EmployeeDetailsScreenWidgets extends StatelessWidget {
  EmployeeDetailsScreenWidgets({super.key});

  @override
  final employeDetailsFormController =
      Get.find<EmployeDetailsScreenController>();

  bool isChecked = false;
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: employeDetailsFormController.formKey,
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
          EmployeDetailsTextFormFieldCustom(
              // textEditingController: employeDetailsFormController.FirstName,
              validate: (value) => FieldValidation().validateFirstName(value),
              text: AppMessage.firstName,
              keyboardType: TextInputType.text),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
              // textEditingController: employeDetailsFormController.LastName,
              validate: (value) => FieldValidation().validateMiddleName(value),
              text: AppMessage.middleName,
              keyboardType: TextInputType.text),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
              // textEditingController: employeDetailsFormController.LastName,
              validate: (value) => FieldValidation().validateLastName(value),
              text: AppMessage.lastName,
              keyboardType: TextInputType.text),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
              // textEditingController:
              //     employeDetailsFormController.homePhoneNumber,
              validate: (value) =>
                  FieldValidation().validateMobileNumber(value),
              text: AppMessage.phoneNo,
              keyboardType: TextInputType.phone),
          SizedBox(height: 1.h),
          DateOfBrithFiledCustom(),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
              // textEditingController: employeDetailsFormController.address,
              // validate: (value) => FieldValidation().validateAddress(value),
              text: AppMessage.department,
              keyboardType: TextInputType.text),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
              // textEditingController:
              //     employeDetailsFormController.homePhoneNumber,
              validate: (value) =>
                  FieldValidation().validateMobileNumber(value),
              text: AppMessage.homeNo,
              keyboardType: TextInputType.phone),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
              // textEditingController:
              //     employeDetailsFormController.homePhoneNumber,
              validate: (value) =>
                  FieldValidation().validateMobileNumber(value),
              text: AppMessage.workNO,
              keyboardType: TextInputType.phone),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
              // textEditingController: employeDetailsFormController.hourlyRate,
              validate: (value) => FieldValidation().validateHourlyRate(value),
              text: AppMessage.hourlyRate,
              keyboardType: TextInputType.number),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
              // textEditingController: employeDetailsFormController.salary,
              validate: (value) => FieldValidation().validateSalary(value),
              text: AppMessage.salary,
              keyboardType: TextInputType.number),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
            // textEditingController: employeDetailsFormController.firstDateOfWork,
            validate: (value) => FieldValidation().validateStartDayWork(value),
            text: AppMessage.startDate,
          ),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
            // textEditingController: employeDetailsFormController.firstDateOfWork,
            validate: (value) => FieldValidation().validateLastDayWork(value),
            text: AppMessage.lastDay,
          ),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
            // textEditingController: employeDetailsFormController.firstDateOfWork,
            // validate: (value) => FieldValidation().validateLastDayWork(value),
            text: AppMessage.isActive,
          ),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
            // textEditingController: employeDetailsFormController.firstDateOfWork,
            // validate: (value) => FieldValidation().validateLastDayWork(value),
            text: AppMessage.company,
          ),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
              // textEditingController: employeDetailsFormController.email,
              validate: (value) => FieldValidation().validateEmail(value),
              text: AppMessage.employeeEmail,
              keyboardType: TextInputType.emailAddress),
          SizedBox(height: 1.h),
          TextFormField(
            obscureText: _isHidden,
            // validator: (value) => FieldValidation().validatePassword(value!),
            // controller: loginScreenController.loginPasswordController,
            decoration: InputDecoration(
              hintText: AppMessage.employeePassword,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _isHidden = !_isHidden;
                  // setState(() {
                  // });
                },
                icon: Icon(
                  _isHidden ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
              // textEditingController: employeDetailsFormController.address,
              validate: (value) =>
                  FieldValidation().validateCurrentAddress(value),
              text: AppMessage.employeeCurrentAddress,
              keyboardType: TextInputType.text),
          SizedBox(height: 1.h),
          EmployeDetailsTextFormFieldCustom(
              // textEditingController: employeDetailsFormController.address,
              validate: (value) => FieldValidation().validateHomeAddress(value),
              text: AppMessage.employeeHomeAddress,
              keyboardType: TextInputType.text),
          SizedBox(height: 3.h),
          ButtonCustom(
            onPressed: () {
              if (employeDetailsFormController.formKey.currentState!
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
        suffixIcon: IconButton(
          onPressed: () {
            employeDetailsFormController.showDatePicker(context);
          },
          icon: const Icon(Icons.calendar_month),
        ),
        hintText: AppMessage.dateOfBrith,
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
