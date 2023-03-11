import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll/common_modules/form_single_field_module.dart';
import 'package:payroll/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/constants/enums.dart';
import 'package:payroll/controllers/pay_checked_manage_screen_controller.dart';
import 'package:payroll/models/employee_list_screen_models/employee_list_model.dart';
import 'package:payroll/screen/employee_screens/employee_manage_screen/employee_manage_screen_widget.dart';
import 'package:payroll/utils/app_images.dart';
import 'package:payroll/utils/date_format_changer.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/style.dart';
import 'package:payroll/utils/validator.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/extension_methods/user_preference.dart';

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
                  text: AppMessage.type,
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
                  // height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent),
                  ),
                  // child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButtonFormField<String>(
                      validator: (value) =>
                          FieldValidation().validateDropdownStatus(value!),
                      decoration: const InputDecoration.collapsed(hintText: ''),
                      value: payCheckedManageScreenController
                          .selectedCheckedValue.value,
                      items: payCheckedManageScreenController.isPayCheckedList
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
                        payCheckedManageScreenController.isLoading(true);
                        payCheckedManageScreenController
                            .selectedCheckedValue.value = value!;
                        payCheckedManageScreenController.endDateController
                            .clear();
                        // payCheckedManageScreenController.endDate = DateTime.now();
                        payCheckedManageScreenController.isLoading(false);
                      },
                    ).commonOnlyPadding(
                        left: 10, right: 10, top: 10, bottom: 10),
                  ),
                ),
              ),
            ),
            // ),
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
                    textEditingController: payCheckedManageScreenController
                        .startDateShowController,
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
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: FormSingleDateFieldModule(
                    headerText: AppMessage.endDate,
                    text: AppMessage.selectPayRollEndDate,
                    keyboardType: TextInputType.datetime,
                    mandatoryText: AppMessage.mandatory,
                    textEditingController:
                        payCheckedManageScreenController.endDateShowController,
                    suffixIcon: Icons.calendar_month,
                    readOnly: true,
                    onPressed: () async {
                      await _selectEndDate(
                          context: context,
                          dateTime: payCheckedManageScreenController.endDate,
                          textEditingController:
                              payCheckedManageScreenController
                                  .endDateController,
                          datePickerOption: DatePickerOption.endDate,
                          firstDate:
                              payCheckedManageScreenController.startDate);
                    },
                    validate: (value) => FieldValidation().validateEndDate(
                        value, payCheckedManageScreenController.endDate),
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
                  payCheckedManageScreenController.payDateShowController,
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
              validate: (value) => FieldValidation().validatePayDate(
                  value,
                  payCheckedManageScreenController.endDate,
                  payCheckedManageScreenController.payDate),
            ),
            const SizedBox(height: 5),

            /// Employee List module
            RichText(
              textAlign: TextAlign.left,
              maxLines: null,
              text: TextSpan(
                  text: AppMessage.companyEmployees,
                  style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.redColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ]),
            ).commonSymmetricPadding(vertical: 2),
            Form(
              key: payCheckedManageScreenController.employeeFormKey,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: payCheckedManageScreenController
                    .allCompanyWiseEmployeeList.length,
                itemBuilder: (context, index) {
                  CompanyWiseEmployeeData employeeData =
                      payCheckedManageScreenController
                          .allCompanyWiseEmployeeList[index];

                  TextEditingController regularHourController =
                      TextEditingController();
                  // TextEditingController otController = TextEditingController();
                  // TextEditingController holidayPayController = TextEditingController();
                  // TextEditingController bonusController = TextEditingController();
                  // TextEditingController otherEarningController = TextEditingController();
                  // TextEditingController commissionController = TextEditingController();
                  // TextEditingController sickController = TextEditingController();
                  // TextEditingController vacationController = TextEditingController();
                  // TextEditingController tipController = TextEditingController();
                  // TextEditingController taxController = TextEditingController();

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              value: employeeData.isChecked,
                              onChanged: (bool? value) {
                                payCheckedManageScreenController
                                    .isLoading(true);
                                employeeData.isChecked =
                                    !employeeData.isChecked;
                                payCheckedManageScreenController
                                    .isLoading(false);
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
                            : Column(
                                children: [
                                  const SizedBox(height: 5),
                                  RegularTextFormFieldModule(
                                    employeeData: employeeData,
                                    regularHourController:
                                        regularHourController,
                                  ),
                                  const SizedBox(height: 5),
                                  OtTextFormFieldModule(
                                      employeeData: employeeData),
                                  const SizedBox(height: 5),
                                  HolidayPayTextFormFieldModule(
                                      employeeData: employeeData),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: BonusTextFormFieldModule(
                                            employeeData: employeeData),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: OtherEarningTextFormFieldModule(
                                            employeeData: employeeData),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CommissionTextFormFieldModule(
                                            employeeData: employeeData),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: SickPayTextFormFieldModule(
                                            employeeData: employeeData),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: VacationTextFormFieldModule(
                                            employeeData: employeeData),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TipTextFormFieldModule(
                                            employeeData: employeeData),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  TaxTextFormFieldModule(
                                      employeeData: employeeData),
                                  const SizedBox(height: 5),
                                ],
                              ).commonSymmetricPadding(horizontal: 5),
                      ],
                    ).commonSymmetricPadding(horizontal: 5, vertical: 3),
                  ).commonOnlyPadding(bottom: 5);
                },
              ),
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

            /// Submit Button module
            CustomSubmitButtonModule(
                labelText: AppMessage.submit,
                onPress: () async {
                  bool isEmployeeSelected = false;
                  // if (payCheckedManageScreenController
                  //         .selectedCheckedValue.value ==
                  //     "Choose Option") {
                  //   Fluttertoast.showToast(msg: "Please select Pay period.");
                  // } else {

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
                      // payCheckedManageScreenController.clearAllTextFieldsList();
                      payCheckedManageScreenController.data.clear();
                      // call api
                      List<bool> isApiCallStatusList =
                          []; // Set validate status on this list

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
                            isApiCallStatusList.add(true);
                            // todo
                            payCheckedManageScreenController.data.add({
                              "employee": payCheckedManageScreenController.allCompanyWiseEmployeeList[i].id.toString(),
                              "regularhour": payCheckedManageScreenController.allCompanyWiseEmployeeList[i].regularTextFieldValue.isEmpty == true
                              ? "0"
                              : payCheckedManageScreenController.allCompanyWiseEmployeeList[i].regularTextFieldValue,
                              "overtime": payCheckedManageScreenController.allCompanyWiseEmployeeList[i].otTextFieldValue.isEmpty == true
                              ? "0"
                              : payCheckedManageScreenController.allCompanyWiseEmployeeList[i].otTextFieldValue,
                              "holidaypay": payCheckedManageScreenController.allCompanyWiseEmployeeList[i].holidayPayTextFieldValue.isEmpty == true
                              ? "0"
                              : payCheckedManageScreenController.allCompanyWiseEmployeeList[i].holidayPayTextFieldValue,
                              "bonus": payCheckedManageScreenController.allCompanyWiseEmployeeList[i].bonusTextFieldValue.isEmpty == true
                              ? "0"
                              : payCheckedManageScreenController.allCompanyWiseEmployeeList[i].bonusTextFieldValue,
                              "otherearning": payCheckedManageScreenController.allCompanyWiseEmployeeList[i].otherEarningTextFieldValue.isEmpty
                              ? "0"
                              : payCheckedManageScreenController.allCompanyWiseEmployeeList[i].otherEarningTextFieldValue,
                              "commission": payCheckedManageScreenController.allCompanyWiseEmployeeList[i].commissionTextFieldValue.isEmpty
                              ? "0"
                              : payCheckedManageScreenController.allCompanyWiseEmployeeList[i].commissionTextFieldValue,
                              "sickpay": payCheckedManageScreenController.allCompanyWiseEmployeeList[i].sickPayHoursTextFieldValue.isEmpty == true
                              ? "0"
                              : payCheckedManageScreenController.allCompanyWiseEmployeeList[i].sickPayHoursTextFieldValue,
                              "vacationhours": payCheckedManageScreenController.allCompanyWiseEmployeeList[i].vacationHoursTextFieldValue.isEmpty == true
                              ? "0"
                              : payCheckedManageScreenController.allCompanyWiseEmployeeList[i].vacationHoursTextFieldValue,
                              "tip": payCheckedManageScreenController.allCompanyWiseEmployeeList[i].tipTextFieldValue.isEmpty == true
                              ? "0"
                              : payCheckedManageScreenController.allCompanyWiseEmployeeList[i].tipTextFieldValue,
                              "tax": payCheckedManageScreenController.allCompanyWiseEmployeeList[i].taxTextFieldValue.isEmpty == true
                              ? "0"
                              : payCheckedManageScreenController.allCompanyWiseEmployeeList[i].taxTextFieldValue,
                            });
                          } else {
                            isApiCallStatusList.add(false);
                          }
                        }
                      }

                      // If any formKey Current Status not valid then api not call - set this type of logic here
                      bool apiCallFinalStatus = true;
                      for (int i = 0; i < isApiCallStatusList.length; i++) {
                        if (isApiCallStatusList[i] == false) {
                          apiCallFinalStatus = false;
                        }
                      }

                      if (apiCallFinalStatus == true) {
                        // api call
                        log('Api Call');
                        await payCheckedManageScreenController
                            .createPaycheckFunction();
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please select any employee.");
                    }
                  }
                }
                // },
                ),
            // ButtonModule(),
            const SizedBox(height: 5),
          ],
        ).commonOnlyPadding(top: 3.h, right: 6.w, left: 6.w, bottom: 3.h),
      ),
    );
  }

  UserPreference userPreference = UserPreference();

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
      // String prefsDateFormat = await userPreference.getStringValueFromPrefs(
      //     keyId: UserPreference.dateFormatKey);
      payCheckedManageScreenController.isLoading(true);

      // if(d.compareTo(payCheckedManageScreenController.endDate) < 0) {
      //   Fluttertoast.showToast(msg: "Please select valid start date");
      // } else {
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      payCheckedManageScreenController.startDateShowController.text =
          DateFormater().changeDateFormat(
              d, payCheckedManageScreenController.prefsDateFormat);

      payCheckedManageScreenController.startDate = d;

      if (payCheckedManageScreenController.selectedCheckedValue.value ==
          "Weekly") {
        final d1 = d;
        final d2 = d1.add(const Duration(days: 7));
        payCheckedManageScreenController.endDateController.text =
            "${d2.year}-${d2.month}-${d2.day}";
        payCheckedManageScreenController.endDateShowController.text =
            DateFormater().changeDateFormat(
                d2, payCheckedManageScreenController.prefsDateFormat);
        payCheckedManageScreenController.endDate = d2;
      } else if (payCheckedManageScreenController.selectedCheckedValue.value ==
          "Bi-Weekly") {
        final d1 = d;
        final d2 = d1.add(const Duration(days: 14));
        payCheckedManageScreenController.endDateController.text =
            "${d2.year}-${d2.month}-${d2.day}";
        payCheckedManageScreenController.endDate = d2;

        payCheckedManageScreenController.endDateShowController.text =
            DateFormater().changeDateFormat(
                d2, payCheckedManageScreenController.prefsDateFormat);
      }

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
      payCheckedManageScreenController.endDateShowController.text =
          DateFormater().changeDateFormat(
              d, payCheckedManageScreenController.prefsDateFormat);
      payCheckedManageScreenController.endDate = d;

      if (payCheckedManageScreenController.selectedCheckedValue.value ==
              "Others" ||
          payCheckedManageScreenController.selectedCheckedValue.value ==
              "Choose Option") {
        if (payCheckedManageScreenController.endDate
            .isBefore(payCheckedManageScreenController.startDate)) {
          Fluttertoast.showToast(msg: "End date must be after startDate");
        }
      }
      payCheckedManageScreenController.isLoading(false);
    }
  }

  Future<void> _selectPayDate({
    required BuildContext context,
    required DateTime dateTime,
    required TextEditingController textEditingController,
    required DatePickerOption datePickerOption,
  }) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
    );
    if (d != null) {
      // String prefsDateFormat = await userPreference.getStringValueFromPrefs(
      //     keyId: UserPreference.dateFormatKey);

      payCheckedManageScreenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      payCheckedManageScreenController.payDateShowController.text =
          DateFormater().changeDateFormat(
              d, payCheckedManageScreenController.prefsDateFormat);

      payCheckedManageScreenController.payDate = d;
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
                        // if (payCheckedManageScreenController.employeeFormKey.currentState!.validate()) {
                        log("employee done");
                        log('employeeData.regularTextFieldValue : ${payCheckedManageScreenController.allCompanyWiseEmployeeList[i].regularTextFieldValue}');
                        // }
                      }
                    }
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
              ).commonSymmetricPadding(vertical: 4)
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
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            fillColor: AppColors.colorWhite,
            filled: true,
            counterText: '',
            hintText: text,
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            suffixIcon: screenController.selectedCheckedValue.value ==
                        "Weekly" ||
                    screenController.selectedCheckedValue.value == "Bi-Weekly"
                ? null
                : IconButton(
                    onPressed: onPressed,
                    icon: Icon(suffixIcon,
                        color: AppColors.colorLightHintPurple2)),
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
  CompanyWiseEmployeeData employeeData;
  TextEditingController regularHourController;
  RegularTextFormFieldModule(
      {super.key,
      required this.employeeData,
      required this.regularHourController});

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
            ],
          ),
        ).commonSymmetricPadding(vertical: 6),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: regularHourController,
          onChanged: (value) {
            employeeData.regularTextFieldValue = value;
          },
          decoration: InputDecoration(
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            fillColor: AppColors.colorLightPurple2,
            filled: true,
            counterText: '',
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            hintText: AppMessage.hours,
            errorMaxLines: 2,
          ),
          validator: (value) =>
              FieldValidation().validateRegularRate(value.toString()),
        )
      ],
    );
  }
}

