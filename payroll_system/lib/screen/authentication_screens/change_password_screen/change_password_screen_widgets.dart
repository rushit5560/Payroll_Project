import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/validator.dart';
import 'package:payroll_system/utils/messaging.dart';

import '../../../controllers/change_password_screen_controller.dart';

class LogInCurrentPasswordTextFieldModule extends StatelessWidget {
  LogInCurrentPasswordTextFieldModule({Key? key}) : super(key: key);

  final loginScreenController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: loginScreenController.currentPasswordController,
      validator: (value) => FieldValidation().validateEmail(value!),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        // filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: AppMessage.currentPassword,
      ),
    );
  }
}

class LogInNewPasswordTextFieldModule extends StatelessWidget {
  LogInNewPasswordTextFieldModule({Key? key}) : super(key: key);

  final loginScreenController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: loginScreenController.currentPasswordController,
      validator: (value) => FieldValidation().validateEmail(value!),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        // filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: AppMessage.currentPassword,
      ),
    );
  }
}
