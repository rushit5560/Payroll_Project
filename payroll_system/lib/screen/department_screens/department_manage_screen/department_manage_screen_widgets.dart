import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/custom_alert_dialog_module.dart';
import 'package:payroll_system/common_modules/custom_button_module.dart';
import 'package:payroll_system/common_modules/form_single_field_module.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/department_manage_screen_controller.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:sizer/sizer.dart';

class DepartmentFormModule extends StatelessWidget {
  DepartmentFormModule({Key? key}) : super(key: key);
  final screenController = Get.find<DepartmentManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: screenController.formKey,
          child: Column(
            children: [

              FormSingleFieldModule(
                headerText: AppMessage.departmentName,
                text: AppMessage.departmentName,
                keyboardType: TextInputType.text,
                mandatoryText: '*',
                textEditingController: screenController.nameFieldController,
                validate: (value) => FieldValidation().validateDepartmentName(value),
              ),
              const SizedBox(height: 5),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  RichText(
                    textAlign: TextAlign.left,
                    maxLines: null,
                    text: TextSpan(
                        text: AppMessage.isActive,
                        style: TextStyleConfig.textStyle(
                          fontWeight: FontWeight.w600, fontSize: 16,),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyleConfig.textStyle(
                              textColor: AppColors.redColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ]
                    ),
                  ).commonSymmetricPadding(vertical: 2),

                  /*Text(
                    AppMessage.isActive,
                    style: TextStyleConfig.textStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),
                  ).commonSymmetricPadding(vertical: 2),*/

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
                          value: screenController.selectedValue.value,

                          items: screenController.isActiveOptionList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            screenController.selectedValue.value = value!;

                            screenController.loadUI();
                          },
                        ).commonOnlyPadding(left: 10, right: 10),
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ButtonCustom(
                      onPressed: () async {
                        if(screenController.formKey.currentState!.validate()) {
                          if (screenController.departmentOption == DepartmentOption.create) {
                            if (screenController.selectedValue.value == "Choose Option") {
                              Fluttertoast.showToast(
                                  msg: AppMessage.activeStatusMessage);
                            } else  {
                              await screenController.createDepartmentFunction();
                            }
                          }
                          else {
                            if (screenController.selectedValue.value == "Choose Option") {
                              Fluttertoast.showToast(msg: AppMessage.activeStatusMessage);
                            } else {
                              await screenController.updateDepartmentFunction();
                            }

                          }
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
                      onPressed: () => CustomAlertDialog().showAlertDialog(
                        context: context,
                        textContent: 'Are you sure you want to go to back ?',
                        onYesTap: () {
                          Get.back();
                          Get.back();
                        },
                        onCancelTap: () => Get.back(),
                      ),
                      text: "Back",
                      textsize: 15.sp,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

            ],
          ),
        ),
      ),
    );
  }
}