class OtTextFormFieldModule extends StatelessWidget {
  CompanyWiseEmployeeData employeeData;
  OtTextFormFieldModule({super.key, required this.employeeData});

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
            // children: [
            //   TextSpan(
            //     text: " ${AppMessage.mandatory}",
            //     style: TextStyleConfig.textStyle(
            //       textColor: AppColors.redColor,
            //       fontWeight: FontWeight.w600,
            //       fontSize: 16,
            //     ),
            //   ),
            // ],
          ),
        ).commonSymmetricPadding(vertical: 6),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            employeeData.otTextFieldValue = value;
          },
          decoration: InputDecoration(
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            fillColor: AppColors.colorLightPurple2,
            filled: true,
            counterText: '',
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            hintText: AppMessage.zero,
            errorMaxLines: 2,
          ),
          validator: (value) => FieldValidation().validateOt(value.toString()),
        )
      ],
    );
  }
}

class HolidayPayTextFormFieldModule extends StatelessWidget {
  CompanyWiseEmployeeData employeeData;
  HolidayPayTextFormFieldModule({super.key, required this.employeeData});

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
            // children: [
            //   TextSpan(
            //     text: " ${AppMessage.mandatory}",
            //     style: TextStyleConfig.textStyle(
            //       textColor: AppColors.redColor,
            //       fontWeight: FontWeight.w600,
            //       fontSize: 16,
            //     ),
            //   ),
            // ],
          ),
        ).commonSymmetricPadding(vertical: 6),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            employeeData.holidayPayTextFieldValue = value;
          },
          decoration: InputDecoration(
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            fillColor: AppColors.colorLightPurple2,
            filled: true,
            counterText: '',
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            hintText: AppMessage.zero,
            errorMaxLines: 2,
          ),
          validator: (value) =>
              FieldValidation().validateHolidayPay(value.toString()),
        )
      ],
    );
  }
}

