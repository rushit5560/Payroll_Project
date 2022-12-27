import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/common_loader.dart';
import 'package:payroll_system/controllers/forgot_password_screen_controller.dart';
import 'package:payroll_system/screen/employee_screens/employee_manage_screen/employee_manage_screen_widget.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final forgotPasswordScreenController =
      Get.put(ForgotPasswordScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => forgotPasswordScreenController.isLoading.value
            ? CommonLoader().showLoader()
            : SafeArea(
                child: Form(
                  key: forgotPasswordScreenController.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: forgotPasswordScreenController.emailAddressFieldController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => FieldValidation().validateEmail(value!),
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: AppMessage.emailAddress,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        ButtonCustom(
                          text: 'Submit',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
