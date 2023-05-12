import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/form_single_field_module.dart';
import 'package:payroll/common_modules/new/custom_submit_button_module.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/constants/enums.dart';
import 'package:payroll/controllers/department_manage_screen_controller.dart';
import 'package:payroll/utils/app_images.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/style.dart';
import 'package:payroll/utils/validator.dart';

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
                mandatoryText: AppMessage.mandatory,
                textEditingController: screenController.nameFieldController,
                validate: (value) =>
                    FieldValidation().validateDepartmentName(value),
              ),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    maxLines: null,
                    text: TextSpan(
                        text: AppMessage.status,
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
                            // dropdownColor: Colors.teal,
                            validator: (value) => FieldValidation()
                                .validateDropdownStatus(value!),
                            decoration:
                                const InputDecoration.collapsed(hintText: ''),
                            value: screenController.selectedValue.value,
                            items: screenController.isActiveOptionList
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
                              // This is called when the user selects an item.
                              screenController.selectedValue.value = value!;
                              screenController.loadUI();
                            },
                          ).commonOnlyPadding(
                              left: 10, right: 10, top: 10, bottom: 10),
                        ),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              CustomSubmitButtonModule(
                labelText: AppMessage.submit,
                onPress: () async {
                  if (screenController.formKey.currentState!.validate()) {
                    if (screenController.departmentOption ==
                        DepartmentOption.create) {
                      // if (screenController.selectedValue.value ==
                      //     AppMessage.chooseOption) {
                      //   Fluttertoast.showToast(
                      //       msg: AppMessage.activeStatusMessage);
                      // } else {
                      await screenController.createDepartmentFunction();
                      // }
                    } else {
                      if (screenController.selectedValue.value ==
                          AppMessage.chooseOption) {
                        Fluttertoast.showToast(
                            msg: AppMessage.activeStatusMessage);
                      } else {
                        await screenController.updateDepartmentFunction();
                      }
                    }
                  }
                },
              ),
              /* Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ButtonCustom(
                      onPressed: () async {
                        if(screenController.formKey.currentState!.validate()) {
                          if (screenController.departmentOption == DepartmentOption.create) {
                            if (screenController.selectedValue.value == AppMessage.chooseOption) {
                              Fluttertoast.showToast(
                                  msg: AppMessage.activeStatusMessage);
                            } else  {
                              await screenController.createDepartmentFunction();
                            }
                          }
                          else {
                            if (screenController.selectedValue.value == AppMessage.chooseOption) {
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
              ),*/
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
