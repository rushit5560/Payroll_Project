import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/form_single_field_module.dart';
import 'package:payroll_system/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/salary_paycheks_manage_screen_controller.dart';
import 'package:payroll_system/models/employee_list_screen_models/employee_list_model.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/date_format_changer.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/extension_methods/user_preference.dart';

class SalaryPayChecksFormModule extends StatelessWidget {
  SalaryPayChecksFormModule({Key? key}) : super(key: key);

  final screenController = Get.find<SalaryPayChecksManageScreenController>();
  UserPreference userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Type Text & Dropdown Module
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
                    value: screenController.selectedSalaryChecksValue.value,
                    items: screenController.isSalaryPayChecksList
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
                      screenController.isLoading(true);
                      screenController.selectedSalaryChecksValue.value = value!;
                      screenController.endDateController.clear();
                      // screenController.endDate = DateTime.now();
                      screenController.isLoading(false);
                    },
                  ).commonOnlyPadding(left: 10, right: 10, top: 10, bottom: 10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),

          ///

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
                      screenController.startDateShowController,
                  suffixIcon: Icons.calendar_month,
                  readOnly: true,
                  onPressed: () async {
                    await _selectStartDate(
                        context: context,
                        dateTime: screenController.startDate,
                        textEditingController:
                            screenController.startDateController,
                        datePickerOption: DatePickerOption.startDate);
                  },
                  validate: (value) =>
                      FieldValidation().validateStartDate(value),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 5,
                child: SalaryFormSingleDateFieldModule(
                  headerText: AppMessage.endDate,
                  text: AppMessage.selectPayRollEndDate,
                  keyboardType: TextInputType.datetime,
                  mandatoryText: AppMessage.mandatory,
                  textEditingController: screenController.endDateShowController,
                  suffixIcon: Icons.calendar_month,
                  readOnly: true,
                  onPressed: () async {
                    await _selectEndDate(
                        context: context,
                        dateTime: screenController.endDate,
                        textEditingController:
                            screenController.endDateController,
                        datePickerOption: DatePickerOption.startDate);
                  },
                  validate: (value) => FieldValidation()
                      .validateEndDate(value, screenController.endDate),
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
            textEditingController: screenController.payDateShowController,
            suffixIcon: Icons.calendar_month,
            readOnly: true,
            onPressed: () async {
              await _selectPayDate(
                context: context,
                dateTime: screenController.payDate,
                textEditingController: screenController.payDateController,
                datePickerOption: DatePickerOption.startDate,
              );
            },
            validate: (value) => FieldValidation().validatePayDate(
                value, screenController.endDate, screenController.payDate),
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                screenController.allSalaryPaychecksWiseEmployeeList.length,
            itemBuilder: (context, index) {
              CompanyWiseEmployeeData employeeData =
                  screenController.allSalaryPaychecksWiseEmployeeList[index];

              // TextEditingController regularHourController = TextEditingController();

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
                            screenController.isLoading(true);
                            employeeData.isChecked = !employeeData.isChecked;
                            screenController.isLoading(false);
                            // screenController
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
                              // const SizedBox(height: 5),
                              // RegularTextFormFieldModule(
                              //   employeeData: employeeData,
                              //   regularHourController: regularHourController,
                              // ),
                              // const SizedBox(height: 5),
                              // OtTextFormFieldModule(employeeData: employeeData),
                              // const SizedBox(height: 5),
                              // HolidayPayTextFormFieldModule(employeeData: employeeData),
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
          const SizedBox(height: 5),

          ///

          /// Memo Text Field module
          FormSingleFieldModule(
            headerText: AppMessage.memo,
            text: AppMessage.memo,
            mandatoryText: AppMessage.empty,
            keyboardType: TextInputType.text,
            textEditingController: screenController.memoController,
            // validate: (value) =>
            //     FieldValidation().validateHourlyRate(value),
          ),
          const SizedBox(height: 15),

          ///

          /// Submit Button module
          CustomSubmitButtonModule(
              labelText: AppMessage.submit,
              onPress: () async {
                bool isEmployeeSelected = false;
                // if (screenController
                //         .selectedSalaryChecksValue.value ==
                //     "Choose Option") {
                //   Fluttertoast.showToast(msg: "Please select Pay period.");
                // } else {

                // if (screenController.formKey.currentState!.validate()) {
                /// Check Any employee select or not... & Then api call
                for (int i = 0;
                    i <
                        screenController
                            .allSalaryPaychecksWiseEmployeeList.length;
                    i++) {
                  if (screenController
                          .allSalaryPaychecksWiseEmployeeList[i].isChecked ==
                      true) {
                    isEmployeeSelected = true;
                  }
                }

                if (isEmployeeSelected == true) {
                  // screenController.clearAllTextFieldsList();
                  screenController.data.clear();
                  // call api
                  List<bool> isApiCallStatusList =
                      []; // Set validate status on this list

                  for (int i = 0;
                      i <
                          screenController
                              .allSalaryPaychecksWiseEmployeeList.length;
                      i++) {
                    if (screenController
                            .allSalaryPaychecksWiseEmployeeList[i].isChecked ==
                        true) {
                      // if (screenController.employeeFormKey.currentState!.validate()) {
                      isApiCallStatusList.add(true);
                      // todo
                      screenController.data.add({
                        "employee": screenController
                            .allSalaryPaychecksWiseEmployeeList[i].id
                            .toString(),
                        // "regularhour": screenController.allCompanyWiseEmployeeList[i].regularTextFieldValue,
                        // "overtime": screenController.allCompanyWiseEmployeeList[i].otTextFieldValue,
                        // "holidaypay": screenController.allCompanyWiseEmployeeList[i].holidayPayTextFieldValue,
                        "bonus": screenController
                            .allSalaryPaychecksWiseEmployeeList[i]
                            .bonusTextFieldValue,
                        "otherearning": screenController
                            .allSalaryPaychecksWiseEmployeeList[i]
                            .otherEarningTextFieldValue,
                        "commission": screenController
                            .allSalaryPaychecksWiseEmployeeList[i]
                            .commissionTextFieldValue,
                        "sickpay": screenController
                            .allSalaryPaychecksWiseEmployeeList[i]
                            .sickPayHoursTextFieldValue,
                        "vacationhours": screenController
                            .allSalaryPaychecksWiseEmployeeList[i]
                            .vacationHoursTextFieldValue,
                        "tip": screenController
                            .allSalaryPaychecksWiseEmployeeList[i]
                            .tipTextFieldValue,
                        "tax": screenController
                            .allSalaryPaychecksWiseEmployeeList[i]
                            .taxTextFieldValue,
                      });
                      // } else {
                      //   isApiCallStatusList.add(false);
                      // }
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
                    await screenController.createSalaryPaycheckFunction();
                  }
                } else {
                  Fluttertoast.showToast(msg: "Please select any employee.");
                }
                // }
              }
              // },
              ),
          const SizedBox(height: 5),

          ///
        ],
      ).commonOnlyPadding(top: 3.h, right: 6.w, left: 6.w, bottom: 3.h),
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
      // String prefsDateFormat = await userPreference.getStringValueFromPrefs(
      //     keyId: UserPreference.dateFormatKey);
      screenController.isLoading(true);

      // if(d.compareTo(screenController.endDate) < 0) {
      //   Fluttertoast.showToast(msg: "Please select valid start date");
      // } else {
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      screenController.startDateShowController.text =
          DateFormater().changeDateFormat(d, screenController.prefsDateFormat);

      screenController.startDate = d;

      if (screenController.selectedSalaryChecksValue.value == "Weekly") {
        final d1 = d;
        final d2 = d1.add(const Duration(days: 7));
        screenController.endDateController.text =
            "${d2.year}-${d2.month}-${d2.day}";
        screenController.endDateShowController.text = DateFormater()
            .changeDateFormat(d2, screenController.prefsDateFormat);
        screenController.endDate = d2;
      } else if (screenController.selectedSalaryChecksValue.value ==
          "Bi-Weekly") {
        final d1 = d;
        final d2 = d1.add(const Duration(days: 14));
        screenController.endDateController.text =
            "${d2.year}-${d2.month}-${d2.day}";
        screenController.endDate = d2;

        screenController.endDateShowController.text = DateFormater()
            .changeDateFormat(d2, screenController.prefsDateFormat);
      }

      screenController.isLoading(false);
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
      screenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      screenController.endDateShowController.text =
          DateFormater().changeDateFormat(d, screenController.prefsDateFormat);
      screenController.endDate = d;

      if (screenController.selectedSalaryChecksValue.value == "Others" ||
          screenController.selectedSalaryChecksValue.value == "Choose Option") {
        if (screenController.endDate.isBefore(screenController.startDate)) {
          Fluttertoast.showToast(msg: "End date must be after startDate");
        }
      }
      screenController.isLoading(false);
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

      screenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      screenController.payDateShowController.text =
          DateFormater().changeDateFormat(d, screenController.prefsDateFormat);

      screenController.payDate = d;
      screenController.isLoading(false);
    }
  }
}

// ignore: must_be_immutable
class SalaryFormSingleDateFieldModule extends StatelessWidget {
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
  SalaryFormSingleDateFieldModule(
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

  final screenController = Get.find<SalaryPayChecksManageScreenController>();

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
            suffixIcon:
                screenController.selectedSalaryChecksValue.value == "Bi-Weekly"
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
          // validator: (value) =>
          //     FieldValidation().validateHolidayPay(value.toString()),
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
          // validator: (value) =>
          //     FieldValidation().validateHolidayPay(value.toString()),
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
          // validator: (value) =>
          //     FieldValidation().validateHolidayPay(value.toString()),
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
          // validator: (value) =>
          //     FieldValidation().validateHolidayPay(value.toString()),
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
          // validator: (value) =>
          //     FieldValidation().validateHolidayPay(value.toString()),
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
          // validator: (value) =>
          //     FieldValidation().validateHolidayPay(value.toString()),
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
          // validator: (value) =>
          //     FieldValidation().validateHolidayPay(value.toString()),
        )
      ],
    );
  }
}
