import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/form_single_field_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/pay_checked_manage_screen_controller.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen_widget.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:sizer/sizer.dart';

class PayChecksWidgetsScreen extends StatelessWidget {
  PayChecksWidgetsScreen({super.key});

  final payCheckedManageScreenController =
      Get.find<PayCheckedManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: payCheckedManageScreenController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Pay Period Dropdown module
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
                border: Border.all(color: AppColors.greyColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: payCheckedManageScreenController
                        .selectedCheckedValue.value,
                    items: payCheckedManageScreenController.isPayCheckedList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      payCheckedManageScreenController.isLoading(true);
                      payCheckedManageScreenController
                          .selectedCheckedValue.value = value!;
                      payCheckedManageScreenController.endDateController
                          .clear();
                      // payCheckedManageScreenController.endDate = DateTime.now();
                      payCheckedManageScreenController.isLoading(false);
                    },
                  ).commonOnlyPadding(left: 10, right: 10),
                ),
              ),
            ),
            const SizedBox(height: 15),

            /// Start & End Date module
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: FormSingleFieldModule(
                    headerText: AppMessage.startDate,
                    text: AppMessage.selectPayRollStartDate,
                    keyboardType: TextInputType.datetime,
                    mandatoryText: AppMessage.mandatory,
                    textEditingController:
                        payCheckedManageScreenController.startDateController,
                    suffixIcon: Icons.calendar_month,
                    readOnly: true,
                    onPressed: () async {
                      await _selectStartDate(
                          context: context,
                          dateTime: payCheckedManageScreenController.startDate,
                          textEditingController:
                              payCheckedManageScreenController
                                  .startDateController,
                          datePickerOption: DatePickerOption.startDate);
                    },
                    validate: (value) =>
                        FieldValidation().validateStartDate(value),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 5,
                  child: FormSingleDateFieldModule(
                    headerText: AppMessage.endDate,
                    text: AppMessage.selectPayRollEndDate,
                    keyboardType: TextInputType.datetime,
                    mandatoryText: AppMessage.mandatory,
                    textEditingController:
                        payCheckedManageScreenController.endDateController,
                    suffixIcon: Icons.calendar_month,
                    readOnly: true,
                    onPressed: () async {
                      await _selectEndDate(
                          context: context,
                          dateTime: payCheckedManageScreenController.endDate,
                          textEditingController:
                              payCheckedManageScreenController
                                  .endDateController,
                          datePickerOption: DatePickerOption.startDate);
                    },
                    validate: (value) =>
                        FieldValidation().validateEndDate(value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),

            /// Pay Date module
            FormSingleFieldModule(
              headerText: AppMessage.payDate,
              text: AppMessage.payDate,
              keyboardType: TextInputType.datetime,
              mandatoryText: AppMessage.mandatory,
              textEditingController:
                  payCheckedManageScreenController.payDateController,
              suffixIcon: Icons.calendar_month,
              readOnly: true,
              onPressed: () async {
                await _selectPayDate(
                  context: context,
                  dateTime: payCheckedManageScreenController.payDate,
                  textEditingController:
                      payCheckedManageScreenController.payDateController,
                  datePickerOption: DatePickerOption.startDate,
                );
              },
              validate: (value) => FieldValidation().validatePayDate(value),
            ),
            const SizedBox(height: 5),

            /// Employee List module
            Text(
              AppMessage.companyEmployees,
              style: TextStyleConfig.textStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ).commonSymmetricPadding(vertical: 2),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: payCheckedManageScreenController
                  .allCompanyWiseEmployeeList.length,
              itemBuilder: (context, index) {
                final employeeData = payCheckedManageScreenController
                    .allCompanyWiseEmployeeList[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.greyColor),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            value: employeeData.isChecked,
                            onChanged: (bool? value) {
                              payCheckedManageScreenController.isLoading(true);
                              employeeData.isChecked = !employeeData.isChecked;
                              payCheckedManageScreenController.isLoading(false);
                              // payCheckedManageScreenController
                              //     .isPrivacyChecked.value = value!;
                            },
                          ),
                          Expanded(
                            child: Text(
                              "${employeeData.firstName} "
                              "${employeeData.middleName} "
                              "${employeeData.lastName}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleConfig.textStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      employeeData.isChecked == false
                          ? Container()
                          : Form(
                              key: employeeData.isChecked == false
                                  ? null
                                  : payCheckedManageScreenController
                                      .employeeFormKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 5),

                                  const RegularTextFormFieldModule(),
                                  // FormSingleFieldModule(
                                  //   headerText: AppMessage.regular,
                                  //   text: AppMessage.hours,
                                  //   mandatoryText: AppMessage.mandatory,
                                  //   keyboardType: TextInputType.number,
                                  //   onChanged: (value) {
                                  //     employeeData.regularTextFieldValue =
                                  //         value;
                                  //   },
                                  //   // validate: (value) => FieldValidation()
                                  //   //     .validateHourlyRate(value),
                                  // ),
                                  const SizedBox(height: 5),

                                  const OtTextFormFieldModule(),
                                  // FormSingleFieldModule(
                                  //   headerText: AppMessage.ot,
                                  //   text: AppMessage.ot,
                                  //   mandatoryText: AppMessage.mandatory,
                                  //   keyboardType: TextInputType.number,
                                  //   // validate: (value) => FieldValidation()
                                  //   //     .validateOverTime(value),
                                  // ),
                                  const SizedBox(height: 5),

                                  const HolidayPayTextFormFieldModule(),
                                  // FormSingleFieldModule(
                                  //   headerText: AppMessage.holidayPay,
                                  //   text: AppMessage.hours,
                                  //   mandatoryText: AppMessage.mandatory,
                                  //   keyboardType: TextInputType.number,
                                  //   // validate: (value) => FieldValidation()
                                  //   //     .validateHourlyRate(value),
                                  // ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: FormSingleFieldModule(
                                          headerText: AppMessage.bonus,
                                          text: AppMessage.zero,
                                          mandatoryText: AppMessage.empty,
                                          keyboardType: TextInputType.number,
                                          textEditingController:
                                              payCheckedManageScreenController
                                                  .bonusController,
                                          // validate: (value) => FieldValidation().validateOverTime(value),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        flex: 5,
                                        child: FormSingleFieldModule(
                                          headerText: AppMessage.otherEarning,
                                          text: AppMessage.zero,
                                          mandatoryText: AppMessage.empty,
                                          keyboardType: TextInputType.number,
                                          textEditingController:
                                              payCheckedManageScreenController
                                                  .otherEarningController,
                                          // validate: (value) => FieldValidation().validateOverTime(value),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: FormSingleFieldModule(
                                          headerText: AppMessage.commission,
                                          text: AppMessage.zero,
                                          mandatoryText: AppMessage.empty,
                                          keyboardType: TextInputType.number,
                                          textEditingController:
                                              payCheckedManageScreenController
                                                  .comissionController,
                                          // validate: (value) => FieldValidation().validateOverTime(value),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        flex: 5,
                                        child: FormSingleFieldModule(
                                          headerText: AppMessage.sickPayHours,
                                          text: AppMessage.zero,
                                          mandatoryText: AppMessage.empty,
                                          keyboardType: TextInputType.number,
                                          textEditingController:
                                              payCheckedManageScreenController
                                                  .sickPayHoursController,
                                          // validate: (value) =>
                                          //     FieldValidation().validateHourlyRate(value),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: FormSingleFieldModule(
                                          headerText: AppMessage.vacationHour,
                                          text: AppMessage.zero,
                                          mandatoryText: AppMessage.empty,
                                          keyboardType: TextInputType.number,
                                          textEditingController:
                                              payCheckedManageScreenController
                                                  .vacationHourController,
                                          // validate: (value) =>
                                          //     FieldValidation().validateHourlyRate(value),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        flex: 5,
                                        child: FormSingleFieldModule(
                                          headerText: AppMessage.tip,
                                          text: AppMessage.zero,
                                          mandatoryText: AppMessage.empty,
                                          keyboardType: TextInputType.number,
                                          // validate: (value) => FieldValidation()
                                          //     .validateHourlyRate(value),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  FormSingleFieldModule(
                                    headerText: AppMessage.tax,
                                    text: AppMessage.zero,
                                    mandatoryText: AppMessage.empty,
                                    keyboardType: TextInputType.number,
                                    textEditingController:
                                        payCheckedManageScreenController
                                            .taxController,
                                    // validate: (value) =>
                                    //     FieldValidation().validateHourlyRate(value),
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              ),
                            ),
                    ],
                  ).commonSymmetricPadding(horizontal: 5, vertical: 3),
                ).commonOnlyPadding(bottom: 5);
              },
            ),
            const SizedBox(height: 5),

            /// Memo Text Field module
            FormSingleFieldModule(
              headerText: AppMessage.memo,
              text: AppMessage.memo,
              mandatoryText: AppMessage.empty,
              keyboardType: TextInputType.text,
              textEditingController:
                  payCheckedManageScreenController.memoController,
              // validate: (value) =>
              //     FieldValidation().validateHourlyRate(value),
            ),
            const SizedBox(height: 15),

            /// Submit & Back Button module
            ButtonModule(),
            const SizedBox(height: 5),
          ],
        ).commonOnlyPadding(top: 3.h, right: 6.w, left: 6.w, bottom: 3.h),
      ),
    );
  }

  Future<void> _selectStartDate({
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
      payCheckedManageScreenController.isLoading(true);

      // if(d.compareTo(payCheckedManageScreenController.endDate) < 0) {
      //   Fluttertoast.showToast(msg: "Please select valid start date");
      // } else {
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      payCheckedManageScreenController.startDate = d;

      if (payCheckedManageScreenController.selectedCheckedValue.value ==
          "Weekly") {
        final d1 = d;
        final d2 = d1.add(const Duration(days: 7));
        payCheckedManageScreenController.endDateController.text =
            "${d2.year}-${d2.month}-${d2.day}";
        payCheckedManageScreenController.endDate = d2;
      } else if (payCheckedManageScreenController.selectedCheckedValue.value ==
          "Bi-Weekly") {
        final d1 = d;
        final d2 = d1.add(const Duration(days: 14));
        payCheckedManageScreenController.endDateController.text =
            "${d2.year}-${d2.month}-${d2.day}";
        payCheckedManageScreenController.endDate = d2;
      }

      // }

      payCheckedManageScreenController.isLoading(false);
    }
  }

  Future<void> _selectEndDate({
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
      payCheckedManageScreenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      payCheckedManageScreenController.endDate = d;
      if (payCheckedManageScreenController.selectedCheckedValue.value ==
              "Others" ||
          payCheckedManageScreenController.selectedCheckedValue.value ==
              "Choose Option") {
        log("start date");

        if (payCheckedManageScreenController.endDate
            .isBefore(payCheckedManageScreenController.startDate)) {
          log("11111");
          Fluttertoast.showToast(msg: "End date must be after startDate");
          log("message 1111");
        }
        log("end date");
      }

      // payCheckedManageScreenController.endDateController.text = "${d.year}-${d.month}-${d.day}";
      payCheckedManageScreenController.isLoading(false);
    }
  }

  Future<void> _selectPayDate({
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
      payCheckedManageScreenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      // dateTime = d;
      // if (datePickerOption == DatePickerOption.payDate) {
      //   payCheckedManageScreenController.payDate = d;
      // }
      payCheckedManageScreenController.isLoading(false);
    }
  }
}