class BonusTextFormFieldModule extends StatelessWidget {
  CompanyWiseEmployeeData employeeData;
  BonusTextFormFieldModule({super.key, required this.employeeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: null,
          text: TextSpan(
            text: AppMessage.bonus,
            style: TextStyleConfig.textStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ).commonSymmetricPadding(vertical: 6),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            employeeData.bonusTextFieldValue = value;
          },
          decoration: InputDecoration(
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            fillColor: AppColors.colorLightPurple2,
            filled: true,
            counterText: '',
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            hintText: AppMessage.zero,
            errorMaxLines: 2,
          ),
          validator: (value) =>
              FieldValidation().validateBonusPay(value.toString()),
        )
      ],
    );
  }
}

class OtherEarningTextFormFieldModule extends StatelessWidget {
  CompanyWiseEmployeeData employeeData;
  OtherEarningTextFormFieldModule({super.key, required this.employeeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: null,
          text: TextSpan(
            text: AppMessage.otherEarning,
            style: TextStyleConfig.textStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ).commonSymmetricPadding(vertical: 6),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            employeeData.otherEarningTextFieldValue = value;
          },
          decoration: InputDecoration(
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            fillColor: AppColors.colorLightPurple2,
            filled: true,
            counterText: '',
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            hintText: AppMessage.zero,
            errorMaxLines: 2,
          ),
          validator: (value) =>
              FieldValidation().validateOtherEarningPay(value.toString()),
        )
      ],
    );
  }
}

