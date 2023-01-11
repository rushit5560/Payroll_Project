import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final payCheckedManageScreenController = Get.find<PayCheckedManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: payCheckedManageScreenController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Text(
              AppMessage.createPaychecks,
              style: TextStyleConfig.textStyle(
                  fontSize: 22.sp, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 15),*/

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
                      payCheckedManageScreenController.selectedCheckedValue.value = value!;
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
                    onPressed: () async {
                      await _selectDate(
                          context: context,
                          dateTime: payCheckedManageScreenController.startDate,
                          textEditingController:
                              payCheckedManageScreenController
                                  .startDateController,
                          datePickerOption: DatePickerOption.startDate);
                    },
                    validate: (value) =>
                        FieldValidation().validateStartDayWork(value),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 5,
                  child: FormSingleFieldModule(
                    headerText: AppMessage.endDate,
                    text: AppMessage.selectPayRollEndDate,
                    keyboardType: TextInputType.datetime,
                    mandatoryText: AppMessage.mandatory,
                    textEditingController:
                        payCheckedManageScreenController.endDateController,
                    suffixIcon: payCheckedManageScreenController
                                    .selectedCheckedValue.value ==
                                "Weekly" &&
                            payCheckedManageScreenController
                                    .selectedCheckedValue.value ==
                                "Bi-Weekly"
                        ? Icons.arrow_back_ios
                        : Icons.calendar_month,
                    onPressed: () async {
                      await _selectDate(
                          context: context,
                          dateTime: payCheckedManageScreenController.endDate,
                          textEditingController:
                              payCheckedManageScreenController
                                  .startDateController,
                          datePickerOption: DatePickerOption.startDate);
                    },
                    validate: (value) =>
                        FieldValidation().validateStartDayWork(value),
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
              onPressed: () async {
                await _selectDate(
                    context: context,
                    dateTime: payCheckedManageScreenController.payDate,
                    textEditingController:
                        payCheckedManageScreenController.startDateController,
                    datePickerOption: DatePickerOption.startDate);
              },
              validate: (value) => FieldValidation().validatePayDayWork(value),
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
                            : Column(
                                children: [
                                  const SizedBox(height: 5),
                                  FormSingleFieldModule(
                                    headerText: AppMessage.regular,
                                    text: AppMessage.zero,
                                    mandatoryText: AppMessage.mandatory,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      employeeData.regularTextFieldValue = value;
                                    },

                                    validate: (value) =>
                                        FieldValidation().validateHourlyRate(value),
                                  ),
                                  const SizedBox(height: 5),
                                  FormSingleFieldModule(
                                    headerText: AppMessage.ot,
                                    text: AppMessage.zero,
                                    mandatoryText: AppMessage.mandatory,
                                    keyboardType: TextInputType.number,
                                    validate: (value) => FieldValidation().validateOverTime(value),
                                  ),
                                  const SizedBox(height: 5),
                                  FormSingleFieldModule(
                                    headerText: AppMessage.holidayPay,
                                    text: AppMessage.zero,
                                    mandatoryText: AppMessage.mandatory,
                                    keyboardType: TextInputType.number,
                                    validate: (value) => FieldValidation().validateHourlyRate(value),
                                  ),
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
                                          headerText: AppMessage.comission,
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
                                          validate: (value) => FieldValidation().validateHourlyRate(value),
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
                      ],
                    ).commonSymmetricPadding(horizontal: 5, vertical: 3),
                  ).commonOnlyPadding(bottom: 5);
                }),
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
      payCheckedManageScreenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      // dateTime = d;
      if (datePickerOption == DatePickerOption.startDate) {
        payCheckedManageScreenController.startDate = d;
        //todo


      } else if (datePickerOption == DatePickerOption.endDate) {
        payCheckedManageScreenController.endDate = d;
      } else {
        payCheckedManageScreenController.payDate = d;
      }
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
              if (payCheckedManageScreenController.formKey.currentState!.validate()) {}

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
