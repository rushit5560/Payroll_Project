import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payroll_system/Controller/employe_details_form_screen_controller.dart';
import 'package:payroll_system/Screen/Authentication/Login_Screen/login_screen.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/Utils/validator.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:sizer/sizer.dart';

class EmployeDetailsScreenBody extends StatefulWidget {
  EmployeDetailsScreenBody({super.key});

  @override
  State<EmployeDetailsScreenBody> createState() =>
      _EmployeDetailsScreenBodyState();
}

class _EmployeDetailsScreenBodyState extends State<EmployeDetailsScreenBody> {
  final employeDetailsFormController = Get.find<EmployeDetailsFormScreenController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        // ignore: unrelated_type_equality_checks
        () => employeDetailsFormController.isloding == true
            ? const CircularProgressIndicator()
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Employe Details",
                        style: TextStyleConfig.textStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 2.h),
                      ImagePickerCustom(),
                      SizedBox(height: 2.h),
                      EmployeDetailsTextFormFiledCustom(
                          textEditingController:
                              employeDetailsFormController.FirstName,
                          validate: (value) =>
                              FieldValidation().validateName(value),
                          text: "FirstName",
                          keyboardType: TextInputType.text),
                      const SizedBox(height: 10),
                      EmployeDetailsTextFormFiledCustom(
                          textEditingController:
                              employeDetailsFormController.LastName,
                          validate: (value) =>
                              FieldValidation().validateLastName(value),
                          text: "LastName",
                          keyboardType: TextInputType.text),
                      const SizedBox(height: 10),
                      EmployeDetailsTextFormFiledCustom(
                          textEditingController:
                              employeDetailsFormController.address,
                          validate: (value) =>
                              FieldValidation().validateAddress(value),
                          text: "Address",
                          keyboardType: TextInputType.text),
                      const SizedBox(height: 10),
                      EmployeDetailsTextFormFiledCustom(
                          textEditingController:
                              employeDetailsFormController.email,
                          validate: (value) =>
                              FieldValidation().validateEmail(value),
                          text: "Email id",
                          keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 10),
                      EmployeDetailsTextFormFiledCustom(
                          textEditingController:
                              employeDetailsFormController.departmentId,
                          validate: (value) =>
                              FieldValidation().validateDepartmentId(value),
                          text: "Department Id",
                          keyboardType: TextInputType.number),
                      const SizedBox(height: 10),
                      EmployeDetailsTextFormFiledCustom(
                          textEditingController:
                              employeDetailsFormController.companyid,
                          validate: (value) =>
                              FieldValidation().validateCompanyId(value),
                          text: "Companyid"),
                      const SizedBox(height: 10),
                      EmployeDetailsTextFormFiledCustom(
                        textEditingController:
                            employeDetailsFormController.textEditingController,
                        validate: (value) =>
                            FieldValidation().validateDAteOfBirth(value),
                        text: "Date Of Brith",
                        readOnly: true,
                        onTap: () async {
                          employeDetailsFormController.datePicker(context);
                        },
                      ),
                      const SizedBox(height: 10),
                      EmployeDetailsTextFormFiledCustom(
                          textEditingController:
                              employeDetailsFormController.homePhoneNumber,
                          validate: (value) =>
                              FieldValidation().validateHomePhoneNumber(value),
                          text: "HomePhone",
                          keyboardType: TextInputType.phone),
                      const SizedBox(height: 10),
                      EmployeDetailsTextFormFiledCustom(
                          textEditingController:
                              employeDetailsFormController.workPhoneNumber,
                          validate: (value) =>
                              FieldValidation().validateWorkPhoneNumber(value),
                          text: "WorkPhone",
                          keyboardType: TextInputType.phone),
                      const SizedBox(height: 10),
                      EmployeDetailsTextFormFiledCustom(
                          textEditingController:
                              employeDetailsFormController.hourlyRate,
                          validate: (value) =>
                              FieldValidation().validateHourlyRate(value),
                          text: "HourlyRate",
                          keyboardType: TextInputType.number),
                      const SizedBox(height: 10),
                      EmployeDetailsTextFormFiledCustom(
                          textEditingController:
                              employeDetailsFormController.salary,
                          validate: (value) =>
                              FieldValidation().validateSalary(value),
                          text: "Salary",
                          keyboardType: TextInputType.number),
                      const SizedBox(height: 10),
                      EmployeDetailsTextFormFiledCustom(
                        textEditingController:
                            employeDetailsFormController.firstDateOfWork,
                        validate: (value) =>
                            FieldValidation().validateFirstDayWork(value),
                        text: "FirstDay of Work",
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ButtonCustom(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
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
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 5,
                            child: ButtonCustom(
                              onPressed: () {},
                              text: "Edit",
                              textsize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).commonOnlyPadding(
                    top: 6.h,
                    right: 6.w,
                    left: 6.w,
                    bottom: 2.h,
                  ),
                ),
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EmployeDetailsTextFormFiledCustom extends StatelessWidget {
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
  EmployeDetailsTextFormFiledCustom(
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
        suffixIcon: Icon(suffixIcon),
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
  final employeDetailsFormController = Get.find<EmployeDetailsFormScreenController>();

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
