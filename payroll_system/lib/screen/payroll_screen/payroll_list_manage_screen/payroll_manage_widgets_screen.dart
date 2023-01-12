import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/common_modules/form_single_field_module.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/controllers/payroll_manage_screen_controller.dart';
import 'package:payroll_system/models/employee_list_screen_models/employee_list_model.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen_widget.dart';

class PayRollManageWidgetsScreen extends StatelessWidget {
  PayRollManageWidgetsScreen({super.key});
  final payRollManageScreenController =
      Get.find<PayRollManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: payRollManageScreenController.formKey,
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
                  payRollManageScreenController.startDateController,
              suffixIcon: Icons.calendar_month,
              onPressed: () async {
                await _selectDate(
                    context: context,
                    dateTime: payRollManageScreenController.startDate,
                    textEditingController:
                        payRollManageScreenController.startDateController,
                    datePickerOption: DatePickerOption.startDate);
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
              textEditingController:
                  payRollManageScreenController.endDateController,
              suffixIcon: Icons.calendar_month,
              onPressed: () async {
                await _selectDate(
                    context: context,
                    dateTime: payRollManageScreenController.endDate,
                    textEditingController:
                        payRollManageScreenController.startDateController,
                    datePickerOption: DatePickerOption.startDate);
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
                      text: " ${AppMessage.mandatory}",
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.redColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ]),
            ).commonSymmetricPadding(vertical: 2),
            // Container(
            //   width: double.infinity,
            //   height: 50,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     border: Border.all(color: AppColors.greyColor),
            //   ),
            //   child: Text(payRollManageScreenController.companyName.toString()),
            // ),
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
                    value: payRollManageScreenController.companyName,
                    items: [payRollManageScreenController.companyName]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) async {
                      // payRollManageScreenController.companyDDSelectedStringItem =
                      //     value!;
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
                  child: DropdownButton<CompanyWiseDepartmentData>(
                    hint: const Text(
                      "Choose Option",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value:
                        payRollManageScreenController.companyWiseDepartmentData,
                    items: payRollManageScreenController
                        .allCompanyWiseEmployeeList
                        .map<DropdownMenuItem<CompanyWiseDepartmentData>>(
                            (CompanyWiseDepartmentData value) {
                      return DropdownMenuItem<CompanyWiseDepartmentData>(
                        value: value,
                        child: Text(value.firstName),
                      );
                    }).toList(),
                    onChanged: (CompanyWiseDepartmentData? value) async {
                      payRollManageScreenController.isLoading(true);

                      payRollManageScreenController.companyWiseDepartmentData =
                          value;
                      payRollManageScreenController.isLoading(false);
                    },
                  ).commonOnlyPadding(left: 10, right: 10),
                ),
              ),
            ),

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
                    value: payRollManageScreenController.selectedValuePayper.value,
                    items: payRollManageScreenController.isPayperList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      payRollManageScreenController.isLoading(true);
                      payRollManageScreenController.hourlyRateController
                          .clear();
                      payRollManageScreenController.regularHourController
                          .clear();
                      payRollManageScreenController.salaryController.clear();
                      payRollManageScreenController.selectedValuePayper.value =
                          value!;
                      payRollManageScreenController.isLoading(false);
                    },
                  ).commonOnlyPadding(left: 10, right: 10),
                ),
              ),
            ),
            const SizedBox(height: 5),

            payRollManageScreenController.selectedValuePayper.value ==
                    AppMessage.hourly
                ? Column(
                    children: [
                      FormSingleFieldModule(
                        headerText: AppMessage.hourlyRate,
                        text: AppMessage.hourlyRate,
                        mandatoryText: AppMessage.mandatory,
                        keyboardType: TextInputType.number,
                        textEditingController:
                            payRollManageScreenController.hourlyRateController,
                        validate: (value) =>
                            FieldValidation().validateHourlyRate(value),
                      ),
                      const SizedBox(height: 5),
                      FormSingleFieldModule(
                        headerText: AppMessage.regularHour,
                        text: AppMessage.regularHour,
                        mandatoryText: AppMessage.mandatory,
                        keyboardType: TextInputType.number,
                        textEditingController:
                            payRollManageScreenController.regularHourController,
                        validate: (value) =>
                            FieldValidation().validateHourlyRate(value),
                      ),
                    ],
                  )
                : payRollManageScreenController.selectedValuePayper.value ==
                        AppMessage.salaryText
                    ? FormSingleFieldModule(
                        headerText: AppMessage.salary,
                        text: AppMessage.salary,
                        mandatoryText: AppMessage.mandatory,
                        keyboardType: TextInputType.number,
                        textEditingController:
                            payRollManageScreenController.salaryController,
                        validate: (value) =>
                            FieldValidation().validateSalary(value),
                      )
                    : Container(),
            payRollManageScreenController.selectedValuePayper.value ==
                    AppMessage.chooseOption
                ? Container()
                : const SizedBox(height: 5),

            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.overTime,
              text: AppMessage.overTime,
              mandatoryText: AppMessage.empty,
              keyboardType: TextInputType.number,
              textEditingController:
                  payRollManageScreenController.overTimeController,
              // validate: (value) => FieldValidation().validateOverTime(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.bonus,
              text: AppMessage.bonus,
              mandatoryText: AppMessage.empty,
              keyboardType: TextInputType.number,
              textEditingController:
                  payRollManageScreenController.bonusController,
              // validate: (value) => FieldValidation().validateOverTime(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.otherEarning,
              text: AppMessage.otherEarning,
              mandatoryText: AppMessage.empty,
              keyboardType: TextInputType.number,
              textEditingController:
                  payRollManageScreenController.otherEarningController,
              // validate: (value) => FieldValidation().validateOverTime(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.commission,
              text: AppMessage.commission,
              mandatoryText: AppMessage.empty,
              keyboardType: TextInputType.number,
              textEditingController:
                  payRollManageScreenController.comissionController,
              // validate: (value) => FieldValidation().validateOverTime(value),
            ),
            const SizedBox(height: 5),
            FormSingleFieldModule(
              headerText: AppMessage.payDate,
              text: AppMessage.payDate,
              keyboardType: TextInputType.datetime,
              mandatoryText: AppMessage.mandatory,
              textEditingController:
                  payRollManageScreenController.payDateController,
              suffixIcon: Icons.calendar_month,
              onPressed: () async {
                await _selectDate(
                    context: context,
                    dateTime: payRollManageScreenController.payDate,
                    textEditingController:
                        payRollManageScreenController.startDateController,
                    datePickerOption: DatePickerOption.startDate);
              },
              validate: (value) => FieldValidation().validatePayDayWork(value),
            ),
            const SizedBox(height: 15),
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
      payRollManageScreenController.isLoading(true);
      textEditingController.text = "${d.year}-${d.month}-${d.day}";
      // dateTime = d;
      if (datePickerOption == DatePickerOption.startDate) {
        payRollManageScreenController.startDate = d;
      } else if (datePickerOption == DatePickerOption.endDate) {
        payRollManageScreenController.endDate = d;
      } else {
        payRollManageScreenController.payDate = d;
      }
      payRollManageScreenController.isLoading(false);
    }
  }
}

class ButtonModule extends StatelessWidget {
  ButtonModule({super.key});
  final payRollManageScreenController =
      Get.find<PayRollManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ButtonCustom(
            onPressed: () async {
              if (payRollManageScreenController.formKey.currentState!
                  .validate()) {}
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