class CommissionTextFormFieldModule extends StatelessWidget {
  CompanyWiseEmployeeData employeeData;
  CommissionTextFormFieldModule({super.key, required this.employeeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: null,
          text: TextSpan(
            text: AppMessage.commission,
            style: TextStyleConfig.textStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ).commonSymmetricPadding(vertical: 6),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            employeeData.commissionTextFieldValue = value;
          },
          decoration: InputDecoration(
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            fillColor: AppColors.colorLightPurple2,
            filled: true,
            counterText: '',
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            hintText: AppMessage.zero,
            errorMaxLines: 2,
          ),
          validator: (value) =>
              FieldValidation().validateOtherEarningPay(value.toString()),
        )
      ],
    );
  }
}

class SickPayTextFormFieldModule extends StatelessWidget {
  CompanyWiseEmployeeData employeeData;
  SickPayTextFormFieldModule({super.key, required this.employeeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: null,
          text: TextSpan(
            text: AppMessage.sickPayHours,
            style: TextStyleConfig.textStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ).commonSymmetricPadding(vertical: 6),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            employeeData.sickPayHoursTextFieldValue = value;
          },
          decoration: InputDecoration(
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            fillColor: AppColors.colorLightPurple2,
            filled: true,
            counterText: '',
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            hintText: AppMessage.zero,
            errorMaxLines: 2,
          ),
          validator: (value) =>
              FieldValidation().validateOtherEarningPay(value.toString()),
        )
      ],
    );
  }
}