class ButtonModule extends StatelessWidget {
  ButtonModule({super.key});

  final payCheckedManageScreenController =
      Get.find<PayCheckedManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ButtonCustom(
            onPressed: () async {
              bool isEmployeeSelected = false;
              if (payCheckedManageScreenController.selectedCheckedValue.value ==
                  "Choose Option") {
                Fluttertoast.showToast(msg: "Please select Pay period.");
              } else {
                if (payCheckedManageScreenController.formKey.currentState!
                    .validate()) {
                  /// Check Any employee select or not... & Then api call
                  for (int i = 0;
                      i <
                          payCheckedManageScreenController
                              .allCompanyWiseEmployeeList.length;
                      i++) {
                    if (payCheckedManageScreenController
                            .allCompanyWiseEmployeeList[i].isChecked ==
                        true) {
                      isEmployeeSelected = true;
                    }
                  }

                  if (isEmployeeSelected == true) {
                    // call api
                    for (int i = 0;
                        i <
                            payCheckedManageScreenController
                                .allCompanyWiseEmployeeList.length;
                        i++) {
                      if (payCheckedManageScreenController
                              .allCompanyWiseEmployeeList[i].isChecked ==
                          true) {
                        if (payCheckedManageScreenController
                            .employeeFormKey.currentState!
                            .validate()) {
                          log("employee done");
                          // Get.back();
                        }
                      }
                    }

                    log('Done');
                  } else {
                    Fluttertoast.showToast(msg: "Please select any employee.");
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
    );
  }
}

// ignore: must_be_immutable
class FormSingleDateFieldModule extends StatelessWidget {
  final String text;
  final String headerText;
  final String mandatoryText;
  final bool isHeaderTextShow;
  // IconData prefixIcon;
  IconData? suffixIcon;
  final FormFieldValidator? validate;
  TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  Color color;
  Function()? onTap;
  Function(String)? onChanged;
  Size? size;
  TextInputType? keyboardType;
  bool readOnly;
  int? maxLength;
  bool obscureText;
  Function()? onPressed;
  //  double fontSize = 15.0,
  FormSingleDateFieldModule(
      {Key? key,
      required this.text,
      required this.headerText,
      required this.mandatoryText,
      // required this.prefixIcon,
      this.isHeaderTextShow = true,
      this.inputFormatters,
      this.suffixIcon,
      this.color = Colors.grey,
      this.size,
      this.textEditingController,
      this.onTap,
      this.onChanged,
      this.keyboardType,
      this.validate,
      this.maxLength,
      this.onPressed,
      this.obscureText = false,
      this.readOnly = false})
      : super(key: key);

  final screenController = Get.find<PayCheckedManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isHeaderTextShow == true
            ? RichText(
                textAlign: TextAlign.left,
                maxLines: null,
                text: TextSpan(
                    text: headerText,
                    style: TextStyleConfig.textStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: ' $mandatoryText',
                        style: TextStyleConfig.textStyle(
                          textColor: AppColors.redColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ]),
              ).commonSymmetricPadding(vertical: 2)
            : Container(),
        TextFormField(
          // obscureText: loginScreenController.isPasswordVisible.value,
          obscureText: obscureText,
          validator: validate,
          onTap: onTap,
          onChanged: (value) => onChanged!(value),
          readOnly: readOnly,
          keyboardType: keyboardType,
          controller: textEditingController,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          decoration: InputDecoration(
            counterText: '',
            hintText: text,
            suffixIcon: screenController.selectedCheckedValue.value ==
                        "Weekly" ||
                    screenController.selectedCheckedValue.value == "Bi-Weekly"
                ? null
                : IconButton(onPressed: onPressed, icon: Icon(suffixIcon)),
            errorMaxLines: 2,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RegularTextFormFieldModule extends StatelessWidget {
  const RegularTextFormFieldModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: null,
          text: TextSpan(
              text: AppMessage.regular,
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
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: '',
            hintText: AppMessage.regular,
            errorMaxLines: 2,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          validator: (value) =>
              FieldValidation().validateRegularRate(value.toString()),
        )
      ],
    );
  }
}

class OtTextFormFieldModule extends StatelessWidget {
  const OtTextFormFieldModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: null,
          text: TextSpan(
              text: AppMessage.ot,
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
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: '',
            hintText: AppMessage.ot,
            errorMaxLines: 2,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          validator: (value) => FieldValidation().validateOt(value.toString()),
        )
      ],
    );
  }
}

class HolidayPayTextFormFieldModule extends StatelessWidget {
  const HolidayPayTextFormFieldModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: null,
          text: TextSpan(
              text: AppMessage.holidayPay,
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
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: '',
            hintText: AppMessage.holidayPay,
            errorMaxLines: 2,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          validator: (value) =>
              FieldValidation().validateHolidayPay(value.toString()),
        )
      ],
    );
  }
}



// https://www.africau.edu/images/default/sample.pdf