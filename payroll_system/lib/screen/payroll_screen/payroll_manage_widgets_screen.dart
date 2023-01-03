import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/form_single_field_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/payroll_manage_screen_controller.dart';
import 'package:payroll_system/models/employee_list_screen_models/employee_list_model.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen_widget.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:sizer/sizer.dart';

class PayRollManageWidgetsScreen extends StatelessWidget {
  PayRollManageWidgetsScreen({super.key});
  final payRollScreenController = Get.find<PayRollScreenController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: payRollScreenController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppMessage.payRollForm,
              style: TextStyleConfig.textStyle(
                  fontSize: 22.sp, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 15),
            FormSingleFieldModule(
              headerText: AppMessage.startDate,
              text: AppMessage.selectPayRollStartDate,
              keyboardType: TextInputType.datetime,
              mandatoryText: AppMessage.mandatory,
              textEditingController:
                  payRollScreenController.startDateController,
              suffixIcon: Icons.calendar_month,
              onPressed: () {
                // DateFormat("yyyy-MM-dd")
                //     .format(payRollScreenController.dateRange.value.start)
                //     .toString();
                    
                _selectDate(
                    context,
                    payRollScreenController.startDate,
                    payRollScreenController.startDateController,
                    DatePickerOption.startDate);
              },
              validate: (value) =>
                  FieldValidation().validateStartDayWork(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.endDate,
              text: AppMessage.selectPayRollEndDate,
              keyboardType: TextInputType.datetime,
              mandatoryText: AppMessage.mandatory,
              textEditingController: payRollScreenController.endDateController,
              suffixIcon: Icons.calendar_month,
              onPressed: () {
                // DateFormat("yyyy-MM-dd")
                //     .format(payRollScreenController.dateRange.value.end)
                //     .toString();
                _selectDate(
                    context,
                    payRollScreenController.endDate,
                    payRollScreenController.endDateController,
                    DatePickerOption.startDate);
              },
              validate: (value) =>
                  FieldValidation().validateStartDayWork(value),
            ),
            const SizedBox(height: 5),
            RichText(
              textAlign: TextAlign.left,
              maxLines: null,
              text: TextSpan(
                  text: AppMessage.company,
                  style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: AppMessage.mandatory,
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.redColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ]),
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
                  child: DropdownButton<String>(
                    value: payRollScreenController.companyDDSelectedStringItem,
                    items: [payRollScreenController.companyName]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) async {
                      payRollScreenController.companyDDSelectedStringItem =
                          value!;
                    },
                  ).commonOnlyPadding(left: 10, right: 10),
                ),
              ),
            ),
            const SizedBox(height: 5),
            RichText(
              textAlign: TextAlign.left,
              maxLines: null,
              text: TextSpan(
                  text: AppMessage.employee,
                  style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: AppMessage.mandatory,
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.redColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ]),
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
                  child: DropdownButton<CopanyWiseDepartmentData>(
                    value: payRollScreenController.copanyWiseDepartmentData,
                    items: payRollScreenController.allCompanyWiseEmployeeList
                        .map<DropdownMenuItem<CopanyWiseDepartmentData>>(
                            (CopanyWiseDepartmentData value) {
                      return DropdownMenuItem<CopanyWiseDepartmentData>(
                        value: value,
                        child: Text(value.firstName),
                      );
                    }).toList(),
                    onChanged: (CopanyWiseDepartmentData? value) async {
                      payRollScreenController.isLoading(true);
                      // This is called when the user selects an item.
                      log('valuevaluevaluevalue :${value!.firstName}');
                      // payRollScreenController.isloding(true);
                      payRollScreenController.copanyWiseDepartmentData = value;
                      payRollScreenController.isLoading(false);
                    },
                  ).commonOnlyPadding(left: 10, right: 10),
                ),
              ),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.overTime,
              text: AppMessage.overTime,
              mandatoryText: AppMessage.mandatory,
              keyboardType: TextInputType.number,
              textEditingController: payRollScreenController.overTimeController,
              // validate: (value) => FieldValidation().validateOverTime(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.bonus,
              text: AppMessage.bonus,
              mandatoryText: AppMessage.mandatory,
              keyboardType: TextInputType.number,
              textEditingController: payRollScreenController.bonusController,
              // validate: (value) => FieldValidation().validateOverTime(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.otherEarning,
              text: AppMessage.otherEarning,
              mandatoryText: AppMessage.mandatory,
              keyboardType: TextInputType.number,
              textEditingController:
                  payRollScreenController.otherEarningController,
              // validate: (value) => FieldValidation().validateOverTime(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.comission,
              text: AppMessage.comission,
              mandatoryText: AppMessage.mandatory,
              keyboardType: TextInputType.number,
              textEditingController:
                  payRollScreenController.comissionController,
              // validate: (value) => FieldValidation().validateOverTime(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.payDate,
              text: AppMessage.payDate,
              keyboardType: TextInputType.datetime,
              mandatoryText: AppMessage.mandatory,
              textEditingController: payRollScreenController.payDateController,
              suffixIcon: Icons.calendar_month,
              onPressed: () {
                _selectDate(
                    context,
                    payRollScreenController.payDate,
                    payRollScreenController.payDateController,
                    DatePickerOption.payDate);
              },
              validate: (value) => FieldValidation().validatePayDayWork(value),
            ),
            const SizedBox(height: 15),
            ButtonModule(),
            const SizedBox(height: 5),
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
      payRollScreenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      // dateTime = d;
      if (d != null) {
        payRollScreenController.isLoading(true);
        textEditingController.text = "${d.year}-${d.month}-${d.day}";
        // dateTime = d;
        if (datePickerOption == DatePickerOption.startDate) {
          payRollScreenController.startDate = d;
        } else if (datePickerOption == DatePickerOption.endDate) {
          payRollScreenController.endDate = d;
        } else {
          payRollScreenController.payDate = d;
        }
        payRollScreenController.isLoading(false);
      }
      payRollScreenController.isLoading(false);
    }
  }
}

class ButtonModule extends StatelessWidget {
  ButtonModule({super.key});
  final payRollScreenController = Get.find<PayRollScreenController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ButtonCustom(
            onPressed: () async {
              if (payRollScreenController.formKey.currentState!.validate()) {}
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