class VacationTextFormFieldModule extends StatelessWidget {
  CompanyWiseEmployeeData employeeData;
  VacationTextFormFieldModule({super.key, required this.employeeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: null,
          text: TextSpan(
            text: AppMessage.vacationHour,
            style: TextStyleConfig.textStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ).commonSymmetricPadding(vertical: 6),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            employeeData.vacationHoursTextFieldValue = value;
          },
          decoration: InputDecoration(
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            fillColor: AppColors.colorLightPurple2,
            filled: true,
            counterText: '',
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            hintText: AppMessage.zero,
            errorMaxLines: 2,
          ),
          validator: (value) =>
              FieldValidation().validateOtherEarningPay(value.toString()),
        )
      ],
    );
  }
}

class TipTextFormFieldModule extends StatelessWidget {
  CompanyWiseEmployeeData employeeData;
  TipTextFormFieldModule({super.key, required this.employeeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: null,
          text: TextSpan(
            text: AppMessage.tip,
            style: TextStyleConfig.textStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ).commonSymmetricPadding(vertical: 6),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            employeeData.tipTextFieldValue = value;
          },
          decoration: InputDecoration(
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            fillColor: AppColors.colorLightPurple2,
            filled: true,
            counterText: '',
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            hintText: AppMessage.zero,
            errorMaxLines: 2,
          ),
          validator: (value) =>
              FieldValidation().validateOtherEarningPay(value.toString()),
        )
      ],
    );
  }
}

class TaxTextFormFieldModule extends StatelessWidget {
  CompanyWiseEmployeeData employeeData;
  TaxTextFormFieldModule({super.key, required this.employeeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: null,
          text: TextSpan(
            text: AppMessage.tax,
            style: TextStyleConfig.textStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ).commonSymmetricPadding(vertical: 6),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            employeeData.taxTextFieldValue = value;
          },
          decoration: InputDecoration(
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            fillColor: AppColors.colorLightPurple2,
            filled: true,
            counterText: '',
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            hintText: AppMessage.zero,
            errorMaxLines: 2,
          ),
          validator: (value) =>
              FieldValidation().validateOtherEarningPay(value.toString()),
        )
      ],
    );
  }
}

class PayCheckFormSingleFieldModule extends StatelessWidget {
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
  PayCheckFormSingleFieldModule(
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
                          textColor: AppColors.colorRed,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ]),
              ).commonSymmetricPadding(vertical: 4)
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
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            counterText: '',
            hintText: text,
            fillColor: AppColors.colorLightPurple2,
            filled: true,
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  suffixIcon,
                  color: AppColors.colorLightHintPurple2,
                )),
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
